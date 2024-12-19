import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reidsc/core/services/MediaService.dart';
import 'package:reidsc/core/services/UserService.dart';
import 'package:reidsc/data/model/media/Media.dart';
import 'package:reidsc/generic/NewsCardWidget.dart';
import 'package:reidsc/ui/addUser/Login.dart';
import 'package:reidsc/ui/media/MediaDetailsScreen.dart';
import 'package:reidsc/ui/news/NewsDetailsScreen.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioMedia extends StatefulWidget {
  const AudioMedia({Key? key}) : super(key: key);

  @override
  State<AudioMedia> createState() => _AudioMediaState();
}



class _AudioMediaState extends State<AudioMedia> {
  int? result;
  int status = 0;

  int maxduration = 100;
  int currentpos = 0;
  String currentpostlabel = "00:00";
  String audioasset = "assets/audio/red-indian-music.mp3";
  bool isplaying = false;
  bool audioplayed = false;
  // late Uint8List audiobytes;
  int _value = 6;

  bool isBookmarked=false;

  AudioPlayer player = AudioPlayer();
  late List<String> bookmarks =[];
  late  List<int> intbookmarks=[];
  var userID = 0;
  late String topictest;


  static const _pageSize = 5;

  final PagingController<int, Media> _pagingController =
  PagingController(firstPageKey: 0);

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      //  ByteData bytes = await rootBundle.load(audioasset); //load audio from assets
      //  audiobytes = bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
      //convert ByteData to Uint8List
      player.onPlayerStateChanged.listen((state) {
        setState(() {
          isplaying = state == PlayerState.playing;
        });
      });
      player.onDurationChanged.listen((Duration d) {
        //get the duration of audio
        maxduration = d.inMilliseconds;
        setState(() {});
      });

      player.onPositionChanged.listen((Duration p) {
        currentpos =
            p.inMilliseconds; //get the current position of playing audio

        //generating the duration label
        int shours = Duration(milliseconds: currentpos).inHours;
        int sminutes = Duration(milliseconds: currentpos).inMinutes;
        int sseconds = Duration(milliseconds: currentpos).inSeconds;

        int rhours = shours;
        int rminutes = sminutes - (shours * 60);
        int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

        currentpostlabel = "$rhours:$rminutes:$rseconds";

        setState(() {
          //refresh the UI
        });
      });
    });
    loginStatus();
    getuserSavedData();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);

    });

    super.initState();
  }
  void loginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    userID = prefs.getInt("UserID") == null ?0:prefs.getInt("UserID")!;
    print(userID);
  }
  void getuserSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // userID = prefs.getInt("UserID") == null ?0:prefs.getInt("UserID")!;
    //print("mediauserid$userID");
    // print("hiiii");
    final userItems = await UserService().getUserById( userId: userID);
    //print(userItems);
    topictest = prefs.getString("SavedTopics") == null ?"":prefs.getString("SavedTopics")!;
    // print("topictest:$topictest");
    setState(() {
      String bookmarkedmedia=userItems.savedMedia.toString();
      bookmarks = bookmarkedmedia.split(',');
      // print(bookmarks.length);
      // print(bookmarks[0]);
      intbookmarks = bookmarks.map(int.parse).toList();
      // print(intbookmarks.length);
      //print(intbookmarks[0]);
      //print(topictest);
      //print("byyyyyye");
    });



  }
  Future<void> _fetchPage(int pageKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    topictest = prefs.getString("SavedTopics") == null ?"":prefs.getString("SavedTopics")!;
    try {
      final newItems = await MediaService()
          .getAllMedia(topicID: topictest, catID: 26, page: pageKey);
      // print(newItems.length);
      //print(newItems[0].title);
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

      body: RefreshIndicator(
        onRefresh: () => Future.sync(
              () => _pagingController.refresh(),
        ),
        child: PagedListView<int, Media>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Media>(
            itemBuilder: (context, item, index) => InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => MediaDetails(mediaD: item,userID: userID, Type: item.categoryName!),
                  ),
                );
              },
              child: Wrap(
                // direction: Axis.horizontal,
                //spacing:1.0,
                //runSpacing: 20.0,
                children: [
                  Padding(
                    padding:
                    EdgeInsets.only(right: 14, left: 14, top: 14).r,
                    child: Container(
                      height: 150.h,
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
                                  padding: EdgeInsets.all(10.0).r,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: 97.w,
                                      height: 120.h,
                                      decoration: BoxDecoration(
                                        // color: Colors.red,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/audioimage.jpg'),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                        //  boxShadow: [
                                        //  BoxShadow(blurRadius: 7.0, color: Colors.black)
                                        //]
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Flexible(
                              child: Container(
                                height: 160.h,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 6,
                                            child: Padding(
                                              padding: const EdgeInsets.only(top:10.0),
                                              child: AutoSizeText(
                                                item.title.toString(),
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    height: 1.5, // the height between text, default is null
                                                    letterSpacing: 1.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff212121)),
                                                minFontSize: 15,maxFontSize: 16,),
                                            )),
                                      ],
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.all(8.0.r),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xffF4F4F4),
                                            border: Border.all(
                                              color: Color(0xffF4F4F4),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        height: 30.h,
                                        child: Row(
                                          children: [


                                            Expanded(
                                                child:(item.attachments![0]
                                                    .playingstatus ==
                                                    1)
                                                    ? RotatedBox(
                                                  quarterTurns:2,
                                                  child: Slider(
                                                    activeColor: Color(
                                                        0xff8F3F71), // The color to use for the portion of the slider track that is active.
                                                    inactiveColor: Color(
                                                        0xff888888), // The color for the inactive portion of the slider track.
                                                    thumbColor:
                                                    Color(0xff8F3F71),
                                                    value: double.parse(
                                                        currentpos
                                                            .toString()),
                                                    min: 0,
                                                    max: double.parse(
                                                        maxduration
                                                            .toString()),
                                                    label: currentpostlabel,
                                                    onChanged: (double
                                                    value) async {
                                                      int seekval =
                                                      value.round();
                                                     await player.seek
                                                          (Duration(
                                                          milliseconds:
                                                          seekval));
                                                      if (result == 1) {
                                                        //seek successful
                                                        currentpos =
                                                            seekval;
                                                      } else {
                                                        print(
                                                            "Seek unsuccessful.");
                                                      }
                                                    },
                                                  ),
                                                ) :RotatedBox(
                                                  quarterTurns:2,
                                                  child: AbsorbPointer(
                                                    child: AbsorbPointer(
                                                      child: Slider(
                                                        activeColor: Color(
                                                            0xff8F3F71), // The color to use for the portion of the slider track that is active.
                                                        inactiveColor: Color(
                                                            0xff888888), // The color for the inactive portion of the slider track.
                                                        thumbColor:
                                                        Color(0xff8F3F71),
                                                        value: 0,
                                                        min: 0,
                                                        max: double.parse(
                                                            maxduration
                                                                .toString()),

                                                        label: currentpostlabel,

                                                        onChanged: null,
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                            IconButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    for(var i = 0;i<_pagingController.itemList!.length;i++)
                                                    {
                                                      if(_pagingController.itemList![i].id==item.id)
                                                      {
                                                        if(item.attachments![0]!.playingstatus ==0) {
                                                          item.attachments![0]!
                                                              .playingstatus = 1;
                                                          player.play(
                                                              UrlSource( item.attachments![0]
                                                                  .attach!));
                                                        }
                                                        else {
                                                          item.attachments![0]!
                                                              .playingstatus = 0;
                                                          player.stop();
                                                        }
                                                      }
                                                      else
                                                      {
                                                        _pagingController.itemList![i].attachments![0].playingstatus= 0;
                                                      }
                                                    }



                                                  });
                                                },
                                                icon:(item.attachments![0].playingstatus == 0)
                                                    ?Icon(Icons.play_arrow)
                                                    :Icon(Icons.pause),
                                                color: Color(0xff8F3F71)
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:  EdgeInsets.only(
                                              right: 20.0.r),
                                          child: Icon(
                                            Icons.calendar_today_rounded,
                                            color: Colors.black45,
                                            size: 20.0,
                                          ),
                                        ),
                                        Padding(
                                            padding:  EdgeInsets.only(
                                                right: 10.0.r),
                                            child: AutoSizeText(
                                              item.createDate.toString(),
                                              style: TextStyle(
                                                  color: Colors.black45),
                                              minFontSize: 15,maxFontSize: 16, )),
                                        Spacer(),

                                        IconButton(onPressed: () async {
                                          if(intbookmarks.contains(item.id)== true) {
                                            var msg= await MediaService().unBookmarkMedia(
                                                userID: userID,
                                                parentID: int.parse(
                                                    item.id.toString()));
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
                                            var msg =  await MediaService().bookmarkMedia(userID: userID, parentID: int.parse(item.id.toString()));
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
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    player.dispose();

    super.dispose();
  }
}

