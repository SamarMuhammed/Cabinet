import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
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

  MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      /*         onItemSelected: (index)
         {
         pushNewScreen(
              context,
              screen: MainScreen(),
              withNavBar: true, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
            Navigator.of(context, rootNavigator: true).push( CupertinoPageRoute<bool>(
                fullscreenDialog: true,builder: (builder)=>_buildScreens()[index]));
          },*/
      controller: _controller,
      //   itemCount:4,
      screens: _buildScreens(),
      //    items: _navBarsItems(),
      confineInSafeArea: true,
      items: _navBarsItems(),

      navBarStyle: NavBarStyle.style7,
      backgroundColor: const Color(0xffb5102b), // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.

      hideNavigationBarWhenKeyboardShows: false,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      //  decoration: NavBarDecoration(
      //   borderRadius: BorderRadius.only(topLeft:  Radius.circular(10),topRight:   Radius.circular(10)
      //       ,bottomRight:  Radius.zero,bottomLeft:  Radius.zero),
      //    colorBehindNavBar: Colors.white,
      //   ),
      //  popAllScreensOnTapOfSelectedTab: true,
      // popActionScreens: PopActionScreensType.all,
      //itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
      //duration: Duration(milliseconds: 200),
      //curve: Curves.ease,
      //),
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
        title: ('nav_home'.tr()),
        onPressed: (v) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (builder) => NavBarHome()));
        },
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        activeColorSecondary: Colors.black,
        //   activeColorSecondary: Color(0xff8F3F71),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
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
        title: ('nav_bookmark'.tr()),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        activeColorSecondary: Colors.black,
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        title: ('nav_search'.tr()),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        activeColorSecondary: Colors.black,
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: ('nav_settings'.tr()),
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

  StreamController controller = StreamController.broadcast();

  Stream get myStream => controller.stream;

  void disposeStream() => controller.close();
}
