import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/services/MediaService.dart';
import 'package:reidsc/core/services/UserService.dart';
import 'package:reidsc/ui/media/VideoMediaScreen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reidsc/data/model/media/Media.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reidsc/ui/media/MediaCategoriesScreen.dart';

//final List<Widget> imageSliders = imgList;f
var urlimage="";
var imageURL = "";
int Mlength=0;
class MediaDetails extends StatefulWidget {
  const MediaDetails({Key? key, required this.mediaD,required this.Type, required this.userID,}) : super(key: key);
  final Media mediaD;
  final int userID;

  final String Type;


  @override
  State<MediaDetails> createState() => _MediaDetailsState();
}

class _MediaDetailsState extends State<MediaDetails> {
  List<String> result=[];
  List<Attachments> imgList=[];
  late String _localPath;

  int progress = 0;
  int? resultt;
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

  ReceivePort _receivePort = ReceivePort();

  static downloadingCallback(id, status, progress) {
    ///Looking up for a send port
    SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");

    ///ssending the data
    sendPort?.send([id, status, progress]);
  }
  //var msg;
  // var msg;
  //final List<Color> colorCodes = [Colors.red,Colors.amber,Colors.amber];

  late String topictest;


  void getUserSavedMedia() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // userID = prefs.getInt("UserID") == null ?0:prefs.getInt("UserID")!;

    final userItems = await UserService().getUserById( userId: widget.userID);
    //print(userItems);
    topictest=userItems.savedTopics.toString();
    setState(() {
      // print("userID$userID");
      String bookmarkednews=userItems.savedMedia.toString();
      bookmarks = bookmarkednews.split(',');
      //print(bookmarks.length);
      //print(bookmarks[0]);
      intbookmarks = bookmarks.map(int.parse).toList();
      //print(intbookmarks.length);
      //print(intbookmarks[0]);
      //print(topictest);
      //print("byyyyyye");

    });
    // print("hiiii");




  }
  @override
  void initState() {
//print("inpytP");
    print(widget.mediaD.toJson());
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
    // TODO: implement initStat
    getUserSavedMedia();
    super.initState();
    Mlength=widget.mediaD.attachments!.length;
    print('Mlength$Mlength');
    for (int i=0; i<Mlength;i++) {
      imageURL = widget.mediaD.attachments![i].attach.toString();
    }
    //print('imageURL$imageURL');
    imgList=widget.mediaD.attachments!;
    String text =widget.mediaD.hashtags?.isEmpty==false? widget.mediaD.hashtags.toString():"";
    result = text.split(',');
    result.removeWhere((item) => ["", null, false, 0].contains(item));

    // msg=  NewsService().bookmarkNews(userID: 1, parentID: int.parse(widget.newD.id.toString()));
    // print(msg);
    //print("Hashtag "+result[0]);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    player.stop();
    player.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,

          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(" تفاصيل الوسائط", style: TextStyle(fontSize: 17,fontFamily: 'Cairo')
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,

          actions: [


            IconButton(onPressed: (){
              player.stop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MediaCategories()),
              );


            }, icon: const Icon(Icons.arrow_back_ios,textDirection: TextDirection.ltr),color: Colors.black,)
          ],
          titleTextStyle:  TextStyle(
              color: Colors.black,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold
          ),
        ),
        body:

        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
              children:[
                if( widget.Type == "Infographic ")

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height:MediaQuery.of(context).size.height/3,
                    child: CarouselSlider(

                      options: CarouselOptions(

                        aspectRatio: 1,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        initialPage: 1,
                        autoPlay: true,
                      ),
                      items:imgList
                          .map((item) => InkWell(
                        onTap: () async {
                          await showDialog(
                              context: context,
                              builder: (_) => ImageDialog(item.attach.toString())
                          );
                        },
                        child: Container(
                          child: Center(
                              child:

                              Image.network(item.attach.toString(), fit: BoxFit.fitWidth, colorBlendMode: BlendMode.colorDodge,)),
                        ),
                      )).toList(),
                    ),
                  )
                else if(widget.Type == "Video ")
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height:MediaQuery.of(context).size.height/3,
                    child: VideoPlay(
                      pathh: widget.mediaD.attachments![0].attach.toString(),
                    ),
                  )
                else if(widget.Type == "Audio Broadcast")
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height:MediaQuery.of(context).size.height/3,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100.withOpacity(0.55),
                        image: DecorationImage(
                          image: AssetImage('assets/images/audioimage.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child:Padding(
                        padding:  EdgeInsets.only(top:250.0.r),
                        child: Container(

                          height:MediaQuery.of(context).size.height/3,
                          child: Row(
                            children: [

                              Expanded(
                                  child:
                                  RotatedBox(
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
                                        setState(() {
                                          seekval=value.round();
                                        });

                                         await player
                                            .seek(Duration(
                                            milliseconds:
                                            seekval));
                                        if (result == 1) {
                                          //seek successful
                                          setState(() {
                                            currentpos = seekval;
                                          });
                                        } else {
                                          print("Seek unsuccessful.");
                                        }
                                      },
                                    ),
                                  )),
                              Text(
                                "${currentpostlabel}",

                                style: TextStyle(color: Colors.white),

                              ),
                              IconButton(
                                  onPressed: () async {
                                    if (widget.mediaD.attachments![0]
                                        .playingstatus ==
                                        0) {
                                   //   resultt = await player.stop();
                                       await player.play(UrlSource(widget.mediaD.attachments![0].attach!));
                                      setState(() {
                                        for (int i = 0;
                                        i < widget.mediaD.attachments!.length;
                                        i++) {
                                          widget.mediaD.attachments![0]
                                              .playingstatus = 0;
                                        }
                                        widget.mediaD.attachments![0]
                                            .playingstatus = 1;
                                      });
                                    } else if (widget.mediaD.attachments![0]
                                        .playingstatus ==
                                        1) {
                                    await player.stop();
                                      setState(() {
                                        for (int i = 0;
                                        i < widget.mediaD.attachments!.length;
                                        i++) {
                                          widget.mediaD.attachments![0]
                                              .playingstatus = 0;
                                        }
                                      });
                                    }
                                  },
                                  icon: widget.mediaD.attachments![0]
                                      .playingstatus ==
                                      0
                                      ? Center(
                                      child: Icon(
                                          Icons.play_arrow))
                                      : Icon(Icons.pause),
                                  color: Color(0xff8F3F71)
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                ,
                Container(
                  color: Color(0xff0D005F),
                  child: Row(
                    children: [
                      Expanded(
                          flex:5,
                          child:  Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Row(
                                children: [
                                  Icon(Icons.date_range_rounded,color:Colors.white),
                                  Text(widget.mediaD.createDate.toString(),style: TextStyle(color: Colors.white),),

                                ]),
                          )),
                      Expanded(
                          flex:2,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xff384153)
                            ),
                            child: IconButton(onPressed: () async {
                              //  Share.share(newD.title.toString());
                              if(widget.Type =="Audio Broadcast")

                                urlimage = 'http://new.idscapp.gov.eg/images/media.png';
                              else if(widget.Type == "Video ")
                                urlimage = 'http://new.idscapp.gov.eg/images/media.png';
                              else if(widget.Type =="Infographic ")
                                urlimage = widget.mediaD.attachments![0].attach.toString();

                              final url= Uri.parse(urlimage);
                              final response= await get(url);
                              final bytes = response.bodyBytes;
                              final Directory temp = await getTemporaryDirectory();
                              final path = '${temp.path}/Image.jpg';
                              File(path).writeAsBytesSync(bytes);
                              await  Share.shareFiles([path], text:'${widget.mediaD.title.toString()} ${widget.mediaD.attachments![0].attach.toString()}\n'
                                  ' تطبيق IDSC''\n https://onelink.to/eqzrkm');
                              //  Share.shareFiles(['http://41.128.217.181:10092/images/topics/unchecked/culture.png'], text: newD.title.toString());
                            },  icon: const Icon(Icons.share,color:Colors.white,size: 30,)),
                          )),
                      Expanded(
                          flex:2,
                          child:  IconButton(onPressed: () async {

                            if(intbookmarks.contains(widget.mediaD.id)==true) {
                              var msg= await MediaService().unBookmarkMedia(
                                  userID: widget.userID,
                                  parentID: int.parse(
                                      widget.mediaD.id.toString()));
                              //  print(msg);
                              setState(() {
                                intbookmarks.remove(widget.mediaD.id);
                                (intbookmarks.contains(widget.mediaD.id)== false);
                                getUserSavedMedia();
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
                                          Text(
                                              msg),
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
                            }else if(intbookmarks.contains(widget.mediaD.id)==false){
                              var msg= await MediaService().bookmarkMedia(userID: widget.userID, parentID: int.parse(widget.mediaD.id.toString()));
                              //  print(msg);
                              setState(() {
                                (intbookmarks.contains(widget.mediaD.id)== true);
                                getUserSavedMedia();
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
                              icon:intbookmarks.contains(widget.mediaD.id) ? Icon(Icons.bookmark, color:Colors.white,size: 30,
                              ): Icon(Icons.bookmark_outline, color:Colors.white,size: 30,
                              ))),


                    ],
                  ),
                )
                ,
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/2.5,
                  padding: EdgeInsets.all(20).r,
                  child: ListView(
                    children: [
                      result.isNotEmpty?Text("") : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            for(var item in result )

                              Padding(
                                padding:  EdgeInsets.all(5.0).r,
                                child: InputChip(

                                  label: Text(item),
                                  labelStyle:TextStyle(
                                      color:Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),
                                  disabledColor: Color(0xffBBBBBB),

                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),

                                ),
                              ),
                          ],
                        ),
                      ),

                      Text(
                        widget.mediaD.title.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          height: 1.5, // the height between text, default is null
                          letterSpacing: 1.0,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),



/*
                      Html(data: widget.mediaD.description.toString()),
*/
                      Text(
                        widget.mediaD.description.toString(),
                        style: TextStyle(
                            fontSize: 18,
                            height: 1.3 ,
                          color: Colors.black//You can set your custom height here

                        ),),
                      SizedBox(
                        height: 20.h,
                      ),




                    ],
                  ),
                ),


              ]
          ),
        )

    );




  }


}
class ImageDialog  extends StatelessWidget {
  // String? pathh;
  ImageDialog(this.pathh);
  final String? pathh;

  @override
  Widget build(BuildContext context) {
    return Dialog(

        backgroundColor: Colors.transparent,
        elevation: 0,
        child:
        Container(
          decoration: BoxDecoration
            (
            color: Colors.transparent,

          ),

          height:MediaQuery.of(context).orientation== Orientation.portrait?  MediaQuery.of(context).size.height/2: MediaQuery.of(context).size.height/1.5 ,

          //   height: MediaQuery.of(context).size.height/2.2,
          width: MediaQuery.of(context).size.width ,
          child: PhotoView(
            customSize: Size(MediaQuery.of(context).size.width,MediaQuery.of(context).size.height*2),
            backgroundDecoration: BoxDecoration(

                color: Colors.transparent
            )
            ,

            initialScale: PhotoViewComputedScale.contained * 1.5,

            maxScale: PhotoViewComputedScale.contained * 8,
            imageProvider:

            NetworkImage(pathh!,


            ),),
        )

    );
  }



}



class VideoDialog  extends StatelessWidget {
  // String? pathh;
  VideoDialog(this.pathh);
  final String? pathh;

  @override
  Widget build(BuildContext context) {
    return Dialog(

        backgroundColor: Colors.transparent,
        elevation: 0,
        child:
        Container(
          decoration: BoxDecoration
            (
            color: Colors.transparent,

          ),

          height:MediaQuery.of(context).orientation== Orientation.portrait?  MediaQuery.of(context).size.height/2: MediaQuery.of(context).size.height/1.5 ,

          //   height: MediaQuery.of(context).size.height/2.2,
          width: MediaQuery.of(context).size.width ,
          child: PhotoView(
            customSize: Size(MediaQuery.of(context).size.width,MediaQuery.of(context).size.height*2),
            backgroundDecoration: BoxDecoration(

                color: Colors.transparent
            )
            ,

            initialScale: PhotoViewComputedScale.contained * 1.5,

            maxScale: PhotoViewComputedScale.contained * 8,
            imageProvider:

            NetworkImage(pathh!,


            ),),
        )

    );
  }



}