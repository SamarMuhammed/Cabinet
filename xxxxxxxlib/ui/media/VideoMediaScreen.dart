import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/services/MediaService.dart';
import 'package:reidsc/core/services/UserService.dart';
import 'package:reidsc/data/model/media/Media.dart';
import 'package:reidsc/generic/NewsCardWidget.dart';
import 'package:reidsc/main.dart';
import 'package:reidsc/ui/addUser/Login.dart';
import 'package:reidsc/ui/media/MediaDetailsScreen.dart';
import 'package:reidsc/ui/news/NewsDetailsScreen.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
class VideoMedia extends StatefulWidget {
  const VideoMedia({Key? key}) : super(key: key);

  @override
  State<VideoMedia> createState() => _VideoMediaState();
}
class _VideoMediaState extends State<VideoMedia> {
  List<VideoPlayerController> _controllers = [];
  bool isPlaying=false;
  bool isBookmarked=false;
  late List<String> bookmarks =[];
  late  List<int> intbookmarks=[];
  var userID = 0;
  late String topictest;
  static const _pageSize = 10;

  ValueNotifier<VideoPlayerValue?> currentPosition = ValueNotifier(null);
  late VideoPlayerController controller;
  late Future<void> futureController;

  final PagingController<int, Media> _pagingController =
  PagingController(firstPageKey: 0);
  void loginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    userID = prefs.getInt("UserID") == null ?0:prefs.getInt("UserID")!;
    print(userID);
  }
  void getuserSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // userID = prefs.getInt("UserID") == null ?0:prefs.getInt("UserID")!;
    print(userID);
    print("hiiii");
    final userItems = await UserService().getUserById( userId: userID);
    print(userItems);
    topictest = prefs.getString("SavedTopics") == null ?"":prefs.getString("SavedTopics")!;
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
  @override
  void initState() {

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
      loginStatus();
      getuserSavedData();
    });


    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _controllers.forEach((controller) {
      controller.pause();
      controller.dispose();
    });
    super.dispose();

  }

  /// Called when the top route has been popped off, and the current route
  /// shows up.
  @override

  Future<void> _fetchPage(int pageKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      topictest = prefs.getString("SavedTopics") == null ?"":prefs.getString("SavedTopics")!;
      final newItems = await MediaService().getAllMedia( topicID:topictest,catID: 25,page:pageKey);
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
    List<String> paths = [
      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",

    ];
    return Scaffold(

        body: RefreshIndicator(
          onRefresh: () =>
              Future.sync(
                    () => _pagingController.refresh(),
              ),
          child: PagedListView<int, Media>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Media>(
                itemBuilder: (context, item, index) {

                  return  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) =>   MediaDetails(
                            mediaD: item,
                            userID: userID,
                            Type: "Video"
                        ),),
                      );



                    },
                    child: Padding(
                      padding:  EdgeInsets.all(10.0).r,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),

                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,

                          height: 350.h,
                          color: Colors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            //crossAxisAlignment: CrossAxisAlignment.stretch,

                            children: <Widget>[

                              Padding(
                                padding:  EdgeInsets.all(10.0).r,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: VisibilityDetector(
                                    // Must provide key 
                                    key: ValueKey<String>('give any string value to represent key'),
                                    onVisibilityChanged: (visibilityInfo) {
                                      // 0 ---> visible, 1 --> not visible
                                      if(visibilityInfo.visibleFraction == 0){
                                        controller.pause();
                                        controller.dispose();

                                        // might need setState over here 
                                      }
                                    },
                                    child: VideoPlay(
                                      pathh: item.attachments![0].attach.toString(),
                                    ),
                                  ),
                                ),
                              ),


                              Container(

                                child: Padding(
                                  padding:  EdgeInsets.all(10.0.r),
                                  child: Row(
                                      mainAxisSize: MainAxisSize.min,

                                      children: [
                                        Expanded(
                                            child: Padding(
                                              padding:  EdgeInsets.only(
                                                  right: 12.0.r),
                                              child: Text(item.title.toString(),
                                                style:GoogleFonts.tajawal( textStyle: TextStyle(color: Color(0xff212121),
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight
                                                      .bold,), ),
                                              ),
                                            ),
                                            flex: 12
                                        )


                                      ]),
                                ),
                              ),
                              Row(
                                  mainAxisSize: MainAxisSize.min,

                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.only(
                                          right: 20.0.r),
                                      child: Icon(
                                        Icons.date_range, color: Colors.black45,
                                        size: 20.0,),
                                    ),
                                    Padding(
                                        padding:  EdgeInsets.only(
                                            right: 20.0.r),
                                        child: Text(item.createDate.toString(),
                                          style: TextStyle(
                                              color: Colors.black45),
                                        )
                                    )
                                    , Spacer(),
                                    IconButton(onPressed: () async {
                                      if(intbookmarks.contains(item.id)== true) {
                                        var msg= await MediaService().unBookmarkMedia(
                                            userID: userID,
                                            parentID: int.parse(
                                                item.toString()));
                                        //  print(msg);
                                        setState(() {
                                          intbookmarks.remove(item
                                              .id);
                                          (intbookmarks.contains(item.id)== false);
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
                                      }else if(intbookmarks.contains(item.id)==false){
                                        var msg =  await MediaService().bookmarkMedia(userID: userID, parentID: int.parse( item.id.toString()));
                                        //  print(msg);
                                        setState(() {
                                          (intbookmarks.contains(item.id)==true);

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
                                        icon:intbookmarks.contains(item.id)?
                                        Icon(Icons.bookmark, color: Color(0xff212121),
                                            size: 25.0):  Icon(Icons.bookmark_outline, color: Color(0xff212121),
                                            size: 25.0))
                                    ,
                                  ]
                              ),


                            ],
                          ),

                        ),
                      ),
                    )
                    ,
                  );
                }


            ),


          ),
        )
    );
  }

}

class VideoPlay extends StatefulWidget {
  String? pathh;

  @override
  _VideoPlayState createState() => _VideoPlayState();

  VideoPlay({
    Key? key,
    this.pathh, // Video from assets folder
  }) : super(key: key);
}

class _VideoPlayState extends State<VideoPlay> {
  ValueNotifier<VideoPlayerValue?> currentPosition = ValueNotifier(null);
  late VideoPlayerController controller;
  late Future<void> futureController;

  initVideo() {
    controller = VideoPlayerController.network(widget.pathh!);

    futureController = controller.initialize();
  }

  @override
  void initState() {
    initVideo();
    controller.addListener(() {
      if (controller.value.isInitialized) {
        currentPosition.value = controller.value;
      }
    });
    super.initState();
  }




  @override
  void dispose() {
    super.dispose();
    if (controller.value.isPlaying)
      controller.pause();
   // controller.removeListener;
    //controller = null;
    // controller.pause();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureController,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator.adaptive();
        } else {
          return Padding(
            padding:  EdgeInsets.all(8).r,
            child: SizedBox(
              height: 180.h,
              width: double.infinity,
              child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: Stack(children: [
                    Positioned.fill(
                        child: Container(
                            foregroundDecoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(.7),
                                    Colors.transparent
                                  ],
                                  stops: [
                                    0,
                                    .3
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter),
                            ),
                            child: VideoPlayer(controller))),
                    Positioned.fill(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Row(
                              children: [

                                Expanded(
                                    flex: 4,
                                    child: IconButton(
                                      icon: Icon(
                                        controller.value.isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          if (controller.value.isPlaying==true) {
                                            controller.pause();
                                          } else {

                                            controller.play();
                                          }
                                        });
                                      },
                                    )),

                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ])),
            ),
          );
        }
      },
    );
  }
}