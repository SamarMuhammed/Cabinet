import 'dart:io';
import 'dart:ui' as ui;
import 'package:html/parser.dart' as htmlParser;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/Helper/LangHelper.dart';
import 'package:reidsc/core/services/DioBaseService.dart';

import 'package:reidsc/data/model/news/NewsVM.dart';
import 'package:reidsc/ui/news/NewsByCategoriesScreen.dart';
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
  String currentLanguage = 'en';

  String extractTextFromHtml(String htmlData) {
    if (htmlData.isEmpty) return '';

    // Parse the HTML data
    final document = htmlParser.parse(htmlData);

    // Remove `text-align: justify` from inline styles
    document
        .querySelectorAll('[style]')
        .forEach((element) {
      final styleAttr = element.attributes['style'] ?? '';
      final updatedStyle = styleAttr
          .split(';')
          .where((style) => !style.trim().startsWith('text-align: justify'))
          .join(';')
          .trim();
      if (updatedStyle.isNotEmpty) {
        element.attributes['style'] = updatedStyle;
      } else {
        element.attributes.remove('style'); // Remove empty style attribute
      }
    });

    // Remove `text-align: justify` from <style> tags
    document.getElementsByTagName('style').forEach((styleElement) {
      final cssContent = styleElement.text;
      final updatedCss = cssContent.replaceAll(RegExp(r'text-align:\s*justify;?'), '');
      styleElement.text = updatedCss;
    });

    // Extract text from the body or the entire document
    final bodyText = document.body?.text ?? '';
    final documentText = document.documentElement?.text ?? '';

    // Return the most complete available text
    return bodyText.isNotEmpty ? bodyText : documentText;
  }
  List<String> savedNews = [];
  void _loadLanguage() async {
    currentLanguage = await getSelectedLanguage();
    print("loadlangdd$currentLanguage");
    print(currentLanguage);
   // title=LocalizationHelper.getLocalizedValue(widget.newD.toMap(), currentLanguage, 'title');

  //  content=extractTextFromHtml(LocalizationHelper.getLocalizedValue(widget.newD.toMap(), currentLanguage, 'content'));
  //  print(content);
    // category=widget.newD.getLocalizedField(currentLanguage, 'newsCategoryName');
  //  print(LocalizationHelper.getLocalizedValue(widget.newD.toMap(), currentLanguage, 'title'),
   // );
   // print( widget.newD.getContent(currentLanguage));
    setState(() {}); // Update UI with the selected language
  }

  Future<String> getSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedLanguage') ?? 'en'; // Default to English
  }

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
var title;
  var content;
  var category;
  @override
  void initState() {
    // TODO: implement initState
    _loadLanguage();
    getSavedBookmarkedNews();
    imageURL = DioBaseService().Cap_Upload_URL + widget.newD.photo.toString();
    print('hellodetails');
    //currentLanguage =  getSelectedLanguage();
    print("loadlangdd$currentLanguage");



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final title = LocalizationHelper.getLocalizedValue(widget.newD.toMap(), currentLanguage, 'title');
    final rawContent = LocalizationHelper.getLocalizedValue(widget.newD.toMap(), currentLanguage, 'content');
    final plainTextContent = extractTextFromHtml(rawContent);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('details'.tr(),
            style: GoogleFonts.tajawal(textStyle: TextStyle(fontSize: 18.sp))),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,

        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_forward_ios,
                textDirection:ui.TextDirection.ltr),
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
                                                      fontSize: 16),),)))))),Expanded(
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

                                        var msg =  'bookmark_removed'.tr();

                                        //  print(msg);

                                        return showDialog<void>(
                                          context: context,
                                          barrierDismissible: false,
                                          // user must tap button!
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title:  Text('bookmark_success'.tr()),
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: <Widget>[
                                                    Text(msg),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child:  Text('bookmark_ok'.tr()),
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

                                        var msg = 'bookmark_added'.tr();

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
                                                title:  Text('bookmark_success'.tr()),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: <Widget>[
                                                      Text(msg),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child:  Text('bookmark_ok'.tr()),
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
              child:
    Text(
      title,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18.sp,
                    height: 1.2, // the height between text, default is null
                    letterSpacing: 0.6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => NewsByCategoriesScreen(
                        newsCatID:
                            int.parse(widget.newD.newsCategoryId.toString()),
                      ),
                    ),
                  );
                },
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

                    LocalizationHelper.getLocalizedValue(widget.newD.toMap(), currentLanguage, 'newsCategoryName'),

                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16.sp,
                    ),
                  ),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child:  Html(
                data:plainTextContent,


                style: {
                  '#': Style(
                    fontSize: FontSize(18),
                    maxLines: 100,
                    fontWeight: ui.FontWeight.w300,
                    textOverflow: TextOverflow.ellipsis,

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
