import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/services/NewsService.dart';
import 'package:reidsc/core/services/UserService.dart';
import 'package:reidsc/data/model/News.dart';
import 'package:reidsc/generic/NewsCardWidget.dart';
import 'package:reidsc/generic/Notifications/NotificationsMenu.dart';

import 'package:reidsc/ui/news/NewsDetailsScreen.dart';


import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/NotificationsService.dart';
import '../../data/model/Notifications/Notification.dart';
class AllNewsScreen extends StatefulWidget {
  final String selectedTopics;

  const AllNewsScreen({Key? key, required this.selectedTopics}) : super(key: key);

  @override
  _AllNewsScreenState createState() => _AllNewsScreenState();
}

class _AllNewsScreenState extends State<AllNewsScreen> {
 late    int _pageSize  ;
  var userID = 0;
  late List<String> bookmarks =[];
  late  List<int> intbookmarks=[];
  bool isBookmarked=false;

  final PagingController<int, News> _pagingController =
  PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });


    getUserSavedNews();
    super.initState();
  }

  void getUserSavedNews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userID = prefs.getInt("UserID") == null ?0:prefs.getInt("UserID")!;
      print("userID$userID");

    });
    print("hiiii");
    final userItems = await UserService().getUserById( userId: userID);
    print(userItems);
print("selected Topics");
print(widget.selectedTopics);
    setState(() {
      String bookmarkednews=userItems.savedNews.toString();
      bookmarks = bookmarkednews.split(',');
      // print(bookmarks.length);
      // print(bookmarks[0]);
      intbookmarks = bookmarks.map(int.parse).toList();

    });



  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await NewsService().getAllNews(
          topicID: widget.selectedTopics, page: pageKey);

      var intTopics = widget.selectedTopics.split(',');
      // print(bookmarks.length);
      // print(bookmarks[0]);
      var fTopics = intTopics.map(int.parse).toList();
     print("fTopics$fTopics") ;
      print(fTopics.length) ;

      if (fTopics.length > 6) {
        _pagingController.appendLastPage(newItems);


      }
      else{
      //  print(pageKey);
      //  print(newItems.length);
      //  print(newItems[0].title);
      _pageSize = newItems.length;
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
        // pageKey++;
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
          appBar: AppBar(
            elevation: 0.0,

            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text("الأخبار ",style:TextStyle(fontSize: 17.sp,fontFamily: 'Cairo')
              ,),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            actions: [

              NotificationMenu()
              //  IconButton(onPressed: getNotifications, icon: const Icon(Icons.notifications),color: Colors.black,)
            ],
            titleTextStyle:  TextStyle(
                color: Colors.black,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () => Future.sync(
                  () => _pagingController.refresh(),
            ),
            child:  PagedListView<int, News>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<News>(
                itemBuilder: (context, item, index) => InkWell(

                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => DetailsScreen(
                          newD: item,
                          userID:this.userID,
                        ),
                      ),
                    );
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
                                child: Image.network(item.image.toString(),
                                  width: 370.w,
                                  height: 200.h,
                                  fit: BoxFit.cover,

                                ),
                              ), // If it's missing, display an empty box
                              // If it's missing, display an empty box

                            ),
SizedBox(height:10),
                            Padding(
                              padding:  EdgeInsets.only(right:9.0).r,
                              child: Row(
                                  children: [
                                    Flexible(
                                      child: AutoSizeText(item.title.toString(), maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style:TextStyle(fontSize: 16.sp,height: 1.5, // the height between text, default is null
                                            letterSpacing: 1.0,color: Color(0xff212121
                                        )),minFontSize: 15,maxFontSize: 16,),
                                    ),
                                    IconButton(onPressed: () async {
                                      if(intbookmarks.contains(item.id)== true) {
                                        var msg= await NewsService().unBookmarkNews(
                                            userID: userID,
                                            parentID: int.parse(
                                                item.id.toString()));
                                        //  print(msg);
                                        setState(() {
                                          intbookmarks.remove(item
                                              .id);
                                          (intbookmarks.contains(item.id)== false);
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
                                      }else if(intbookmarks.contains(item.id)==false){
                                        var msg =  await NewsService().bookmarkNews(userID: userID, parentID: int.parse(item.id.toString()));
                                        //  print(msg);
                                        setState(() {
                                          (intbookmarks.contains(item.id)==true);

                                          getUserSavedNews();
                                        });
                                        return showDialog<void>(
                                            context: context,
                                            barrierDismissible: false, // user must tap button!
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('نجاح'),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children:  <Widget>[
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
                                            }
                                        );

                                      }

                                    },
                                        icon:intbookmarks.contains(item.id)?
                                        Icon(Icons.bookmark, color: Color(0xff212121),
                                            size: 25.0):  Icon(Icons.bookmark_outline, color: Color(0xff212121),
                                            size: 25.0))

                                    ,
                                  ]
                              ),
                            ),
                            SizedBox(height: 10.h),

                            Padding(
                              padding:  EdgeInsets.only(right:8.0.r),
                              child: Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.date_range, color: Colors.black45,
                                      size: 20.0,),
                                    AutoSizeText(
                                        item.date.toString(),
                                        style: TextStyle(color: Colors.black45),minFontSize: 15,maxFontSize: 16,),
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
          )
      );


  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}