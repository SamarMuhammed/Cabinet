


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reidsc/core/services/NotificationsService.dart';
import 'package:reidsc/data/model/Notifications/Notification.dart';
import 'package:reidsc/generic/Helper.dart';
import 'package:reidsc/ui/Reports/ReportsDetailsScreen.dart';
import 'package:reidsc/ui/media/MediaDetailsScreen.dart';
import 'package:reidsc/ui/news/NewsDetailsScreen.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NotificationMenu extends StatefulWidget {

  const NotificationMenu({Key? key}) : super(key: key);


  @override
  _NotificationMenuState createState() => _NotificationMenuState();
}

class _NotificationMenuState extends State<NotificationMenu> {

  late List<IDSCNotification> notifications;
  late List<PopupMenuEntry> items =[];
  int userID = 0;

  Future<List<IDSCNotification>> loadNotifications() async {
  //  print("loadNotifications");
    var not ;
    notifications = await NotificationService().getNotifications();
    var completer = Completer<List<IDSCNotification>>();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    completer.complete(await NotificationService().getNotifications());

    setState(() {
      userID = prefs.getInt("UserID") == null ?0:prefs.getInt("UserID")!;
    //   = not;
      // print("userID$userID");
    });
    return completer.future;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   // loadNotifications();


  }



  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder(
          future: loadNotifications(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

            if ( snapshot.hasData) {
              if(snapshot.data != null)
              return

                PopupMenuButton(


                    icon: Icon(Icons.notifications, color: Colors.black),

                    itemBuilder:
                        (BuildContext context) =>
                    [
                      for (final n in snapshot.data!)
                        PopupMenuItem(

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              ListTile(
                                minLeadingWidth: 8,
                                onTap: () {
                                  goToParent(n.parentId, n.parentName);
                                },
                                leading: Icon(Icons.notifications),
                                title: Text(n.body.toString(), style: TextStyle(
                                    fontSize: 13),),
                              ), Divider(
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),


                    ]);
              else  {

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
            }

            else  {

              return

              Text("");
            }
          });
  }

  void goToParent(int? id, String? parentName) {

    if(parentName == "News") {
      getNewsByID(id).then((value) =>  {  Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) =>
              DetailsScreen(
                newD:value,
              //  userID: this.userID,
              ),
        ),
      )});

    }
    else if(parentName == "Reports") {
      getReportByID(id).then((value) =>  {  Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) =>
              ReportsDetailsScreen(ReportsD: value,userID: this.userID,),
        ),
      )});

    }
    else if(parentName == "Media") {
      getMediaByID(id).then((value) =>  {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => MediaDetails(
                mediaD: value,
                userID: userID,
                Type:value.categoryName!
            ),
          ),
        )
      });

    }
  }




}
