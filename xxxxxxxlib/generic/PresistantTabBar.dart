import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reidsc/data/model/Topic.dart';
import 'package:reidsc/generic/NetworkCheck.dart';
import 'package:reidsc/generic/TopicWidget.dart';

import 'package:reidsc/ui/Home.dart';
import 'package:reidsc/ui/bookmark/BookmarkScreen.dart';
import 'package:reidsc/ui/intro/TopicsScreen.dart';
import 'package:reidsc/ui/search/searchScreen.dart';
import 'package:reidsc/ui/settings/SettingsScreen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
//import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/TopicService.dart';

class NavBarHome extends StatefulWidget {
  const NavBarHome({Key? key}) : super(key: key);

  @override
  _NavBarHomeState createState() => _NavBarHomeState();
}

class _NavBarHomeState extends State<NavBarHome> {
  late PersistentTabController _controller;
  late int userID;

  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);

    // TODO: implement initState
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      if (!mounted) return;
      setState(() {
        _source = source;
        String status = "";

        switch (_source.keys.toList()[0]) {
          case ConnectivityResult.none:
            status = "Offline";
            print("statusstatus" + status);
            _showMyDialog("none");
            break;
          case ConnectivityResult.mobile:
            status = "Mobile: Online";
            print("statusstatus" + status);
            break;
          case ConnectivityResult.wifi:
            status = "WiFi: Online";
            print("statusstatus" + status);
            break;
          case ConnectivityResult.ethernet:
            status = "Ethernet: Online";
            print("statusstatus" + status);
            break;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,

      controller: _controller,

      screens: _buildScreens(),
      confineInSafeArea: true,
      items: _navBarsItems(),

      navBarStyle: NavBarStyle.style7,
      backgroundColor: const Color(0xffb5102b), // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.

      hideNavigationBarWhenKeyboardShows: false,

      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: false,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),

      //navBarStyle: NavBarStyle.style7, // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
    return [
      const Home(),
      const BookmarkScreen(),
      const SearchScreen(),
      const SettingsScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    var items;

    items = [
      PersistentBottomNavBarItem(
        // inactiveColorSecondary: Colors.red,
        icon: const Icon(Icons.home),
        title: ("Home"),
        onPressed: (v) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (builder) => NavBarHome()));
        },
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        activeColorSecondary: Colors.black,
        //   activeColorSecondary: Color(0xff8F3F71),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.bookmark),
        title: ("Bookmark"),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        activeColorSecondary: Colors.black,
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        title: ("Search"),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        activeColorSecondary: Colors.black,
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: ("Settings"),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        activeColorSecondary: Colors.black,
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      )
    ];

    return items;
  }

  Future<void> _showMyDialog(result) async {
    if (result == "none")
      Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => NetworkCheckScreen()),
      );
  }
}

class MyConnectivity {
  MyConnectivity._internal();

  static final MyConnectivity _instance = MyConnectivity._internal();

  static MyConnectivity get instance => _instance;

  Connectivity connectivity = Connectivity();

  StreamController controller = StreamController.broadcast();

  Stream get myStream => controller.stream;

  void initialise() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkStatus(result);
    connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
      } else {
        isOnline = false;
      }
    } on SocketException catch (_) {
      isOnline = false;
    }
    controller.sink.add({result: isOnline});
  }

  void disposeStream() => controller.close();
}
