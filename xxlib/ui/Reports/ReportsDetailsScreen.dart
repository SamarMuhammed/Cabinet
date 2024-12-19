import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/services/ReportsService.dart';
import 'package:reidsc/core/services/UserService.dart';
import 'package:reidsc/data/model/AllReports.dart';
import 'package:reidsc/data/model/Indicators/InterIndData.dart';
import 'package:reidsc/ui/Reports/ChainDetailsScreen.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportsDetailsScreen extends StatefulWidget {
  const ReportsDetailsScreen(
      {Key? key, required this.ReportsD, required this.userID})
      : super(key: key);
  final Reports ReportsD;
  final int userID;

  @override
  State<ReportsDetailsScreen> createState() => _ReportsDetailsScreenState();
}

class _ReportsDetailsScreenState extends State<ReportsDetailsScreen> {
  ReceivePort _port = ReceivePort();

  List<String> result = [];
  int progress = 0;
  late List<String> bookmarks = [];
  late List<int> intbookmarks = [];
  bool isBookmarked = false;
  late String topictest;

  static late String taskId;

  void getUserSavedReports() async {
    final userItems = await UserService().getUserById(userId: widget.userID);
    print(userItems);
    topictest = userItems.savedTopics.toString();
    setState(() {
      String bookmarkedreports = userItems.savedReports.toString();
      bookmarks = bookmarkedreports.split(',');
      print(bookmarks.length);
      print(bookmarks[0]);
      intbookmarks = bookmarks.map(int.parse).toList();
      print(intbookmarks.length);
      print(intbookmarks[0]);
      print(topictest);
      print("byyyyyye");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserSavedReports();

    super.initState();
    String text = widget.ReportsD.hashtags.toString();
    result = text.split(',');
    // msg=  NewsService().bookmarkNews(userID: 1, parentID: int.parse(widget.newD.id.toString()));
    // print(msg);
    print("Hashtag " + result[0]);
    //  FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("تفاصيل الإصدارة",
            style: TextStyle(fontSize: 17, fontFamily: 'Cairo')),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,

        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios,
                textDirection: TextDirection.ltr),
            color: Colors.black,
          )
        ],
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: Container(
                                height: MediaQuery.of(context).size.height / 15,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.black38,
                                ),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Text(
                                      widget.ReportsD.createDate.toString(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ))),
                        Expanded(
                          flex: 2,
                          child: Container(
                              padding: EdgeInsets.all(10),
                              decoration:
                                  BoxDecoration(color: Color(0xffDCB265)),
                              child: IconButton(
                                  onPressed: () async {
                                    getDialog(context);
                                    // await openAttach(widget.ReportsD.attachment.toString());
                                  },
                                  icon: Align(
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.download,
                                        color: Colors.white,
                                        size: 30,
                                      )))),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(color: Color(0xff384153)),
                            child: IconButton(
                                onPressed: () async {
                                  //  Share.share(newD.title.toString());
                                  final urlimage =
                                      widget.ReportsD.image.toString();
                                  final url = Uri.parse(urlimage);
                                  final response = await get(url);
                                  final bytes = response.bodyBytes;
                                  final Directory temp =
                                      await getTemporaryDirectory();
                                  final path = '${temp.path}/Image.jpg';
                                  File(path).writeAsBytesSync(bytes);
                                  await Share.shareFiles([path],
                                      text:
                                          '${widget.ReportsD.title.toString()} ${widget.ReportsD.attachment.toString()} '
                                          ' تطبيق IDSC'
                                          '\n https://onelink.to/eqzrkm');
                                  //  Share.shareFiles(['http://41.128.217.181:10092/images/topics/unchecked/culture.png'], text: newD.title.toString());
                                },
                                icon: const Icon(
                                  Icons.share,
                                  color: Colors.white,
                                  size: 30,
                                )),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color(0xff1D1066),
                              ),
                              child: IconButton(
                                  onPressed: () async {
                                    if (intbookmarks
                                            .contains(widget.ReportsD.id) ==
                                        true) {
                                      var msg = await ReportsService()
                                          .unBookmarkReports(
                                              userID: widget.userID,
                                              parentID: int.parse(widget
                                                  .ReportsD.id
                                                  .toString()));

                                      //  print(msg);
                                      setState(() {
                                        intbookmarks.remove(widget.ReportsD.id);
                                        (intbookmarks
                                                .contains(widget.ReportsD.id) ==
                                            false);
                                        getUserSavedReports();
                                      });
                                      return showDialog<void>(
                                        context: context,
                                        barrierDismissible: false,
                                        // user must tap button!
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('نجاح'),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  Text(msg),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('حسنا'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else if (intbookmarks
                                            .contains(widget.ReportsD.id) ==
                                        false) {
                                      var msg = await ReportsService()
                                          .bookmarkReports(
                                              userID: widget.userID,
                                              parentID: int.parse(widget
                                                  .ReportsD.id
                                                  .toString()));
                                      //  print(msg);
                                      setState(() {
                                        (intbookmarks
                                                .contains(widget.ReportsD.id) ==
                                            true);
                                        getUserSavedReports();
                                      });
                                      return showDialog<void>(
                                          context: context,
                                          barrierDismissible:
                                              false, // user must tap button!
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('نجاح'),
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: <Widget>[
                                                    Text(msg),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('حسنا'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    }
                                  },
                                  icon:
                                      intbookmarks.contains(widget.ReportsD.id)
                                          ? Icon(
                                              Icons.bookmark,
                                              color: Colors.white,
                                              size: 30,
                                            )
                                          : Icon(
                                              Icons.bookmark_outline,
                                              color: Colors.white,
                                              size: 30,
                                            ))),
                        ),
                      ],
                    ),
                  ),
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.height / 2
                          : MediaQuery.of(context).size.height / 1.2,

                  //    height: MediaQuery.of(context).size.height/2.3 ,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.ReportsD.image.toString()),
                        fit: BoxFit.fill),
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              padding: EdgeInsets.all(20),
              child: ListView(
                children: [
                  widget.ReportsD.hashtags == ""
                      ? Text("")
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              for (var item in result)
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: InputChip(
                                    label: Text(item),
                                    labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    disabledColor: Color(0xffbde3e7),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                  ),
                                ),
                            ],
                          ),
                        ),
                  Text(
                    widget.ReportsD.title.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        height: 1.5, // the height between text, default is null
                        letterSpacing: 1.0),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    child: Text(
                      " من سلسلة : ${widget.ReportsD.categoryName} ",
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 17,
                        color: Color(0xff888888),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => ChainDetails(
                                  chainD: widget.ReportsD.categoryID!)));
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  widget.ReportsD.description != null
                      ?
/*
                  Html(data: widget.ReportsD.description.toString()):Text("لا يوجد وصف"),
*/

                      Text(
                          widget.ReportsD.description.toString(),
                          style: TextStyle(
                              fontSize: 18,
                              height: 1.5,
                              color: Colors
                                  .black //You can set your custom height here

                              ),
                        )
                      : Text("لا يوجد وصف"),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  openAttach(String attach) async {
    print(attach);
    final status = await Permission.storage.request();
    var path;
    if (status.isGranted) {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      //FlutterDownloader.registerCallback(downloadCallback);
      print("path" + appDocDir.path);
      if (Platform.isIOS) {
        path = appDocDir.path;
      } else if (Platform.isAndroid) path = "/storage/emulated/0/Download/";

      // return  BotToast.showText(text:"تم تحميل الملف بنجاح",align: Alignment.topCenter);

      // taskId.whenComplete(() => BotToast.showText(text:"تم تحميل الملف بنجاح",align: Alignment.topCenter));
    } else
      print("Denied");
  }

/*  void getDialog(BuildContext context) {
    setState(() {


       BotToast.showText(text:" بدء التحميل",align: Alignment.topCenter,onClose: (){
          print("ghghgh");
        }
        );


    });



  }*/
  void getDialog(BuildContext context) async {
    var url = widget.ReportsD.attachment.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
