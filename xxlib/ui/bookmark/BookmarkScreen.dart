import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/services/BookmarkService.dart';
import 'package:reidsc/core/services/MediaService.dart';
import 'package:reidsc/core/services/NewsService.dart';

import 'package:reidsc/core/services/ReportsService.dart';
import 'package:reidsc/core/services/SearchService.dart';
import 'package:reidsc/core/services/StockmarketService.dart';
import 'package:reidsc/core/services/UserService.dart';
import 'package:reidsc/data/model/AllReports.dart';
import 'package:reidsc/data/model/Indicators/IndCategory.dart';
import 'package:reidsc/data/model/News.dart';
import 'package:reidsc/data/model/media/Media.dart';
import 'package:reidsc/data/model/selectedCategories/SelectedData.dart';
import 'package:reidsc/data/model/selectedCategories/selectedCat.dart';
import 'package:reidsc/generic/Helper.dart';
import 'package:reidsc/generic/Notifications/NotificationsMenu.dart';
import 'package:reidsc/main.dart';
import 'package:reidsc/ui/Reports/ReportsDetailsScreen.dart';
import 'package:reidsc/ui/media/MediaDetailsScreen.dart';
import 'package:reidsc/ui/news/NewsDetailsScreen.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  var userID = 0;

  late List<SelectedCat> categories = [];
  late int selectedCat = 1;
  late String selectedCatName = "News";
  late List<SelectedData> newsItems = [];
  bool isBookmarked = false;
  late List<String> bookmarks = [];
  late List<int> intbookmarks = [];
  bool isVisible = false;
  var items;
  final fieldText = TextEditingController();

  void getUserSavedNews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      //  userID = prefs.getInt("UserID") == null ?0:prefs.getInt("UserID")!;
      // print("userID$userID");
    });
    print("hiiii");
    final userItems = await UserService().getUserById(userId: userID);
    print(userItems);
    // usertopics=userItems.savedTopics.toString();
    String bookmarkednews = userItems.savedNews.toString();
    bookmarks = bookmarkednews.split(',');
    print(bookmarks.length);
    print(bookmarks[0]);
    intbookmarks = bookmarks.map(int.parse).toList();
    print(intbookmarks.length);
    print(intbookmarks[0]);
    //  print(usertopics);
    print("byyyyyye");
  }

  TextEditingController controllerFullName = TextEditingController();

  Future<List<SelectedCat>> loadCategories() async {
    var completer = Completer<List<SelectedCat>>();
    var cats = await SearchService().getCategories();
    completer.complete(await SearchService().getCategories());
    //
    setState(() {
      categories = cats;
      selectedCat = categories[0].id!;
      selectedCatName = categories[0].eName.toString();

      // getSubCats(selectedCat);
    });

    return completer.future;

    //  return tabs;
  }

  loadSearchResult(id, catName, name, userID) async {
    var items = await BookmarkService().searchBookmark(
        mainCatID: selectedCat,
        mainCatName: selectedCatName,
        searchItem: _name,
        userID: userID);

    setState(() {
      newsItems = items;
    });
  }

  void getUserSavedMedia() async {
    final userItems = await UserService().getUserById(userId: userID);
    print(userItems);
    //topictest=userItems.savedTopics.toString();
    String bookmarkednews = userItems.savedMedia.toString();
    // intbookmarks = bookmarks.map(int.parse).toList();
  }

  void getUserSavedReports() async {
    final userItems = await UserService().getUserById(userId: userID);
    print(userItems);
    //topictest=userItems.savedTopics.toString();
    String bookmarkedreports = userItems.savedReports.toString();
  }

  void getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userID = prefs.getInt("UserID") == null ? 0 : prefs.getInt("UserID")!;
      print("userID$userID");
    });
  }

  loadResult(id, catName, userID) async {
    items = await BookmarkService().getBookmark(
        mainCatID: selectedCat, mainCatName: selectedCatName, userID: userID);
    // var items = newsItems;
    setState(() {
      newsItems = items;
      if (newsItems.length > 0) {
        isVisible = true;
      } else {
        isVisible = false;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    loadCategories().then((value) => loadResult(1, "News", userID));
    getUserData();
    getUserSavedNews();
    isVisible = true;
    //getUserSavedReports();
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  String _name = '';
  // bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,

          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(
            " المفضلة ",
            style: TextStyle(fontSize: 17, fontFamily: 'Cairo'),
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          actions: [
            NotificationMenu()
            //  IconButton(onPressed: getNotifications, icon: const Icon(Icons.notifications),color: Colors.black,)
          ],
          titleTextStyle: const TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(children: [
            Padding(
              padding:
                  EdgeInsets.only(left: 24.0, right: 23.0, top: 20, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),

              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: fieldText,
                onChanged: (text) {
                  setState(() {
                    _name = text;
                    _onSearchClicked();
                  });
                },

                //controller:controllerFullName ,
                textAlign: TextAlign.right,

                decoration: InputDecoration(
                  // errorText:  _submitted  ? _errorNameText : null,
                  hintText: "ابحث ",
                  prefixIcon: IconButton(
                    onPressed: _onSearchClicked,
                    icon: Icon(
                      Icons.search,
                      color: Color(0xff888888),
                      size: 25,
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: clearText,
                    icon: Icon(
                      Icons.clear,
                      color: Color(0xff888888),
                      size: 25,
                    ),
                  ),
                  isDense: true,
                  // Added this
                  contentPadding: EdgeInsets.all(12),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff21212133), width: 1.5),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff21212133), width: 1.5),
                    borderRadius: BorderRadius.circular(20.0),
                  ),

                  //hintText: 'Enter valid email id as abc@gmail.com'
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 70,
                child:
                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  for (final cat in categories)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCat = cat.id!;
                          selectedCatName = cat.eName.toString();
                          getSubCats(selectedCat, selectedCatName, userID);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        child: AutoSizeText(
                          cat.name!,
                          style: selectedCat == cat.id
                              ? TextStyle(
                                  color: Color(0xff8F3F71),
                                  fontSize: 17.sp,
                                )
                              : TextStyle(
                                  color: Color(0xff888888),
                                  fontSize: 17.sp,
                                ),
                          minFontSize: 17,
                          maxFontSize: 19,
                        ),
                        decoration: selectedCat == cat.id
                            ? BoxDecoration(
                                border: Border(
                                bottom: BorderSide(
                                  color: Color(0xff8F3F71),
                                  width: 2,
                                ),
                              ))
                            : BoxDecoration(
                                border: Border(
                                bottom: BorderSide(
                                  color: Color(0xff888888),
                                ),
                              )),
                      ),
                    )
                ]),
              ),
            ),
            if (isVisible == true)
              Container(
                  color: Colors.black12,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(right: 14, left: 14, top: 14),
                        child: GestureDetector(
                          onTap: () {
                            if (selectedCatName == "News") {
                              getNewsByID(newsItems[index].id)
                                  .then((value) => {gotoNews(value, userID)});
                            } else if (selectedCatName == "Reports") {
                              getReportByID(newsItems[index].id).then(
                                  (value) => {gotoReports(value, userID)});
                            } else if (selectedCatName == "Media") {
                              getMediaByID(newsItems[index].id)
                                  .then((value) => {gotoMedia(value, userID)});
                            }
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 10,
                            child: Row(
                              children: <Widget>[
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (selectedCatName == "News") {
                                            getNewsByID(newsItems[index].id)
                                                .then((value) =>
                                                    {gotoNews(value, userID)});
                                          } else if (selectedCatName ==
                                              "Reports") {
                                            getReportByID(newsItems[index].id)
                                                .then((value) => {
                                                      gotoReports(value, userID)
                                                    });
                                          } else if (selectedCatName ==
                                              "Media") {
                                            getMediaByID(newsItems[index].id)
                                                .then((value) =>
                                                    {gotoMedia(value, userID)});
                                          }
                                        },
                                        child: Container(
                                          width: 97.0,
                                          height: 120,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(17),
                                              child: Image.network(
                                                newsItems[index]
                                                    .image
                                                    .toString(),
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,

                                        //height: 20,
                                        // color:Colors.red,
                                        child: newsItems[index].hashtags == null
                                            ? Text("")
                                            : SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                              ),
                                      ),
                                      Row(children: [
                                        Expanded(
                                          flex: 6,
                                          child: AutoSizeText(
                                            newsItems[index].title.toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: Color(0xff212121)),
                                            minFontSize: 16,
                                            maxFontSize: 18,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: IconButton(
                                              onPressed: () async {
                                                {
                                                  var msg = "";
                                                  if (selectedCatName ==
                                                      "News") {
                                                    msg = await NewsService()
                                                        .unBookmarkNews(
                                                            userID: userID,
                                                            parentID: int.parse(
                                                                newsItems[index]
                                                                    .id
                                                                    .toString()));
                                                    //  print(msg);
                                                    setState(() {
                                                      newsItems.remove(
                                                          newsItems[index].id);
                                                      newsItems.removeAt(index);

                                                      getUserSavedNews();
                                                    });
                                                  } else if (selectedCatName ==
                                                      "Reports") {
                                                    msg = await ReportsService()
                                                        .unBookmarkReports(
                                                            userID: userID,
                                                            parentID: int.parse(
                                                                newsItems[index]
                                                                    .id
                                                                    .toString()));
                                                    setState(() {
                                                      newsItems.remove(
                                                          newsItems[index].id);
                                                      newsItems.removeAt(index);

                                                      getUserSavedReports();
                                                    });
                                                  } else if (selectedCatName ==
                                                      "Media") {
                                                    var msg = await MediaService()
                                                        .unBookmarkMedia(
                                                            userID: userID,
                                                            parentID: int.parse(
                                                                newsItems[index]
                                                                    .id
                                                                    .toString()));
                                                    setState(() {
                                                      newsItems.remove(
                                                          newsItems[index].id);
                                                      newsItems.removeAt(index);

                                                      getUserSavedMedia();
                                                    });
                                                  }
                                                  return showDialog<void>(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    // user must tap button!
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title:
                                                            const Text('نجاح'),
                                                        content:
                                                            SingleChildScrollView(
                                                          child: ListBody(
                                                            children: <Widget>[
                                                              Text(msg),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            child: const Text(
                                                                'حسنا'),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                }
                                              },
                                              icon: Icon(Icons.bookmark,
                                                  color: Color(0xff212121),
                                                  size: 25.0)),
                                        ),
                                      ]),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      newsItems[index].hashtags == null
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text.rich(
                                                      TextSpan(
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                        ),
                                                        children: [
                                                          TextSpan(
                                                              text: newsItems[
                                                                      index]
                                                                  .createDate
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15.sp)),
                                                          WidgetSpan(
                                                            child: Icon(
                                                              Icons
                                                                  .calendar_today_rounded,
                                                              size: 16,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 17.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text.rich(
                                                      TextSpan(
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                        ),
                                                        children: [
                                                          TextSpan(
                                                              text: newsItems[
                                                                      index]
                                                                  .createDate
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.sp)),
                                                          WidgetSpan(
                                                            child: Icon(
                                                              Icons
                                                                  .calendar_today_rounded,
                                                              size: 16,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                    ],
                                  ),
                                ),

                                /*  GestureDetector(


                            )),
                        ),*/
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: newsItems.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                  ))
            else if (isVisible == false)
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Container(
                  child: Center(
                    child: AutoSizeText(
                      "لا توجد قائمة مفضلة",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Color(0xff8F3F71),
                      ),
                      minFontSize: 20,
                      maxFontSize: 22,
                    ),
                  ),
                ),
              )
          ]),
        ));
  }

  getSubCats(int? id, String? catName, int? user) {
    setState(() {
      selectedCat = id!;
      selectedCatName = catName!;
      userID = user!;

      loadResult(selectedCat, selectedCatName, userID);
    });
  }

  void _onSearchClicked() async {
    print("onseatrch" + _name);
    TextEditingController controllerFullName = TextEditingController();
    if (_name != null && _name.isNotEmpty && _name != " ") {
      //TextEditingController controllerEmail=TextEditingController();
      setState(() {
        loadSearchResult(selectedCat, selectedCatName, _name, userID);
      });
      print(_name);
      print(selectedCat);
      print(selectedCatName);
      // print(userTopics);
      //TextEditingController controllerFullName= TextEditingController();
      //TextEditingController controllerEmail=TextEditingController();
//print(_name);
      // var searchResult= await SearchService().search(_name);
    }
  }

  void clearText() {
    fieldText.clear();
    setState(() {
      newsItems = items;

      //isVisible = false;
    });
  }
}
