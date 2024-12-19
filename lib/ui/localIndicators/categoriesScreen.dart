import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:reidsc/data/model/Indicators/IndCategory.dart';
import 'package:reidsc/core/services/LocalIndicatorsService.dart';
import 'package:reidsc/generic/Notifications/NotificationsMenu.dart';
import 'package:reidsc/generic/TabBarWidget.dart';
import 'package:reidsc/ui/interIndicators/categoriesScreen.dart';
import 'package:reidsc/ui/localIndicators/localIndicatorsScreen.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LocalIndCategories extends StatefulWidget {
  final String selectedTopics;

  const LocalIndCategories({Key? key, required this.selectedTopics})
      : super(key: key);

  @override
  _LocalIndCategoriesState createState() => _LocalIndCategoriesState();
}

class _LocalIndCategoriesState extends State<LocalIndCategories> {
  late List<IndCategory> tabs;
  TabController? _tabController;

  Future<List<IndCategory>> loadCategories() async {
    var completer = Completer<List<IndCategory>>();

    tabs = await LocalIndService().getMainIndCategories();
    completer.complete(await LocalIndService().getMainIndCategories());

    return completer.future;
    // print(tabs.length);

    //  return tabs;
  }

  @override
  void initState() {
    // TODO: implement initState
    loadCategories();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadCategories(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          print(tabs);
          return Scaffold(
            backgroundColor: Color(0xffF4F4F4),
            appBar: AppBar(
              elevation: 0.0,

              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Text("Indicators",
                  style: GoogleFonts.tajawal(
                      textStyle: TextStyle(fontSize: 18.sp))),
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              actions: [
                //NotificationMenu()
                //  IconButton(onPressed: getNotifications, icon: const Icon(Icons.notifications),color: Colors.black,)
              ],
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold),
            ),
            body: DefaultTabController(
              length: tabs.length,
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  bottom: PreferredSize(
                      preferredSize: Size.fromHeight(50.h),
                      child: TabBarWidget(
                        tabs: tabs,
                      )),
                  toolbarHeight: 0,
                ),
                body: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: TabBarView(
                    children: [
                      LocalIndicators(selectedTopics: widget.selectedTopics),
                      InterCategoriesScreen(
                        index: 0,
                        selectedTopics: widget.selectedTopics,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Transform.scale(
              scale: 0.1,
              child: Center(
                child: LoadingIndicator(
                    indicatorType: Indicator.ballRotateChase,

                    /// Required, The loading type of the widget
                    colors: const [Colors.blue],

                    /// Optional, The color collections
                    strokeWidth: 2,

                    /// Optional, The stroke of the line, only applicable to widget which contains line
                    //backgroundColor: Colors.white,      /// Optional, Background of the widget
                    pathBackgroundColor: Colors.green

                    /// Optional, the stroke backgroundColor
                    ),
              ),
            ),
          );
        }
      },
    );
  }
}
