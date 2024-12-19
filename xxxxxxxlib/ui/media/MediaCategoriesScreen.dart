import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/services/MediaService.dart';

import 'package:reidsc/data/model/media/MediaCategory.dart';
import 'package:reidsc/generic/Notifications/NotificationsMenu.dart';
import 'package:reidsc/generic/TabBarWidget.dart';

import 'package:reidsc/ui/media/AudioMediaScreen.dart';
import 'package:reidsc/ui/media/InfoMediaScreen.dart';
import 'package:reidsc/ui/media/VideoMediaScreen.dart';
import 'package:loading_indicator/loading_indicator.dart';


class MediaCategories extends StatefulWidget {
  const MediaCategories({Key? key}) : super(key: key);

  @override
  _MediaCategoriesState createState() => _MediaCategoriesState();
}

class _MediaCategoriesState extends State<MediaCategories>

{
  late List<MediaCategory> tabs=[];
  TabController? _tabController;

  Future<List<MediaCategory>> loadMediaCategories() async{
    var completer = Completer<List<MediaCategory>>();

    tabs =await MediaService().getMainMediaCategories();
    completer.complete(await MediaService().getMainMediaCategories());
    print(tabs.length);

    return completer.future;
     print(tabs.length);

    //  return tabs;

  }

  @override
  void initState() {
    // TODO: implement initState
    loadMediaCategories();
    super.initState();

  }

  @override

  Widget build(BuildContext context) {

    return
      FutureBuilder(
        future: loadMediaCategories(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            print(tabs);
            return   Scaffold(
              appBar: AppBar(
                elevation: 0.0,

                // Here we take the value from the MyHomePage object that was created by
                // the App.build method, and use it to set our appbar title.
                title: Text("Media",style:GoogleFonts.tajawal(textStyle: TextStyle(fontSize: 17.sp))
                  ,),
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                actions: [

                  //NotificationMenu()
                  //  IconButton(onPressed: getNotifications, icon: const Icon(Icons.notifications),color: Colors.black,)
                ],
                titleTextStyle:  TextStyle(
                    color: Colors.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold
                ),
              ),
              body: DefaultTabController(
                length: tabs.length,
                child: Scaffold(
                  appBar: AppBar(

                    elevation: 0,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    bottom: PreferredSize(
                        preferredSize:  Size.fromHeight(50.h),

                        child:

                        TabBarWidget(tabs: tabs,))
                    ,
                    toolbarHeight: 0,
                  ),

                  body:
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: const TabBarView(
                      children: [
                        InfoMedia(),
                        VideoMedia(),
                        AudioMedia(),

                      ],
                    ),
                  ),

                ),
              ),
            );
          }
          else {
            return Scaffold(
              body: Transform.scale(
                scale: 0.1,

                child: Center(
                  child: LoadingIndicator(
                      indicatorType: Indicator.ballRotateChase, /// Required, The loading type of the widget
                      colors: const [Colors.blue],       /// Optional, The color collections
                      strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
                      //backgroundColor: Colors.white,      /// Optional, Background of the widget
                      pathBackgroundColor: Colors.green   /// Optional, the stroke backgroundColor
                  ),
                ),
              ),
            );
          }
        }
        ,
      )
    ;
  }
}

