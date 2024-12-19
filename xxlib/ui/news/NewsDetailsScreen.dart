import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/services/LatestNewsService.dart';
import 'package:reidsc/core/services/NewsService.dart';
import 'package:reidsc/core/services/UserService.dart';
import 'package:reidsc/data/model/News.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

var imageURL = "";

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.newD, required this.userID})
      : super(key: key);
  final News newD;
  final int userID;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<String> result = [];
  var userID = 0;
  late List<String> bookmarks = [];
  late List<int> intbookmarks = [];
  bool isBookmarked = false;
  late String topictest;

  void getUserSavedNews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userID = prefs.getInt("UserID") == null ? 0 : prefs.getInt("UserID")!;
      print("userID$userID");
    });
    print("hiiii");
    final userItems = await UserService().getUserById(userId: userID);
    print(userItems);
    topictest = userItems.savedTopics.toString();
    setState(() {
      String bookmarkednews = userItems.savedNews.toString();
      bookmarks = bookmarkednews.split(',');
      print(bookmarks.length);
      print(bookmarks[0]);
      intbookmarks = bookmarks.map(int.parse).toList();
      print(intbookmarks.length);
      print(intbookmarks[0]);
      print(topictest);
      print("byyyyyye");
    });
  }
  //var msg;
  // var msg;
  //final List<Color> colorCodes = [Colors.red,Colors.amber,Colors.amber];

  @override
  void initState() {
    // TODO: implement initState
    getUserSavedNews();
    imageURL = widget.newD.image.toString();
    super.initState();
    if (widget.newD.hashtags != "" && widget.newD.hashtags != null) {
      print("null");
      String text = widget.newD.hashtags.toString();
      result = text.split(',');
      // msg=  NewsService().bookmarkNews(userID: 1, parentID: int.parse(widget.newD.id.toString()));
      // print(msg);
      print("Hashtag " + result[0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(" تفاصيل الخبر",
            style: TextStyle(fontSize: 17.sp, fontFamily: 'Cairo')),
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
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 22.sp, fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () async {
                    await showDialog(
                        context: context, builder: (_) => ImageDialog());
                  },
                  child: Container(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 5,
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 15,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.black38,
                                  ),
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15.0),
                                        child: Text(
                                          widget.newD.date.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      )))),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration:
                                  BoxDecoration(color: Color(0xff384153)),
                              child: IconButton(
                                  onPressed: () async {
                                    //  Share.share(newD.title.toString());
                                    final urlimage =
                                        widget.newD.image.toString();
                                    final url = Uri.parse(urlimage);
                                    final response = await get(url);
                                    final bytes = response.bodyBytes;
                                    final Directory temp =
                                        await getTemporaryDirectory();
                                    final path = '${temp.path}/Image.jpg';
                                    File(path).writeAsBytesSync(bytes);
                                    await Share.shareFiles(
                                      [path],
                                      text:
                                          '${widget.newD.title.toString()}  http://new.idscapp.gov.eg/share/news/details/${widget.newD.id} \n'
                                          ' تطبيق IDSC'
                                          '\n https://onelink.to/eqzrkm',
                                    );
                                    //  Share.shareFiles(['http://41.128.217.181:10092/images/topics/unchecked/culture.png'], text: newD.title.toString());
                                  },
                                  icon: const Icon(
                                    Icons.share,
                                    color: Colors.white,
                                    size: 25,
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
                                              .contains(widget.newD.id) ==
                                          true) {
                                        var msg = await NewsService()
                                            .unBookmarkNews(
                                                userID: widget.userID,
                                                parentID: int.parse(
                                                    widget.newD.id.toString()));

                                        //  print(msg);
                                        setState(() {
                                          intbookmarks.remove(widget.newD.id);
                                          (intbookmarks
                                                  .contains(widget.newD.id) ==
                                              false);
                                          getUserSavedNews();
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
                                              .contains(widget.newD.id) ==
                                          false) {
                                        var msg = await NewsService()
                                            .bookmarkNews(
                                                userID: widget.userID,
                                                parentID: int.parse(
                                                    widget.newD.id.toString()));
                                        //  print(msg);
                                        setState(() {
                                          (intbookmarks
                                                  .contains(widget.newD.id) ==
                                              true);
                                          getUserSavedNews();
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
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            });
                                      }
                                    },
                                    icon: intbookmarks.contains(widget.newD.id)
                                        ? Icon(
                                            Icons.bookmark,
                                            color: Colors.white,
                                            size: 25,
                                          )
                                        : Icon(
                                            Icons.bookmark_outline,
                                            color: Colors.white,
                                            size: 25,
                                          ))),
                          ),
                        ],
                      ),
                    ),
                    height: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? MediaQuery.of(context).size.height / 3
                        : MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.newD.image.toString()),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
              ],
            ),
            result == null
                ? Text("")
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        for (var item in result)
                          Padding(
                            padding: EdgeInsets.all(5.0).r,
                            child: InputChip(
                              label: Text(item),
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              disabledColor: Color(0xffbde3e7),
                              // backgroundColor: Color(0xffE1E1E1),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                          ),
                      ],
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                widget.newD.title.toString(),
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15.sp,
                    height: 1.3, // the height between text, default is null
                    letterSpacing: 0.2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'المصدر  ',
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontFamily: 'Cairo',
                          color: Color(0xff888888),
                          fontWeight: FontWeight.w700,
                        )),
                    TextSpan(
                        text: widget.newD.sourceName.toString(),
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Color(0xff888888),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Cairo'),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            var url = widget.newD.link.toString();
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          })
                  ],
                ),
              ),
            ),
            if (widget.newD.comment != null)
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Html(
                  data: widget.newD.comment.toString(),
                  style: {
                    '#': Style(
                      fontSize: FontSize(15),
                      maxLines: 100,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  },
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Html(
                data: widget.newD.description.toString(),
                style: {
                  '#': Style(
                    fontSize: FontSize(15),
                    maxLines: 100,
                    textOverflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    color: Colors.black,
                    letterSpacing: 1.0,
                  ),
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}

class ImageDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          height: MediaQuery.of(context).size.height / 2.2,
          width: MediaQuery.of(context).size.width,
          child: PhotoView(
              backgroundDecoration: BoxDecoration(color: Colors.transparent),
              initialScale: PhotoViewComputedScale.contained * 1.5,
              maxScale: PhotoViewComputedScale.contained * 8,
              imageProvider: NetworkImage(
                imageURL,
              )),
        ));
  }
}
