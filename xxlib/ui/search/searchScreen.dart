import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/services/BookmarkService.dart';
import 'package:reidsc/core/services/MediaService.dart';
import 'package:reidsc/core/services/NewsService.dart';

import 'package:reidsc/core/services/ReportsService.dart';
import 'package:reidsc/core/services/SearchService.dart';
import 'package:reidsc/core/services/UserService.dart';

import 'package:reidsc/data/model/selectedCategories/SelectedData.dart';
import 'package:reidsc/data/model/selectedCategories/selectedCat.dart';
import 'package:reidsc/generic/Helper.dart';
import 'package:reidsc/generic/Notifications/NotificationsMenu.dart';
import 'package:reidsc/ui/news/NewsDetailsScreen.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';




class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {


  late List<SelectedCat> categories = [];
  late int selectedCat;
  var userID=0;
  String userTopics="";
  late String selectedCatName;
  late List<SelectedData> searchResult = [];
  bool isBookmarked=false;
  late List<String> bookmarks =[];
  late  List<int> intbookmarks=[];
  late List<String> reportsbookmarks =[];
  late List<String> newsbookmarks =[];
  late List<String> mediabookmarks =[];
  var items;
  bool isSearch=false;

  final fieldText = TextEditingController();


  void getUserSavedNews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userItems = await UserService().getUserById( userId: userID);

    setState(() {
      //  userID = prefs.getInt("UserID") == null ?0:prefs.getInt("UserID")!;
      // print("userID$userID");
      String bookmarkednews=userItems.savedNews.toString();
      bookmarks = bookmarkednews.split(',');
      //print(bookmarks.length);
      //print(bookmarks[0]);
      intbookmarks = bookmarks.map(int.parse).toList();
    });
    //print("hiiii");
    //print(userItems);
    // usertopics=userItems.savedTopics.toString();

    //print(intbookmarks.length);
    //print(intbookmarks[0]);
    //  print(usertopics);
    // print("byyyyyye");


  }
  TextEditingController controllerFullName = TextEditingController();

  Future<List<SelectedCat>> loadCategories() async {
    var completer = Completer<List<SelectedCat>>();
    var cats = await SearchService().getCategories();
    completer.complete(await SearchService().getCategories());

    //
    if(mounted)
      setState(() {
        categories = cats;
        selectedCat = categories[0].id!;
        selectedCatName=categories[0].eName.toString();
        if(selectedCatName=="News"){
          getUserSavedNews();
        }
        else if(selectedCatName=="Reports"){
          getUserSavedReports();
        }
        else if(selectedCatName=="Media"){
          getUserSavedMedia();
        }



        // getSubCats(selectedCat);
      });


    return completer.future;


    //  return tabs;

  }


  loadResult(id,catName,name,userTopics) async {
    var items = await SearchService().search(mainCatID:selectedCat,mainCatName:selectedCatName,searchItem: _name,selectedTopics:userTopics );
print(items[0].image);
    setState(() {
      searchResult = items;
      if(searchResult.length>0){
        isVisible = true;
        isSearch=true;

      }
      else{
        isVisible = false;
         isSearch=false;


      }
    });
  }
  void getUserSavedTopics() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userID = prefs.getInt("UserID") == null ? 0 : prefs.getInt("UserID")!;
     // print("userID$userID");
    });
    // print("hiiii");
    final userItems = await UserService().getUserById(userId: userID);
    // print(userItems);
    userTopics = userItems.savedTopics.toString();
  }

  void getUserSavedReports() async {
    final userItems = await UserService().getUserById( userId:userID);

    setState(() {
     // print(userItems);
      //topictest=userItems.savedTopics.toString();
      String bookmarkedreports=userItems.savedReports.toString();
      reportsbookmarks = bookmarkedreports.split(',');
      intbookmarks = reportsbookmarks.map(int.parse).toList();
    });


  }

  void getUserSavedMedia() async {

    final userItems = await UserService().getUserById( userId: userID);
    // print(userItems);
    setState(() {
      //topictest=userItems.savedTopics.toString();
      String bookmarkednews=userItems.savedMedia.toString();
      //print("bookmarkednews "+bookmarkednews);
      mediabookmarks = bookmarkednews.split(',');
      intbookmarks = mediabookmarks.map(int.parse).toList();
    });

  }

  @override
  void initState() {

    // TODO: implement initState

    loadCategories();
    getUserSavedTopics();
    getUserSavedNews();
    getUserSavedReports();
    isVisible = true;
    isSearch= false;


    super.initState();
  }
  void dispose() {

    super.dispose();
  }
  String _name = '';
  bool isVisible=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,

          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(" بحث ",
            style:  TextStyle(fontSize: 17,fontFamily: 'Cairo')
            ,),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          actions: [

            NotificationMenu()
            //  IconButton(onPressed: getNotifications, icon: const Icon(Icons.notifications),color: Colors.black,)
          ],
          titleTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold
          ),
        ),
        body:SingleChildScrollView(
          physics:ScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 24.0, right: 23.0, top: 20, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),

                  child: TextField(
                    //   autovalidateMode: AutovalidateMode.onUserInteraction,
controller:  fieldText
          ,
                    onChanged: (text) {
                      if (text != null || text.isNotEmpty) {
                        setState(() => _name = text);
                        _onSearchClicked();
                      }
                    } ,
                    //controller:controllerFullName ,
                    textAlign: TextAlign.right,
                    //     textInputAction: TextInputAction.go,
                    // onTap: _onSearchClicked(),
//onSubmitted: _onSearchClicked(),
                    decoration: InputDecoration(
                      // errorText:  _submitted  ? _errorNameText : null,
                      hintText: "ابحث ",
                      prefixIcon: IconButton(
                        onPressed: _onSearchClicked,
                        icon: Icon(
                          Icons.search, color: Color(0xff888888), size: 25,),
                      ),
                      suffixIcon: IconButton(
                        onPressed:clearText ,
                        icon: Icon(Icons.clear,color: Color(0xff888888), size: 25,),
                      ),
                      isDense: true,
                      // Added this
                      contentPadding: EdgeInsets.all(12),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff21212133),
                            width: 1.5),
                        borderRadius: BorderRadius.circular(20.0),

                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff21212133),
                            width: 1.5),
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
                    child: Row(
                       // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          for (final cat in categories)
                            GestureDetector(
                              onTap:(){
                                setState(() {
                                  selectedCat=cat.id!;
                                  selectedCatName=cat.eName.toString();
                                  if(selectedCatName=="News"){
                                    getUserSavedNews();
                                    _onSearchClicked();

                                  }
                                  else if(selectedCatName=="Reports"){
                                    getUserSavedReports();
                                    _onSearchClicked();

                                  }
                                  else if(selectedCatName=="Media"){
                                    getUserSavedMedia();
                                    _onSearchClicked();

                                  }
                                } );

                              },
                              child: Container(
                                padding: const EdgeInsets.all(13.0),
                                child: Text(cat.name!,
                                    style: selectedCat == cat.id ? TextStyle(
                                      color: Color(0xff8F3F71),
                                      fontSize: 16,
                                    ) : TextStyle(color: Color(0xff888888),
                                      fontSize: 16,
                                    )),
                                decoration: selectedCat == cat.id
                                    ? BoxDecoration(
                                    border: Border(bottom: BorderSide(
                                      color: Color(0xff8F3F71),
                                      width: 2,),
                                    )) :
                                BoxDecoration(
                                    border: Border(bottom: BorderSide(
                                      color: Color(0xff888888),),

                                    )),
                              ),
                            )
                        ]),
                  ),
                ),
                (isSearch==true )?

                  Padding(
                    padding: const EdgeInsets.only(top:20),
                    child: Container(
                    child: Center(
                      child:  Text("عدد نتائج البحث :${searchResult.length}",style:TextStyle(fontSize: 16.sp,color:Color(0xff8F3F71),fontFamily: 'Cairo')
                      ),
                    ),
                ),
                  ): Padding(
      padding: const EdgeInsets.only(top:30),
      child: Container(
        child: Center(
          child:  Text("",style: TextStyle(fontSize: 12.sp,color:Color(0xff8F3F71) , )
          ),
        ),
      ),
    ),
    if(isVisible==true)
                  Container(
                      color:Colors.black12,

                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),

                        itemBuilder: (BuildContext context,index){

                          return Padding(
                            padding: const EdgeInsets.only(right: 14, left: 14, top: 14),


                            child: GestureDetector(
                              onTap: () {
                                if(selectedCatName=="News") {
                                  getNewsByID(searchResult[index].id).then((value) =>
                                  {

                                    gotoNews(value,userID)

                                  });
                                }
                                else if(selectedCatName=="Reports"){
                                  getReportByID(searchResult[index].id).then((value) =>
                                  {

                                    gotoReports(value,userID)

                                  });
                                }
                                else if(selectedCatName=="Media"){
                                  getMediaByID(searchResult[index].id).then((value) =>
                                  {

                                    gotoMedia(value,userID)

                                  });
                                }
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      15.0),
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

                                            },
                                            child: Container(
                                              width: 97.0,
                                              height: 120,
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius
                                                      .circular(17),
                                                  child: Image.network(
                                                    searchResult[index].image
                                                        .toString(),
                                                    fit: BoxFit.cover,
                                                  )
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Flexible(

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Container(
                                            alignment: Alignment
                                                .center,

                                            //height: 20,
                                            // color:Colors.red,
                                            child:  searchResult[index].hashtags ==
                                                null
                                                ? Text("")
                                                : SingleChildScrollView(
                                              scrollDirection: Axis
                                                  .horizontal,

                                            ),
                                          ),
                                          Row(
                                              children: [
                                                Expanded(
                                                  flex:6,
                                                  child: AutoSizeText(searchResult[index].title.toString(), maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,

                                                    style:TextStyle(fontSize: 16.sp,color: Color(0xff212121
                                                    )),minFontSize: 16,maxFontSize: 18,),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: IconButton(onPressed: () async {

                                                    var msg ="";

                                                    if(selectedCatName=="News") {
                                                      if (intbookmarks.contains(
                                                          searchResult[index].id) ==
                                                          true) {
                                                        msg = await NewsService()
                                                            .unBookmarkNews(
                                                            userID: userID,
                                                            parentID: int.parse(
                                                                searchResult[index]
                                                                    .id
                                                                    .toString()));
                                                        //  print(msg);
                                                        setState(() {
                                                          intbookmarks.remove(searchResult[index]
                                                              .id);
                                                          (intbookmarks.contains(
                                                              searchResult[index]
                                                                  .id) == false);
                                                          getUserSavedNews();
                                                        });

                                                      } else
                                                      if (intbookmarks.contains(
                                                          searchResult[index].id) ==
                                                          false) {
                                                        msg = await NewsService()
                                                            .bookmarkNews(
                                                            userID: userID,
                                                            parentID: int.parse(
                                                                searchResult[index]
                                                                    .id
                                                                    .toString()));
                                                        //  print(msg);
                                                        setState(() {
                                                          (intbookmarks.contains(
                                                              searchResult[index]
                                                                  .id) == true);
                                                          getUserSavedNews();
                                                        });
                                                      }
                                                      return showDialog<void>(
                                                          context: context,
                                                          barrierDismissible: false,
                                                          // user must tap button!
                                                          builder: (
                                                              BuildContext context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'نجاح'),
                                                              content: SingleChildScrollView(
                                                                child: ListBody(
                                                                  children: <
                                                                      Widget>[
                                                                    Text(msg),
                                                                  ],
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  child: const Text(
                                                                      'حسنا'),
                                                                  onPressed: () {
                                                                    Navigator
                                                                        .of(
                                                                        context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          }
                                                      );
                                                    }
                                                    else if (selectedCatName ==
                                                        "Reports") {
                                                      if (intbookmarks.contains(
                                                          searchResult[index]
                                                              .id) == true) {
                                                        msg = await ReportsService().unBookmarkReports(
                                                            userID: userID,
                                                            parentID: int.parse(
                                                                searchResult[index]
                                                                    .id
                                                                    .toString()));
                                                        //  print(msg);
                                                        setState(() {
                                                          intbookmarks.remove( searchResult[index]
                                                              .id);
                                                          (intbookmarks.contains(
                                                              searchResult[index].id) == false);
                                                          getUserSavedReports();
                                                        });

                                                      } else
                                                      if (intbookmarks.contains(
                                                          searchResult[index]
                                                              .id) == false) {
                                                        msg = await ReportsService().bookmarkReports(
                                                            userID: userID,
                                                            parentID: int.parse(
                                                                searchResult[index]
                                                                    .id
                                                                    .toString()));
                                                        //  print(msg);
                                                        setState(() {
                                                          (intbookmarks.contains(
                                                              searchResult[index]
                                                                  .id) == true);
                                                          getUserSavedReports();
                                                        });
                                                      }

                                                      return showDialog<void>(
                                                          context: context,
                                                          barrierDismissible: false,
                                                          // user must tap button!
                                                          builder: (
                                                              BuildContext context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'نجاح'),
                                                              content: SingleChildScrollView(
                                                                child: ListBody(
                                                                  children: <
                                                                      Widget>[
                                                                    Text(msg),
                                                                  ],
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  child: const Text(
                                                                      'حسنا'),
                                                                  onPressed: () {
                                                                    Navigator
                                                                        .of(
                                                                        context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          }
                                                      );
                                                    }
                                                    else if (selectedCatName ==
                                                        "Media") {
                                                      if (intbookmarks.contains(
                                                          searchResult[index]
                                                              .id) == true) {
                                                        msg =
                                                        await MediaService().unBookmarkMedia(
                                                            userID: userID,
                                                            parentID: int.parse(
                                                                searchResult[index]
                                                                    .id
                                                                    .toString()));
                                                        //  print(msg);
                                                        setState(() {
                                                          intbookmarks.remove( searchResult[index]
                                                              .id);
                                                          (intbookmarks
                                                              .contains(
                                                              searchResult[index]
                                                                  .id) ==
                                                              false);
                                                          getUserSavedMedia();
                                                        });

                                                      } else
                                                      if (intbookmarks.contains(
                                                          searchResult[index]
                                                              .id) == false) {
                                                        msg = await MediaService()
                                                            .bookmarkMedia(
                                                            userID: userID,
                                                            parentID: int.parse(
                                                                searchResult[index]
                                                                    .id
                                                                    .toString()));
                                                        //  print(msg);
                                                        setState(() {
                                                          (intbookmarks
                                                              .contains(
                                                              searchResult[index]
                                                                  .id) == true);
                                                          getUserSavedMedia();
                                                        });
                                                      }
                                                      return showDialog<void>(
                                                          context: context,
                                                          barrierDismissible: false,
                                                          // user must tap button!
                                                          builder: (
                                                              BuildContext context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'نجاح'),
                                                              content: SingleChildScrollView(
                                                                child: ListBody(
                                                                  children: <
                                                                      Widget>[
                                                                    Text(msg),
                                                                  ],
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  child: const Text(
                                                                      'حسنا'),
                                                                  onPressed: () {
                                                                    Navigator
                                                                        .of(
                                                                        context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          }
                                                      );
                                                    }



                                                  },
                                                      icon: intbookmarks.contains(searchResult[index].id) ? Icon(Icons.bookmark, color: Color(0xff212121),
                                                          size: 25.0): Icon(Icons.bookmark_outline, color: Color(0xff212121),
                                                          size: 25.0)),
                                                ),]
                                          ),  SizedBox(height: 8,),

                                          searchResult[index].hashtags == null
                                              ? Padding(
                                            padding: const EdgeInsets
                                                .only(top: 10.0),
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
                                                            text:  searchResult[index]
                                                                .createDate
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 15)
                                                        ),
                                                        WidgetSpan(
                                                          child: Icon(
                                                            Icons
                                                                .calendar_today_rounded,
                                                            size: 16,),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),

                                              ],
                                            ),
                                          )
                                              :
                                          Padding(
                                            padding: const EdgeInsets
                                                .only(top: 17.0),
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
                                                            text: searchResult[index]
                                                                .createDate
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 14)
                                                        ),
                                                        WidgetSpan(
                                                          child: Icon(
                                                            Icons
                                                                .calendar_today_rounded,
                                                            size: 16,),
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
                        itemCount:  searchResult.length,
                        shrinkWrap: true,
                      )
                  )
                else if(isVisible==false)
                  Container(
                    child:   Transform.scale(
                      scale: 0.1,

                      child: Center(
                        child: LoadingIndicator(
                            indicatorType: Indicator.ballRotateChase, /// Required, The loading type of the widget
                            colors: const [Colors.blue],       /// Optional, The color collections
                            strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
                            //backgroundColor: Colors.white,      /// Optional, Background of the widget
                            pathBackgroundColor: Colors.green   /// Optional, the stroke backgroundColor
                        ),
                      ),
                    ),
                  )
              ]),
        )
    );
  }


  _onSearchClicked() {
   // print("onseatrch"+_name);
    TextEditingController controllerFullName = TextEditingController();
    if (_name != null && _name.isNotEmpty && _name != " ") {
      //TextEditingController controllerEmail=TextEditingController();
      setState(() {
        loadResult(selectedCat, selectedCatName, _name, userTopics);
        if(searchResult.length>0){
          isVisible = true;
        }
        else{
          isVisible = false;

        }
      });

      //print(_name);
     // print(selectedCat);
      //print(selectedCatName);
     // print(userTopics);
//loadResult(id, catName, userID)
//items= await SearchService().search(mainCatID: selectedCat, mainCatName: selectedCatName, searchItem: _name, selectedTopics: userTopics);
// print(searchResult.length);

    }
  }
  void clearText() {
    fieldText.clear();
    setState(() {
      searchResult.clear();

      //isVisible = false;
    });
  }


}