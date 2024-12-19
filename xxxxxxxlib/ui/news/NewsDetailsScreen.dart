import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'package:reidsc/core/services/LatestNewsService.dart';
import 'package:reidsc/core/services/NewsService.dart';
import 'package:reidsc/core/services/UserService.dart';
import 'package:reidsc/data/model/News.dart';
import 'package:reidsc/data/model/news/NewsVM.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

var imageURL = "";

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.newD}) : super(key: key);
  final NewsVM newD;
//  final int userID;

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

  List<String> savedNews = [];

  void getSavedBookmarkedNews() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      savedNews = prefs.getStringList('savedNews')!;

      //userID = prefs.getInt("UserID") == null ?0:prefs.getInt("UserID")!;
      print("savedNews:$savedNews");
    });
  }

  void addSavedBookmarkedNews() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('savedNews', savedNews);

    setState(() {
      savedNews = prefs.getStringList('savedNews')!;

      //userID = prefs.getInt("UserID") == null ?0:prefs.getInt("UserID")!;
      print("savedNews:$savedNews");
    });
  }

  void removeSavedBookmarkedNews(articleId) async {
    final prefs = await SharedPreferences.getInstance();
    savedNews = prefs.getStringList('savedNews')!;
    savedNews.removeWhere((item) => item == articleId);

    await prefs.setStringList('savedNews', savedNews);

    setState(() {
      //userID = prefs.getInt("UserID") == null ?0:prefs.getInt("UserID")!;
      print("savedNews:$savedNews");
    });
  }
  //var msg;
  // var msg;
  //final List<Color> colorCodes = [Colors.red,Colors.amber,Colors.amber];

  @override
  void initState() {
    // TODO: implement initState
    getSavedBookmarkedNews();
    imageURL = DioBaseService().Cap_Upload_URL + widget.newD.photo.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Details",
            style: GoogleFonts.tajawal(textStyle: TextStyle(fontSize: 20.sp))),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,

        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_forward_ios,
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
                                          padding: const EdgeInsets.only(
                                              right: 15.0),
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0),
                                                child: Text(
                                                  widget
                                                      .newD.formatedPublishDate
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              )))))),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration:
                                  BoxDecoration(color: Color(0xff384153)),
                              child: IconButton(
                                  onPressed: () async {
                                    // Share.share(newD.title.toString());
                                    final urlimage =
                                        DioBaseService().Cap_Upload_URL +
                                            widget.newD.photo.toString();
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
                                          '${widget.newD.titleE.toString()} \n ${widget.newD.shareUrl}  \n'
                                          '  Cabinet Application'
                                          '\n https://onelink.to/eqzrkm',
                                    );
                                    // Share.shareFiles(['http://41.128.217.181:10092/images/topics/unchecked/culture.png'], text: newD.title.toString());
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
                                decoration:
                                    BoxDecoration(color: Color(0xff384153)),
                                child: IconButton(
                                    onPressed: () async {
                                      if (savedNews.contains(
                                              widget.newD.id.toString()) ==
                                          true) {
                                        removeSavedBookmarkedNews(
                                            widget.newD.id.toString());
                                        getSavedBookmarkedNews();

                                        var msg =
                                            "Item removed from bookmark list";
                                        //  print(msg);

                                        return showDialog<void>(
                                          context: context,
                                          barrierDismissible: false,
                                          // user must tap button!
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Success'),
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: <Widget>[
                                                    Text(msg),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('ok'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      } else if (savedNews.contains(
                                              widget.newD.id.toString()) ==
                                          false) {
                                        addSavedBookmarkedNews();

                                        var msg = "Item added to bookmark list";

                                        //  print(msg);
                                        setState(() {
                                          savedNews
                                              .add(widget.newD.id.toString());
                                          (savedNews.contains(widget.newD.id) ==
                                              true);
                                          getSavedBookmarkedNews();
                                          //getUserSavedNews();
                                        });
                                        return showDialog<void>(
                                            context: context,
                                            barrierDismissible:
                                                false, // user must tap button!
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Success'),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: <Widget>[
                                                      Text(msg),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('ok'),
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
                                    icon: savedNews
                                            .contains(widget.newD.id.toString())
                                        ? Icon(Icons.bookmark,
                                            color: Colors.white, size: 25.0)
                                        : Icon(Icons.bookmark_outline,
                                            color: Colors.white, size: 25.0))),
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
                          image: NetworkImage(DioBaseService().Cap_Upload_URL +
                              widget.newD.photo.toString()),
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
                widget.newD.titleE.toString(),
                //textAlign: TextAlign.justify,

                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16.sp,
                    height: 1.2, // the height between text, default is null
                    letterSpacing: 0.6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(children: [
                Icon(
                  Icons.folder_outlined,
                  color: Colors.red,
                  size: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.newD.newsCategoryNameE.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16.sp,
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Html(
                data: widget.newD.contentE.toString(),
                style: {
                  '#': Style(
                    fontSize: FontSize(15),
                    maxLines: 100,
                    textOverflow: TextOverflow.ellipsis,
                    //textAlign: TextAlign.justify,
                    color: Colors.black,
                    //  letterSpacing: 1.0,
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
