import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reidsc/data/model/Indicators/InterIndData.dart';
import 'package:reidsc/data/model/Indicators/InterIndicatorData.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class InterIndCard extends StatefulWidget {
  const InterIndCard({Key? key, required this.data}) : super(key: key);
  final InterIndicatorData data;
  @override
  _InterIndCardState createState() => _InterIndCardState();
}

class _InterIndCardState extends State<InterIndCard> {
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    print(widget.data.name);
//  WidgetsFlutterBinding.ensureInitialized();

    // Plugin must be initialized before using
    // FlutterDownloader.initialize(
    //  debug: true ,// optional: set to false to disable printing logs to console (default: true)
    //ignoreSsl: true // option: set to false to disable working with http links (default: false)
    //);

    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        title: Center(
            child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            AutoSizeText(
              widget.data.name.toString(),
              style: TextStyle(
                  color: Color(0xff0D005F),
                  fontSize: 15.sp,
                  //   fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              minFontSize: 15,
              maxFontSize: 17,
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0).r,
              child: AutoSizeText(
                widget.data.source.toString(),
                style: TextStyle(
                    color: Color(0xff0D005F),
                    fontSize: 15.sp,
                    //    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                minFontSize: 15,
                maxFontSize: 17,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0.r),
              child: AutoSizeText(
                widget.data.items![0].name.toString(),
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15.sp,
                    //       fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                minFontSize: 15,
                maxFontSize: 17,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0.r),
              child: AutoSizeText(
                widget.data.items![0].value.toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 26.sp,
                    //   fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                minFontSize: 26,
                maxFontSize: 28,
              ),
            ),
            Row(
              children: [
                Expanded(
                    flex: 4,
                    child: Center(
                      child: AutoSizeText(
                        widget.data.items![2].name.toString(),
                        style: TextStyle(
                            fontSize: 14.sp, color: Color(0xff0D005F)),
                        minFontSize: 14,
                        maxFontSize: 16,
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: Center(
                      child: Row(
                        children: [
                          if (widget.data.changeRankCheck == true &&
                              widget.data.items![2].value.toString() !=
                                  widget.data.items![1].value.toString())
                            Icon(
                              Icons.arrow_upward,
                              color: Colors.green,
                              size: 16,
                            )
                          else if (widget.data.changeRankCheck == false &&
                              widget.data.items![2].value.toString() !=
                                  widget.data.items![1].value.toString())
                            Icon(
                              Icons.arrow_downward,
                              color: Colors.red,
                              size: 16,
                            ),
                          if (widget.data.items![2].value.toString() ==
                              widget.data.items![1].value.toString())
                            Text(widget.data.items![2].value.toString(),
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))
                          else if (widget.data.changeRankCheck == true)
                            Text(widget.data.items![2].value.toString(),
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold))
                          else if (widget.data.changeRankCheck == false)
                            Text(widget.data.items![2].value.toString(),
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold))
                        ],
                      ),
                    )),
                Expanded(
                    flex: 4,
                    child: Center(
                      child: AutoSizeText(
                        widget.data.items![1].name.toString(),
                        style: TextStyle(
                            fontSize: 14.sp, color: Color(0xff0D005F)),
                        minFontSize: 14,
                        maxFontSize: 16,
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: Center(
                      child: Row(
                        children: [
                          AutoSizeText(
                            widget.data.items![1].value.toString().toString(),
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                            minFontSize: 16,
                            maxFontSize: 18,
                          )
                        ],
                      ),
                    )),
              ],
            ),
            Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  //  color: Colors.purple
                  ),
              child: Padding(
                padding: EdgeInsets.only(right: 8.0, bottom: 0, left: 0).r,
                child: Row(
                  // crossAxisAlignment: WrapCrossAlignment.center,

                  children: [
                    Expanded(
                      flex: 5,
                      child: Wrap(children: [
                        Icon(Icons.calendar_today_outlined),
                        Padding(
                          padding: EdgeInsets.all(8.0).r,
                          child: AutoSizeText(
                            widget.data.date.toString(),
                            style: TextStyle(fontSize: 15.sp),
                            minFontSize: 15,
                            maxFontSize: 16,
                          ),
                        )
                      ]),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 0),
                        decoration: BoxDecoration(
                          color: Color(0xffDCB265),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10)),
                        ),
                        height: 40.h,
                        child: Center(
                          child: IconButton(
                            onPressed: () async {
                              getDialog(context);
                              // await openAttach(widget.data.attachmentURL.toString());
                            },
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            alignment: Alignment.bottomLeft,
                            color: Colors.white,
                            icon: Icon(Icons.download),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )),
      ),
      color: Colors.white,
    );
  }

/*  void getDialog(BuildContext context) {
    setState(() {


      BotToast.showText(text:" بدء التحميل",align: Alignment.topCenter,onClose: (){
        print("ghghgh");
      });

    });



  }*/
  void getDialog(BuildContext context) async {
    var url = widget.data.attachmentURL.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
