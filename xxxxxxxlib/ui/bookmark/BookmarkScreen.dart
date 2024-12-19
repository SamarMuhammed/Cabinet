
import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/services/BookmarkService.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
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
import 'package:reidsc/data/model/news/NewsVM.dart';
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

  // var userID = 0;

  //late List<SelectedCat> categories = [];
  // late int selectedCat =1;
  //late String selectedCatName="News";
  late List<SelectedData> newsItems = [];
  bool isBookmarked = false;
  //late List<String> bookmarks = [];
  // late List<int> intbookmarks = [];
  bool isVisible =false;
  var items;
  static const _pageSize = 10;
  List<String> savedNews=[];


  void getSavedBookmarkedNews() async{


    final prefs = await SharedPreferences.getInstance();

    setState(() {
      savedNews = prefs.getStringList('savedNews')! ;
      if (savedNews.toString()?.isEmpty ?? true) {
        setState(() {
          isVisible = false;
        });
      } else {
        setState(() {
          isVisible = true;        });
      }
      //userID = prefs.getInt("UserID") == null ?0:prefs.getInt("UserID")!;
      print("savedNews:$savedNews");

    });
  }
  void addSavedBookmarkedNews() async{


    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('savedNews', savedNews);

    setState(() {
      savedNews = prefs.getStringList('savedNews')! ;

      //userID = prefs.getInt("UserID") == null ?0:prefs.getInt("UserID")!;
      print("savedNews:$savedNews");

    });
  }
  void removeSavedBookmarkedNews(articleId) async{
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      savedNews = prefs.getStringList('savedNews')! ;
      savedNews.removeWhere((item) => item == articleId);
//savedNews.remove(articleId);
      newsItems.removeWhere((item) => item == articleId);
      prefs.setStringList('savedNews', savedNews);
      //  getSavedBookmarkedNews();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => super.widget));
    });

    //_fetchPage(this.pageKey);

  }
  final PagingController<int, NewsVM> _pagingController =
  PagingController(firstPageKey: 1);

  TextEditingController controllerFullName = TextEditingController();




  @override
  void initState() {
    // TODO: implement initState
    //loadCategories().then((value) => loadResult(1, "News", userID));
    // getUserData();
    //getUserSavedNews();
    getSavedBookmarkedNews();

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    //isVisible = true;
    //getUserSavedReports();
    super.initState();
  }


  Future<void> _fetchPage(int pageKey) async {
    try {
      //print("hhhbookmarkedNews$savedNews");
      final stringnews = savedNews.toString();

      final prefs = await SharedPreferences.getInstance();

      setState(() {
        savedNews = prefs.getStringList('savedNews')!;

        //userID = prefs.getInt("UserID") == null ?0:prefs.getInt("UserID")!;
        print("infetchsavedNews:$savedNews");
      });
      if (savedNews?.isEmpty ?? true) {
        setState(() {
          isVisible = false;
        });
      } else {
        final newItems = await NewsService().getBookmarkedNews(
            bookmarkedNews: savedNews.toString()
                .replaceAll("]", "")
                .replaceAll("[", ""), page: pageKey);
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
      }
    }
    catch (error) {
      _pagingController.error = error;
    }

  }

  void dispose() {
    super.dispose();
  }
  String _name = '';
  // bool isVisible = false;


  @override
  Widget build(BuildContext context) =>
      Scaffold(
          appBar: AppBar(
            elevation: 0.0,

            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text("Bookmark",style:GoogleFonts.tajawal(textStyle: TextStyle(fontSize: 20.sp,))
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
          body: (isVisible==true)?RefreshIndicator(
            onRefresh: () => Future.sync(
                  () => _pagingController.refresh(),
            ),
            child:  PagedListView<int, NewsVM>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<NewsVM>(
                itemBuilder: (context, item, index) => InkWell(

                  onTap: (){
                    getNewsByID(item.id).then((value) =>
                    {

                      gotoNews(value)
                    });
                    // }
                  },

                  child:
                  Padding(
                    padding:  EdgeInsets.all(10.0).r,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),

                      child: Container(
                        width: 280.w,

                        height: 300.h,
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          //crossAxisAlignment: CrossAxisAlignment.stretch,

                          children: <Widget>[

                            Container(

                              alignment: Alignment.center,

                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(DioBaseService().Cap_Upload_URL+item.photo.toString(),
                                  width: 370.w,
                                  height: 200.h,
                                  fit: BoxFit.cover,

                                ),
                              ), // If it's missing, display an empty box
                              // If it's missing, display an empty box

                            ),
                            SizedBox(height:10),
                            Padding(
                              padding:  EdgeInsets.only(left:10.0).r,
                              child: Row(
                                  children: [
                                    Flexible(
                                      child: AutoSizeText(item.titleE.toString(), maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.justify,
                                        style:TextStyle(fontSize: 16.sp,color: Color(0xff212121
                                        )),minFontSize: 15,maxFontSize: 16,),
                                    ),
                                    /*IconButton(onPressed: () async {


                                    },
                                        icon:intbookmarks.contains(item.id)?
                                        Icon(Icons.bookmark, color: Color(0xff212121),
                                            size: 25.0):  Icon(Icons.bookmark_outline, color: Color(0xff212121),
                                            size: 25.0))*/
                                    IconButton(onPressed: () async {

                                      if(savedNews.contains(item.id.toString())==true) {
                                        removeSavedBookmarkedNews(item.id.toString());
                                        getSavedBookmarkedNews();

                                        var msg="Item removed from bookmark list";
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
                                                    Text(
                                                        msg),
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
                                      }else if(savedNews.contains(item.id.toString())==false){
                                        addSavedBookmarkedNews();

                                        var msg="Item added to bookmark list";

                                        //  print(msg);
                                        setState(() {
                                          savedNews.add(item.id.toString());
                                          (savedNews.contains(item.id)== true);
                                          getSavedBookmarkedNews();
                                          //getUserSavedNews();
                                        });
                                        return showDialog<void>(
                                            context: context,
                                            barrierDismissible: false, // user must tap button!
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Success'),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children:  <Widget>[
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
                                            }
                                        );

                                      }

                                    },
                                        icon:savedNews.contains(item.id.toString()) ? Icon(Icons.bookmark, color:Color(0xffb5102b),
                                            size: 25.0): Icon(Icons.bookmark_outline, color: Color(0xff212121),
                                            size: 25.0))

                                    ,
                                  ]
                              ),
                            ),
                            SizedBox(height: 10.h),

                            Padding(
                              padding:  EdgeInsets.only(left:8.0.r),
                              child: Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [

                                    AutoSizeText(
                                      item.formatedPublishDate.toString(),
                                      style: TextStyle(color: Colors.black45),minFontSize: 15,maxFontSize: 16,),
                                    Icon(
                                      Icons.date_range, color: Colors.black45,
                                      size: 20.0,)
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
          ):
          Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment:MainAxisAlignment.center,

            children: [

              Row(
                mainAxisAlignment:MainAxisAlignment.center,

                children: [
                  Center(
                    child: Text(
                        "No Bookmarked Items",style:TextStyle(fontSize: 20.sp,)
                    ),
                  ),
                ],
              ),
            ],
          )
      );
}




//}s