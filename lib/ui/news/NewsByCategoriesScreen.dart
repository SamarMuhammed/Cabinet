import 'dart:convert';
import 'dart:ui' as ui;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/Helper/LangHelper.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'package:reidsc/core/services/NewsService.dart';
import 'package:reidsc/data/model/news/NewsVM.dart';
import 'package:reidsc/generic/Helper.dart';
import 'package:reidsc/ui/news/NewsDetailsScreen.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsByCategoriesScreen extends StatefulWidget {
  const NewsByCategoriesScreen({Key? key, required this.newsCatID})
      : super(key: key);
  final int newsCatID;

  @override
  _NewsByCategoriesScreenState createState() => _NewsByCategoriesScreenState();
}

class _NewsByCategoriesScreenState extends State<NewsByCategoriesScreen> {
  static const _pageSize = 5;
  var userID = 0;
  late List<String> bookmarks = [];
  late List<int> intbookmarks = [];
  bool isBookmarked = false;
  List<String> savedNews = [];
  String currentLanguage = 'en';
  void _loadLanguage() async {
    currentLanguage = await getSelectedLanguage();
    print("loadlang$currentLanguage");
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

  final PagingController<int, NewsVM> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _loadLanguage();

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    getSavedBookmarkedNews();
    // getUserSavedNews();
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await NewsService()
          .getNewsByCategoryID(id: widget.newsCatID, page: pageKey);
      //  print(pageKey);
      print(newItems.length);
      print(newItems[0].titleE);

      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        elevation: 0.0,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          'news_screen'.tr(),
          style: GoogleFonts.tajawal(
              textStyle: TextStyle(
            fontSize: 18.sp,
          )),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_forward_ios,
                textDirection: ui.TextDirection.ltr),
            color: Colors.black,
          )
        ],
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 22.sp, fontWeight: FontWeight.bold),
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
        child: PagedListView<int, NewsVM>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<NewsVM>(
            itemBuilder: (context, item, index) => InkWell(
              onTap: () {
                getNewsByID(item.id).then((value) => {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => DetailsScreen(
                            newD: value!,
                          ),
                        ),
                      )
                    });
              },
              child: Padding(
                padding: EdgeInsets.all(10.0).r,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.3,
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      //crossAxisAlignment: CrossAxisAlignment.stretch,

                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              DioBaseService().Cap_Upload_URL +
                                  item.photo.toString(),
                              width: 370.w,
                              height: 200.h,
                              fit: BoxFit.cover,
                            ),
                          ), // If it's missing, display an empty box
                          // If it's missing, display an empty box
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0).r,
                          child: Row(children: [
                            Flexible(
                              child: AutoSizeText(
                                LocalizationHelper.getLocalizedValue( item.toMap(), currentLanguage, 'title'),

                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: 16.sp, color: Color(0xff212121)),
                                minFontSize: 15,
                                maxFontSize: 16,
                              ),
                            ),
                            /*IconButton(onPressed: () async {


                                    },
                                        icon:intbookmarks.contains(item.id)?
                                        Icon(Icons.bookmark, color: Color(0xff212121),
                                            size: 25.0):  Icon(Icons.bookmark_outline, color: Color(0xff212121),
                                            size: 25.0))*/
                            IconButton(
                                onPressed: () async {
                                  if (savedNews.contains(item.id.toString()) ==
                                      true) {
                                    removeSavedBookmarkedNews(
                                        item.id.toString());
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
                                  } else if (savedNews
                                          .contains(item.id.toString()) ==
                                      false) {
                                    addSavedBookmarkedNews();

                                    var msg = 'bookmark_added'.tr();

                                    //  print(msg);
                                    setState(() {
                                      savedNews.add(item.id.toString());
                                      (savedNews.contains(item.id) == true);
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
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  }
                                },
                                icon: savedNews.contains(item.id.toString())
                                    ? Icon(Icons.bookmark,
                                        color: Color(0xffb5102b), size: 25.0)
                                    : Icon(Icons.bookmark_outline,
                                        color: Color(0xff212121), size: 25.0)),
                          ]),
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0.r),
                          child: Row(
                              textDirection:ui.TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AutoSizeText(
                                  item.formatedPublishDate.toString(),
                                  style: TextStyle(color: Colors.black45),
                                  minFontSize: 15,
                                  maxFontSize: 16,
                                ),
                                Icon(
                                  Icons.date_range,
                                  color: Colors.black45,
                                  size: 20.0,
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ));

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
