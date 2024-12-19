import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reidsc/core/services/MediaService.dart';
import 'package:reidsc/core/services/UserService.dart';
import 'package:reidsc/data/model/media/Media.dart';
import 'package:reidsc/ui/media/MediaDetailsScreen.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
class InfoMedia extends StatefulWidget {
  const InfoMedia({Key? key}) : super(key: key);

  @override
  State<InfoMedia> createState() => _InfoMediaState();
}

class _InfoMediaState extends State<InfoMedia> {
  late List<Media> mediaList=[];
  late List<String> bookmarks =[];
  late  List<int> intbookmarks=[];
  var userID = 0;
  bool isBookmarked=false;
  late String topictest;
  static const _pageSize = 5;

  final PagingController<int, Media> _pagingController =
  PagingController(firstPageKey: 0);


  @override
  void initState() {
    // TODO: implement initState

    loginStatus();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);

    });
    getuserSavedData();

    super.initState();
  }
  void loginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    userID = prefs.getInt("UserID") == null ?0:prefs.getInt("UserID")!;
    //print(userID);
    final userItems = await UserService().getUserById( userId: userID);
    //print(userItems);
    topictest = prefs.getString("SavedTopics") == null ?"":prefs.getString("SavedTopics")!;
    //print("topictest:$topictest");
  }
  void getuserSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // userID = prefs.getInt("UserID") == null ?0:prefs.getInt("UserID")!;
    //print(userID);
   // print("hiiii");
    final userItems = await UserService().getUserById( userId: userID);
    //print(userItems);
    topictest = prefs.getString("SavedTopics") == null ?"":prefs.getString("SavedTopics")!;
    //print("topictest:$topictest");
    setState(() {
      String bookmarkedmedia=userItems.savedMedia.toString();
      bookmarks = bookmarkedmedia.split(',');
      // print(bookmarks.length);
      //print(bookmarks[0]);
      intbookmarks = bookmarks.map(int.parse).toList();
      // print(intbookmarks.length);
      //print(intbookmarks[0]);
      //print(topictest);
      // print("byyyyyye");

    });




  }


  Future<void> _fetchPage(int pageKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      topictest = prefs.getString("SavedTopics") == null ?"":prefs.getString("SavedTopics")!;

      final newItems = await MediaService().getAllMedia(topicID: topictest, catID: 24, page: pageKey);
      print(newItems.length);
      print(newItems[0].title);
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
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF4F4F4),
        body: RefreshIndicator(
            onRefresh: () => Future.sync(
                  () => _pagingController.refresh(),
            ),
            child: PagedGridView<int, Media>(
              //  itemCount: mediaList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio:5.0 / 10.0,
                  crossAxisCount: 2,
                ),
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Media>(

                    itemBuilder: (context, item, index) => InkWell(

                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => MediaDetails(
                                mediaD: item,
                                userID: userID,
                                Type:item.categoryName!
                            ),
                          ),
                        );
                      },
                      child: Padding(
                          padding: EdgeInsets.all(5.r),
                          child: Card(
                              semanticContainer: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(item.attachments![0].attach.toString()),
                                              fit: BoxFit.fill),
                                        ),
                                      )
                                  ),
                                  Padding
                                    (
                                      padding: EdgeInsets.all(10.0.r),
                                      child: AutoSizeText(
                                        item.title.toString(),maxLines: 2,
                                        style: TextStyle(fontSize: 16.0.sp,height: 1.5, // the height between text, default is null
                                            letterSpacing: 1.0,fontWeight: FontWeight.bold),
                                        minFontSize: 15,maxFontSize: 16,)),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Padding
                                          (
                                            padding: EdgeInsets.all(10.0.r),
                                            child: Icon(Icons.date_range_rounded,  color: Colors.black45,)),
                                        Padding
                                          (
                                            padding: EdgeInsets.all(3.0.r),
                                            child: AutoSizeText(
                                              item.createDate.toString(),
                                              style: TextStyle(  color: Colors.black45,),
                                              minFontSize: 15,maxFontSize: 16,)),
                                        IconButton(onPressed: () async {
                                          if(intbookmarks.contains(item.id)== true) {
                                            var msg= await MediaService().unBookmarkMedia(
                                                userID: userID,
                                                parentID: int.parse(
                                                    item.id.toString()));
                                            //  print(msg);
                                            setState(() {
                                              intbookmarks.remove( item
                                                  .id);
                                              (intbookmarks.contains( item.id)== false);
                                              getuserSavedData();
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
                                          }else if(intbookmarks.contains( item.id)==false){
                                            var msg =  await MediaService().bookmarkMedia(userID: userID, parentID: int.parse( item.id.toString()));
                                            //  print(msg);
                                            setState(() {
                                              (intbookmarks.contains( item.id)==true);

                                              getuserSavedData();
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
                                            icon:intbookmarks.contains( item.id)?
                                            Icon(Icons.bookmark, color: Color(0xff212121),
                                                size: 25.0):  Icon(Icons.bookmark_outline, color: Color(0xff212121),
                                                size: 25.0))
                                      ],
                                    ),
                                  )
                                ],
                              ))),
                    )
                )

            )
        )
    );


  }
}
