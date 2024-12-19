import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/services/MainCategoryService.dart';
import 'package:reidsc/core/services/TopicService.dart';
import 'package:reidsc/data/model/TopicPost.dart';
import 'package:reidsc/generic/Notifications/NotificationsMenu.dart';
import 'package:reidsc/generic/PresistantTabBar.dart';
import 'package:reidsc/generic/TopicWidget.dart';
import 'package:reidsc/data/model/Topic.dart';
import 'package:reidsc/main.dart';
import 'package:reidsc/ui/Home.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopicsScreen extends StatefulWidget {
  TopicsScreen({Key? key, required this.previousPage}) : super(key: key);
  final String previousPage;
  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen>
    with SingleTickerProviderStateMixin {
  List<int> selectedIndexList = <int>[];
  var userID = 0;
  List<String> selectedID = <String>[];
  late var mylist;
  late List<Topic> topicList;
  var mainCategoryLoaded = false;
  late SharedPreferences prefs;
  Future<List<Topic>> loadTopics() async {
    var completer = new Completer<List<Topic>>();

    topicList = await TopicService().getTopics();
    completer.complete(await TopicService().getTopics());

    return completer.future;
    // print(tabs.length);

    //  return tabs;
  }

  /* loadTopics() async {
    topicList = await TopicService().getTopics();
    setState(() {
      mainCategoryLoaded = true;
    });
  }*/

  void loginStatus() async {
    prefs = await SharedPreferences.getInstance();

    userID = prefs.getInt("UserID") == null ? 0 : prefs.getInt("UserID")!;
    setState(() {
      var savedTopics = prefs.getString("SavedTopics") == null
          ? ""
          : prefs.getString("SavedTopics").toString();
      if (savedTopics != "") {
        final topics = savedTopics.split(',');
        for (int i = 0; i < topics.length; i++) {
          selectedIndexList.add(int.parse(topics[i]));
        }
      } else {
        selectedIndexList = [];
      }
    });

    print(userID);
  }

  Future<bool> _onWillPop() async {
    // This dialog will exit your app on saying yes
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadTopics();
    loginStatus();
  }

  //late final _tabController = TabController(length: 1, vsync: this);
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadTopics(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            print(topicList);
            return Scaffold(
              appBar: AppBar(
                elevation: 0.0,

                // Here we take the value from the MyHomePage object that was created by
                // the App.build method, and use it to set our appbar title.
                title: Text("حدد القطاعات التي تُهمك",
                    style: TextStyle(fontSize: 17.sp, fontFamily: 'Cairo')),
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                actions: [
                  NotificationMenu()
                  //  IconButton(onPressed: getNotifications, icon: const Icon(Icons.notifications),color: Colors.black,)
                ],
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold),
              ),
              bottomNavigationBar: Material(
                color: const Color(0xff8F3F71),
                child: InkWell(
                  onTap: () {
                    print('done');
                    _onContinue(widget.previousPage);
                    print("okk");
                  },
                  child: const SizedBox(
                    height: kToolbarHeight,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'إٍستمرار',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Cairo'),
                      ),
                    ),
                  ),
                ),
              ),
              body: Container(
                child: topicList.isNotEmpty
                    ? GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1 / 1,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                        ),
                        shrinkWrap: true,
                        primary: true,
                        scrollDirection: Axis.vertical,
                        itemCount: topicList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 10.0.r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                GestureDetector(
                                    onTap: () {
                                      // String TopicID=   topicList[index].id!.toString();
                                      // What do i do here?
                                      if (!selectedIndexList
                                          .contains(topicList[index].id)) {
                                        setState(() {
                                          selectedIndexList
                                              .add(topicList[index].id!);
                                        });

                                        // selectedID.add(topicList[index].id!.toString());
                                        /*    String finalStr = selectedID.reduce((value, element) {
                            return value + element;
                          });
                          print(finalStr);*/
                                      } else {
                                        setState(() {
                                          selectedIndexList
                                              .remove(topicList[index].id!);
                                        });

                                        //  selectedID.remove(topicList[index].id!.toString());

                                        // print(mylist);
                                      }
                                    },
                                    child: selectedIndexList.contains(topicList[
                                                index]
                                            .id)
                                        ? TopicWidget(
                                            title: topicList[index].name!,
                                            imageURL:
                                                "${topicList[index].checkedImage}",
                                            width: MediaQuery
                                                        .of(context)
                                                    .size
                                                    .width /
                                                3.5,
                                            height: MediaQuery
                                                        .of(context)
                                                    .size
                                                    .height /
                                                3)
                                        : TopicWidget(
                                            title: topicList[index].name!,
                                            imageURL:
                                                "${topicList[index].unCheckedImage}",
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3)),
                              ],
                            ),
                          );
                        },
                      )
                    : const Text("Loading"),
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
        });
  }

  void _onContinue(previousPage) async {
    print("Saved Topics");
    var t;
    setState(() {
      mylist =
          selectedIndexList.toString().replaceAll("]", "").replaceAll("[", "");
      //  print(selectedIndexList);
      //  print( topicList[index].id);
      print("topiiiiiiiiiics" + mylist);
      // print(mylist);
      // if(selectedIndexList.length == 0)
      //  selectedIndexList.add(1);
      t = TopicPost(
        topicsIds: mylist.toString(),
        userID: userID,
      );
      prefs.setString("SavedTopics", mylist);
      print(t.toJson());
    });
    print(userID);

    bool res = await TopicService().addUserTopic(t);

    print(res);
    print(t.topicsIds);
    //Navigator.pop(context);
    if (res) if (previousPage == "Home")
      Navigator.push(context, MaterialPageRoute(builder: (builder) => Home()));
    else
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => NavBarHome()));
  }
/*  getValues() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool val = prefs.getBool('Checked');
    setState(() {
      _todoList[0].isChecked = val?? false;
    });
  }*/
}
