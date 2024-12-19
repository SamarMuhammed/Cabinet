import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/services/SettingService.dart';
import 'package:reidsc/data/model/setting/Settings.dart';
import 'package:reidsc/generic/Notifications/NotificationsMenu.dart';
import 'package:reidsc/ui/settings/AboutScreen.dart';
import 'package:reidsc/ui/settings/GeneralSettingsScreen.dart';
import 'package:reidsc/ui/settings/SourcesScreen.dart';
import 'package:reidsc/ui/settings/SwitchbuttonWidget.dart';
import 'package:reidsc/ui/settings/deleteAccount.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

bool _switchValue = true;
const primaryColor = Color(0xFFffffff);
late bool switchControl;

late SharedPreferences prefs;
String? _version;

class _SettingsScreenState extends State<SettingsScreen> {
  late List<Settings> settingslist = [];

  loadSources() async {
    var list = await SettingsService().getSettings();

    setState(() {
      settingslist = list;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    loadSources();
    _getAppVersion();
    getPref();
    super.initState();
  }

  void _getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    final version = packageInfo.version;

    setState(() {
      _version = version;

      //_installerStore = installerStore;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          "الإعدادات",
          style: TextStyle(fontSize: 17, fontFamily: 'Cairo'),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          NotificationMenu()
          //  IconButton(onPressed: getNotifications, icon: const Icon(Icons.notifications),color: Colors.black,)
        ],
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      body: Container(
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: settingslist.length,
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          if (settingslist[index].type != "Radio" &&
                              settingslist[index].eName != "Sources" &&
                              settingslist[index].eName != "Contact" &&
                              settingslist[index].eName != "Delete")
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => GeneralSettingsScreen(
                                          settingD: settingslist[index],
                                        )));
                          else if (settingslist[index].eName == "Sources")
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => SourcesScreen()));
                          else if (settingslist[index].eName == "Delete")
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => deleteAccountScreen(),
                                ));
                          //   Navigator.push(context, MaterialPageRoute(builder: (builder)=>deleteAccountScreen()));
                          else if (settingslist[index].eName == "Contact")
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => AboutScreen()));
                        },
                        child: Row(
                          children: [
                            if (settingslist[index].type != "Radio")
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 33, top: 30),
                                child: AutoSizeText(
                                  settingslist[index].name.toString(),
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      // fontFamily: GoogleFonts.tajawal().fontFamily,

                                      fontSize: 18.sp),
                                  minFontSize: 18,
                                  maxFontSize: 24,
                                ),
                              )
                            else
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 33, right: 33),
                                    child: AutoSizeText(
                                      settingslist[index].name.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          //fontFamily: GoogleFonts.tajawal().fontFamily,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.sp,
                                          fontFamily: 'Cairo'),
                                      minFontSize: 18,
                                      maxFontSize: 24,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 170,
                                      top: 32,
                                    ),
                                    child: SwitchWidget(
                                      switchControl: switchControl,
                                    ),
                                  ),
                                ],
                              )
                          ],
                        ),
                      )),
            ),
            Center(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'رقم الإصدارة: ${_version ?? '-'}',
                  style: TextStyle(
                      color: Color(0xff8f3f71),
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.tajawal().fontFamily,
                      fontSize: 18.sp),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getPref() async {
    prefs = await SharedPreferences.getInstance();

    // var res = true;
    setState(() {
      switchControl = (prefs.getBool("notification") == null
          ? true
          : prefs.getBool("notification"))!;
    });
  }
}
