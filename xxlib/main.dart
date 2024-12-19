import 'dart:async';
import 'dart:convert';

import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:reidsc/core/services/NotificationsService.dart';
import 'package:reidsc/core/services/UserService.dart';
import 'package:reidsc/data/model/News.dart';
import 'package:reidsc/data/model/Notifications/Notification.dart';
import 'package:reidsc/data/model/user/UserInterest.dart';
import 'package:reidsc/generic/Helper.dart';
import 'package:reidsc/generic/PresistantTabBar.dart';

import 'package:reidsc/ui/Home.dart';
import 'package:reidsc/ui/Reports/ReportsDetailsScreen.dart';
import 'package:reidsc/ui/addUser/Login.dart';
import 'package:reidsc/ui/bookmark/BookmarkScreen.dart';
import 'package:reidsc/ui/localIndicators/chartScreen.dart';
import 'package:reidsc/ui/media/MediaDetailsScreen.dart';
import 'package:reidsc/ui/news/NewsDetailsScreen.dart';
import 'package:reidsc/ui/search/searchScreen.dart';
import 'package:reidsc/ui/settings/AboutScreen.dart';
import 'package:reidsc/ui/settings/SettingsScreen.dart';
import 'package:reidsc/ui/test.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:upgrader/upgrader.dart';
import 'firebase_options.dart';

const debug = true;
bool ActiveConnection = false;
String T = "";
var mainPages = [
  const Home(),
  const BookmarkScreen(),
  const SearchScreen(),
  const SettingsScreen()
];
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future CheckUserConnection() async {
  try {
    await Upgrader.clearSavedSettings();

    final result = await InternetAddress.lookup('https://www.google.com');
    print("InternetAddress" + result.isNotEmpty.toString());
    print("InternetAddress" + result[0].rawAddress.isNotEmpty.toString());
    if (result.isNotEmpty) {
      ActiveConnection = true;
      T = "Turn off the data and repress again";
    }
  } on SocketException catch (_) {
    ActiveConnection = true;
    //  ActiveConnection = false;
    T = "Turn On the data and repress again";
  }
  /* showDialog(
        context: context,

        builder: (BuildContext context) {
          return AlertDialog(
            content: new Text(T),
          );
        });*/
  print(T);
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  //await Upgrader.clearSavedSettings(); // REMOVE this for release builds

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  CheckUserConnection();

  FirebaseMessaging.instance.subscribeToTopic("IDSC");

  // final messaging = FirebaseMessaging.instance.getInitialMessage();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //final SharedPreferences prefs = await SharedPreferences.getInstance();
  var userID = 0;

  //AndroidDeviceInfo info = await deviceInfo.androidInfo;f
  // print("version "+info.androidId.toString());
  // print("version1 "+deviceId.toString());
  // print("board "+info.getID().toString());

  userID = prefs.getInt("UserID") == null ? 0 : prefs.getInt("UserID")!;
  FirebaseMessaging.instance.getInitialMessage().then(
    (dynamic message) {
      if (message != null) {
        Future.delayed(const Duration(seconds: 7), () async {
          var type = message?.data["Type"].toString();

          if (type == "News") {
            int id = int.parse(message!.data["ID"].toString());

            //  print("If News " + userID.toString());

            getNewsByID(id).then((value) => {gotoNews(value, userID)});
          } else if (type == "Reports") {
            int id = int.parse(message!.data["ID"].toString());

            // print("Sssssss " + userID.toString());
            getReportByID(id).then((value) => {gotoReports(value, userID)});
          } else if (type == "Media") {
            int id = int.parse(message!.data["ID"].toString());

            getMediaByID(id).then((value) => {gotoMedia(value, userID)});
          } else if (type == "Indicators") {
            int subCatID = int.parse(message!.data["subCatID"].toString());
            String subCatName = message!.data["subCatName"].toString();
            gotoIndicators(subCatID, subCatName);
          } else if (type == "InterIndicators") {
            int index = int.parse(message!.data["index"].toString());

            gotoInterIndicators(index);
          } else if (type == "Prices") {
            int subCatID = int.parse(message!.data["subCatID"].toString());
            String subCatName = message!.data["subCatName"].toString();
            String unit = message!.data["unit"].toString();
            String dailyPrice = message!.data["dailyPrice"].toString();
            String yearlyPrice = message!.data["yearlyPrice"].toString();

            gotoPrices(subCatID, subCatName, unit, dailyPrice, yearlyPrice);
          }
        });
      }
    },
  );
/*messaging.then((mesage)
    {
print("zzzzzzzeft");
print(mesage);
    });
*/
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title

    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  const LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(
    defaultActionName: 'hello',
  );
  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      linux: initializationSettingsLinux);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Getting the token makes everything work as expected
  /* await _firebaseMessaging
      .getToken()
      .then((String? token) {
    assert(token != null);
  });*/

  await FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');

    print('Message data: ${message.data}');
    // var type = message.data["hi"].toString()
    //     print(message.data["hi"].toString());
    var type = message.data["Type"].toString();
    int id = int.parse(message.data["ID"].toString());
    print(type.toString() + "  " + id.toString());
    if (type == "News") {
      print("If News " + userID.toString());

      getNewsByID(id).then((value) => {gotoNews(value, userID)});
    } else if (type == "Reports") {
      print("Sssssss " + userID.toString());
      getReportByID(id).then((value) => {gotoReports(value, userID)});
    } else if (type == "Media") {
      getMediaByID(id).then((value) => {gotoMedia(value, userID)});
    } else if (type == "Indicators") {
      int subCatID = int.parse(message.data["subCatID"].toString());
      String subCatName = message.data["subCatName"].toString();
      gotoIndicators(subCatID, subCatName);
    } else if (type == "InterIndicators") {
      int index = int.parse(message.data["index"].toString());

      gotoInterIndicators(index);
    } else if (type == "Prices") {
      int subCatID = int.parse(message.data["subCatID"].toString());
      String subCatName = message.data["subCatName"].toString();
      String unit = message.data["unit"].toString();
      String dailyPrice = message.data["dailyPrice"].toString();
      String yearlyPrice = message.data["yearlyPrice"].toString();

      gotoPrices(subCatID, subCatName, unit, dailyPrice, yearlyPrice);
    }

    //print(message.notification);
    if (message.notification != null) {
      // print('Message also contained a notification: ${message.notification}');
      //print(message.data.toString());

      //  PushNotification notification = PushNotification(
      //  title: message.notification?.title,
      // body: message.notification?.body,
      //);

      RemoteNotification notification = message.notification!;
      AndroidNotification androidNotification = message.notification!.android!;

      if (notification != null && androidNotification != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                //  channel.description,
                icon: androidNotification?.smallIcon,
                // other properties...
              ),
            ));
        //   sendNotification(title: notification.title!, body: notification.body,notification: notification);
      }
    }
  });

  await FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    // var type = message.data["hi"].toString()
    //     print(message.data["hi"].toString());
    var type = message.data["Type"].toString();

    if (type == "News") {
      int id = int.parse(message.data["ID"].toString());

      print("If News " + userID.toString());
      getNewsByID(id).then((value) => {gotoNews(value, userID)});
    } else if (type == "Reports") {
      int id = int.parse(message.data["ID"].toString());

      print("Sssssss " + userID.toString());
      getReportByID(id).then((value) => {gotoReports(value, userID)});
    } else if (type == "Media") {
      int id = int.parse(message.data["ID"].toString());

      getMediaByID(id).then((value) => {gotoMedia(value, userID)});
    } else if (type == "Indicators") {
      int subCatID = int.parse(message.data["subCatID"].toString());
      String subCatName = message.data["subCatName"].toString();
      gotoIndicators(subCatID, subCatName);
    } else if (type == "InterIndicators") {
      int index = int.parse(message.data["index"].toString());

      gotoInterIndicators(index);
    } else if (type == "Prices") {
      int subCatID = int.parse(message.data["subCatID"].toString());
      String subCatName = message.data["subCatName"].toString();
      String unit = message.data["unit"].toString();
      String dailyPrice = message.data["dailyPrice"].toString();
      String yearlyPrice = message.data["yearlyPrice"].toString();

      gotoPrices(subCatID, subCatName, unit, dailyPrice, yearlyPrice);
    }

    print(message.notification);
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
      print(message.data.toString());

      //  PushNotification notification = PushNotification(
      //  title: message.notification?.title,
      // body: message.notification?.body,
      //);
    }
  });

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  print("userID " + userID.toString());
  print("ActiveConnection " + ActiveConnection.toString());
//ActiveConnection = true;
  await Upgrader.clearSavedSettings();

  if (userID != 0) {
    var user = await UserService().getUserById(userId: userID);

    // await prefs.setString("Token",user.token!);
    print("user " + user.id.toString());
    print("usersavedTopics " + user.savedTopics.toString());
    var SavedTopics = user.savedTopics.toString();
    prefs.setString("SavedTopics", SavedTopics);
    runApp(MyApp(
      userID: userID,
    ));
  } else if (userID == 0) {
    var deviceId;
    /*  if(Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor;
      }
      else if(Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.androidId;
        print(androidInfo.androidId);

      }*/

    deviceId = await PlatformDeviceId.getDeviceId;
    //   showMyDialog(deviceId);
    print("elseeeeeee");

    //   var deviceId = await PlatformDeviceId.getDeviceId;

    print("deviceId.toString() " + deviceId.toString());
    await UserService()
        .getUserByDeviceId(deviceId: deviceId.toString())
        .then((value) => goToHome(value));
    print("after call");
    // var user = await UserService().getUserByDeviceId(deviceId: deviceId.toString());
    //  print(user);
  }
}

void showMyDialog(msg) {
  showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => Center(
            child: Material(
              color: Colors.transparent,
              child: Text(msg),
            ),
          ));
}

goToHome(UserInterest? user) async {
  var userID;
  if (user != null) {
    userID = user.id!;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('UserID', userID);
    var SavedTopics = user.savedTopics.toString();
    prefs.setString("SavedTopics", SavedTopics);
    print("widget.userID " + userID.toString());
  } else {
    userID = 0;
  }
  //showMyDialog(userID);
  runApp(MyApp(
    userID: userID,
  ));
}

void sendNotification(
    {String? title, String? body, RemoteNotification? notification}) async {
  print("Entered");

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  ////Set the settings for various platform
  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  const LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(
    defaultActionName: 'hello',
  );
  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      linux: initializationSettingsLinux);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  ///
}

class MyApp extends StatefulWidget {
  final int userID;
  const MyApp({Key? key, required this.userID}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appcastURL, minAVersionNo;
    if (Platform.isIOS) {
      appcastURL = 'https://new.idscapp.gov.eg/upgrade/ios.xml';
      minAVersionNo = '1.2.2';
    } else if (Platform.isAndroid) {
      appcastURL = 'http://new.idscapp.gov.eg/upgrade/android.xml';
      minAVersionNo = '1.1.30';
    }
    final cfg =
        AppcastConfiguration(url: appcastURL, supportedOS: ['android', 'ios']);

    // final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);
    // 375x812
    return ScreenUtilInit(
      //designSize: Size(360, 690),

      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return OverlaySupport(
          child: MaterialApp(
            builder: (context, child) => ResponsiveBreakpoints.builder(
              child: child!,
              breakpoints: [
                const Breakpoint(start: 0, end: 375, name: MOBILE),
                const Breakpoint(start: 375, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
              ],
            ),
            initialRoute: '/',
            navigatorKey: navigatorKey,
            debugShowMaterialGrid: false,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en', ''), Locale('ar', '')],
            locale: const Locale('ar', ''),
            title: 'idsc',
            theme: ThemeData(fontFamily: 'Cairo'),
            debugShowCheckedModeBanner: false,
            home: widget.userID == 0
                ? Login()
                : UpgradeAlert(
                    upgrader: Upgrader(
                      appcastConfig: cfg,

                      //   durationUntilAlertAgain: Duration.zero,
                      showIgnore: false,
                      messages: UpgraderMessages(code: 'ar'),
                      canDismissDialog: false,
                      showLater: false,
                      dialogStyle: UpgradeDialogStyle.cupertino,
                      //   minAppVersion:minAVersionNo ,
                      debugLogging: true,
                    ),
                    child: NavBarHome()),
          ),
        );
      },
    );
//home: Login());
    //  home: const Scaffold(

    // textDirection: TextDirection.rtl,
    // body: MyHomePage(title: "fff",)),
    //);
  }

  Future isLogged(context) async {}
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String title = "";
  var selectedIndex = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  // final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  late PersistentTabController _controller;
  late List<IDSCNotification> notifications;
  void loadNotifications() async {
    notifications = await NotificationService().getNotifications();
  }

  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    //   CheckUserConnection().then((value) =>   initConnectivity());

    super.initState();
    // _connectivitySubscription =
    //    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    // TODO: implement initState
    _controller = PersistentTabController(initialIndex: 0);
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
    setState(() {
      title = _navBarsItems()[_controller.index].title.toString();
      loadNotifications();
      print(title);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    var appcastURL, minAVersionNo;
    if (Platform.isIOS) {
      appcastURL = 'https://new.idscapp.gov.eg/upgrade/ios.xml';
      minAVersionNo = '1.2.2';
    } else if (Platform.isAndroid) {
      appcastURL = 'https://new.idscapp.gov.eg/upgrade/android.xml';
      minAVersionNo = '1.1.30';
    }
    final cfg =
        AppcastConfiguration(url: appcastURL, supportedOS: ['android', 'ios']);

    return Scaffold(
      body: NavBarHome(),
    );
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _showMyDialog(result) async {
    if (result == "none")
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("خطأ"),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('من فضلك قُم بالإتصال بالإنترنت'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('تأكيد'),
                onPressed: () {
                  SystemChannels.platform
                      .invokeMethod<void>('SystemNavigator.pop');
                },
              ),
            ],
          );
        },
      );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  /* Future<void> initConnectivity() async {
    print("enter fn");
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
      print("ghadaaa "+result.name);
      if(result == ConnectivityResult.none)
        _showMyDialog(result.name);
    } on PlatformException catch (e) {
    //  _showMyDialog("error");
      //   developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }*/

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      _showMyDialog(_connectionStatus.name);
    });
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    var items;

    items = [
      PersistentBottomNavBarItem(
        // inactiveColorSecondary: Colors.red,
        icon: const Icon(Icons.home),
        title: ("الرئيسية"),
        onPressed: (v) {},
        textStyle: const TextStyle(fontSize: 14),
        activeColorSecondary: Colors.white,
        //   activeColorSecondary: Color(0xff8F3F71),
        activeColorPrimary: const Color(0xff8F3F71),
        inactiveColorPrimary: CupertinoColors.systemGrey,
        /*   routeAndNavigatorSettings: RouteAndNavigatorSettings(
            onGenerateRoute: (RouteSettings settings) {

              WidgetBuilder builder;
              // Manage your route names here
              switch (settings.name) {

                case '/home':
                  print("homeRoute");
                  builder = (BuildContext context) => Home();
                  break;
                default:
                  throw Exception('Invalid route: ${settings.name}');

              }
              return MaterialPageRoute(
                builder: builder,
                settings: settings,
              );
            },
          ),*/
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.bookmark),
        title: ("المُفضلة"),
        textStyle: const TextStyle(fontSize: 14),
        activeColorSecondary: Colors.white,
        activeColorPrimary: const Color(0xff8F3F71),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        title: ("بحث"),
        textStyle: const TextStyle(fontSize: 14),
        activeColorSecondary: Colors.white,
        activeColorPrimary: const Color(0xff8F3F71),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: ("الإعدادات"),
        textStyle: const TextStyle(fontSize: 14),
        activeColorSecondary: Colors.white,
        activeColorPrimary: const Color(0xff8F3F71),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      )
    ];

    return items;
  }
}
