import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/services/ReportsService.dart';
import 'package:reidsc/core/services/UserService.dart';
import 'package:reidsc/data/model/AllReports.dart';
import 'package:reidsc/generic/Notifications/NotificationsMenu.dart';
import 'package:reidsc/ui/Reports/ReportsDetailsScreen.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/NotificationsService.dart';
import '../../data/model/Notifications/Notification.dart';






class AllReportsScreen extends StatefulWidget {
  final String selectedTopics;

  const AllReportsScreen({Key? key, required this.selectedTopics}) : super(key: key);


  @override
  _AllReportsScreenState createState() => _AllReportsScreenState();
}

class _AllReportsScreenState extends State<AllReportsScreen> {
  static const _pageSize = 5;
  List<String> result=[];
  var userID=0;
  var usertopics="";

  bool isBookmarked=false;
  late List<String> bookmarks =[];
  late  List<int> intbookmarks=[];
  late List<String> reportsbookmarks =[];
  late  List<int> intreportsbookmarks=[];
  //late List<Reports> Reportslist=[];
  late Reports Reportslist = new Reports();

  void getUserSavedReports() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userID = prefs.getInt("UserID") == null ?0:prefs.getInt("UserID")!;
      print("userID$userID");

    });
    print("hiiii");
    final userItems = await UserService().getUserById( userId: userID);
    print(userItems);
    //usertopics=userItems.savedTopics.toString();
    setState(() {
      String bookmarkedreports=userItems.savedReports.toString();
      reportsbookmarks = bookmarkedreports.split(',');
      // print(bookmarks.length);
      //print(bookmarks[0]);
      intreportsbookmarks = reportsbookmarks.map(int.parse).toList();
    });


  }
  final PagingController<int, Reports> _pagingController =
  PagingController(firstPageKey: 0);
  late List<IDSCNotification> notifications;
  void loadNotifications() async {
    notifications = await NotificationService().getNotifications();
  }
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    loadNotifications();
    getUserSavedReports();
    super.initState();
    // String text =Reportslist.hashtags.toString();
    // result = text.split(',');
    //print("Hashtag "+result[0]);
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await ReportsService().getAllReports( topicID:widget.selectedTopics,page:pageKey);
      print(newItems.length);
      print(newItems[0].title);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
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
            title: Text("الاصدارات والتقارير ",style:GoogleFonts.tajawal(textStyle: TextStyle(fontSize: 17.sp,))
              ,),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            actions: [

              NotificationMenu()
              //  IconButton(onPressed: getNotifications, icon: const Icon(Icons.notifications),color: Colors.black,)
            ],
            titleTextStyle:  TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () => Future.sync(
                  () => _pagingController.refresh(),
            ),
            child:  PagedListView<int, Reports>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Reports>(
                itemBuilder: (context, item, index) => Container(

                    child:

                    Padding(
                      padding: const EdgeInsets.only(right:14,left:14,top:14),


                      child: Container(
                        height: 170,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => ReportsDetailsScreen(ReportsD: item,userID: this.userID,),
                              ),
                            );
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
                                      child: Container(
                                        width: 97.0,
                                        height: 140,
                                        child:  ClipRRect(
                                            borderRadius: BorderRadius.circular(17),
                                            child:Image.network(item.image.toString(),
                                              fit: BoxFit.cover,
                                            )
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Flexible(

                                  child: Container(
                                    height: 170,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,

                                          //height: 20,
                                          // color:Colors.red,
                                          child:item.hashtags==""?Text(""):  SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: <Widget>[
                                                for(var item in item.hashtags!.split(',') )
                                                  Padding(
                                                    padding: const EdgeInsets.all(5.0),
                                                    child: InputChip(

                                                      label: AutoSizeText(item,maxFontSize: 16,minFontSize: 15,),
                                                      labelStyle:TextStyle(
                                                          color:Colors.black,
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                      disabledColor: Color(
                                                          0xffbde3e7),
                                                     // backgroundColor: Color(0xffE1E1E1),
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),

                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Row(

                                          children: [
                                            Expanded(
                                                flex:5,
                                                child: Text(item.title.toString(), maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                              //    textDirection: TextDirection.rtl,
                                                  style:TextStyle(fontSize: 16.sp,color: Color(0xff212121)),)),

                                            /*  Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                        onTap: (){print("On Click icon");},
                                        child: Container(

                                          child: Icon(
                                            Icons.bookmark_border_outlined,
                                            color: Colors.black87,
                                            size: 23,
                                          ),
                                        ),
                                        ),
                                      ),*/
                                          ],
                                        ),
                                        SizedBox(height: 8,) ,

                                        item.hashtags==""?         Row(
                                          children: [

                                            Row(
                                              children: [
                                                Icon(Icons.calendar_today,size: 15,),
                                                AutoSizeText(item.createDate.toString(),minFontSize: 15,maxFontSize: 16,),

                                              ],
                                            )
                                          ],

                                        ):
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.calendar_today,size: 15,),
                                                AutoSizeText(item.createDate.toString(),minFontSize: 15,maxFontSize: 16,),

                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    item.hashtags==""?  Padding(
                                      padding: const EdgeInsets.only(top:5),
                                      child:  IconButton(onPressed: () async {

                                        if(intreportsbookmarks.contains(item.id)==true) {
                                          var msg= await ReportsService().unBookmarkReports(
                                              userID: userID,
                                              parentID: int.parse(
                                                  item.id.toString()));
                                          //  print(msg);
                                          setState(() {
                                            intreportsbookmarks.remove(item
                                                .id);
                                            (intreportsbookmarks.contains(item.id)== false);
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
                                        }else if(intreportsbookmarks.contains(item.id)==false){
                                          var msg= await ReportsService().bookmarkReports(userID: userID, parentID: int.parse(item.id.toString()));
                                          //  print(msg);
                                          setState(() {
                                            (intreportsbookmarks.contains( item.id)== true);
                                            getUserSavedReports();
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
                                          icon:intreportsbookmarks.contains(item.id) ? Icon(Icons.bookmark, color: Color(0xff212121),
                                              size: 25.0): Icon(Icons.bookmark_outline, color: Color(0xff212121),
                                              size: 25.0)),
                                    ):
                                    Padding(
                                      padding: const EdgeInsets.only(top:55),
                                      child:  IconButton(onPressed: () async {

                                        if(intreportsbookmarks.contains(item.id)==true) {
                                          var msg= await ReportsService().unBookmarkReports(
                                              userID: userID,
                                              parentID: int.parse(
                                                  item.id.toString()));
                                          //  print(msg);
                                          setState(() {
                                            (intreportsbookmarks.contains(item.id)== false);
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
                                        }else if(intreportsbookmarks.contains(item.id)==false){
                                          var msg= await ReportsService().bookmarkReports(userID: userID, parentID: int.parse(item.id.toString()));
                                          //  print(msg);
                                          setState(() {
                                            (intreportsbookmarks.contains( item.id)== true);
                                            getUserSavedReports();
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
                                          icon:intreportsbookmarks.contains(item.id) ? Icon(Icons.bookmark, color: Color(0xff212121),
                                              size: 25.0): Icon(Icons.bookmark_outline, color: Color(0xff212121),
                                              size: 25.0)),
                                    ),

                                  ],
                                )
                                /*  GestureDetector(

                            child: Container(
                                padding: EdgeInsets.all(5.0),
                                child: Chip(
                                  label: Text(sourceslist[index].name.toString()),
                                  shadowColor: Colors.blue,
                                  backgroundColor: Colors.green,
                                  elevation: 10,
                                  autofocus: true,
                                )),
                          ),*/
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
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