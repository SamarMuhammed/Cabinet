import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reidsc/data/model/cashMarkets/CashMarkets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'package:idsc/data/model/Indicators/InterIndData.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      supportedLocales: [
        Locale('ar', ''), // English, no country code
      ],
      title: "GFG",
      theme: new ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      //  home: CashMarketCard()
    );
  }
}

class CashMarketCard extends StatefulWidget {
  const CashMarketCard({Key? key, required this.data}) : super(key: key);
  final CashMarkets data;
  //final Indicators ind;

  @override
  _CashMarketCardState createState() => _CashMarketCardState();
}

class _CashMarketCardState extends State<CashMarketCard> {
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    //print(widget.data.indicators!.length);
    //print( widget.data.indicators![1].id! );
    // print(widget.data.indicators![3].name);
//  WidgetsFlutterBinding.ensureInitialized();

    // Plugin must be initialized before using
    // FlutterDownloader.initialize(
    //  debug: true ,// optional: set to false to disable printing logs to console (default: true)
    //ignoreSsl: true // option: set to false to disable working with http links (default: false)
    //);

    // FlutterDownloader.registerCallback(downloadCallback);
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
                  fontSize: 14.sp,
                  //   fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              minFontSize: 14,
              maxFontSize: 16,
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8).r,
              child: AutoSizeText(
                ' ${widget.data.indicators![widget.data.indicators!.length - 1].value.toString()} ${widget.data.indicators![widget.data.indicators!.length - 1].unit.toString()}',
                style: TextStyle(
                    color: Color(0xff8F3F71),
                    fontSize: 18.sp,
                    //   fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                minFontSize: 18,
                maxFontSize: 20,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50.0,
                ),
                Expanded(
                  flex: 4,
                  child: AutoSizeText(
                    widget.data.indicators![0].name!,
                    style: TextStyle(fontSize: 15.sp, color: Color(0xff0D005F)),
                    minFontSize: 15,
                    maxFontSize: 17,
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        if (widget
                                .data
                                .indicators![widget.data.indicators!.length - 3]
                                .value! >=
                            0)
                          Icon(
                            Icons.arrow_upward,
                            color: Colors.red,
                            size: 14,
                          )
                        else
                          Icon(Icons.arrow_downward,
                              color: Colors.green, size: 14),
                        AutoSizeText(
                          ' ${widget.data.indicators![widget.data.indicators!.length - 3].value.toString()} ${widget.data.indicators![widget.data.indicators!.length - 3].unit.toString()}',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: widget
                                        .data
                                        .indicators![
                                            widget.data.indicators!.length - 3]
                                        .value! >=
                                    0
                                ? Colors.red
                                : Colors.green,
                          ),
                          minFontSize: 15,
                          maxFontSize: 17,
                        )
                      ],
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50.0,
                ),
                Expanded(
                    flex: 4,
                    child: AutoSizeText(
                      widget.data.indicators![1].name!,
                      style:
                          TextStyle(fontSize: 15.sp, color: Color(0xff0D005F)),
                      minFontSize: 15,
                      maxFontSize: 17,
                    )),
                Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        if (widget
                                .data
                                .indicators![widget.data.indicators!.length - 2]
                                .value! >=
                            0)
                          Icon(Icons.arrow_upward, color: Colors.red, size: 14)
                        else
                          Icon(Icons.arrow_downward,
                              color: Colors.green, size: 14),
                        AutoSizeText(
                          ' ${widget.data.indicators![widget.data.indicators!.length - 2].value.toString()} ${widget.data.indicators![widget.data.indicators!.length - 2].unit.toString()}',
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: widget
                                          .data
                                          .indicators![
                                              widget.data.indicators!.length -
                                                  2]
                                          .value! >=
                                      0
                                  ? Colors.red
                                  : Colors.green),
                          minFontSize: 15,
                          maxFontSize: 17,
                        )
                      ],
                    ))
              ],
            ),
            Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  //  color: Colors.purple
                  ),
              child: Row(
                // crossAxisAlignment: WrapCrossAlignment.center,

                children: [
                  Expanded(
                    flex: 5,
                    child: Center(
                      child: Wrap(children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
                          child: Icon(
                            Icons.calendar_today_outlined,
                            size: 25,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0.r),
                          child: AutoSizeText(
                            widget.data.indicators![0].date.toString(),
                            style: TextStyle(fontSize: 15.sp),
                            minFontSize: 15,
                            maxFontSize: 17,
                          ),
                        )
                      ]),
                    ),
                  ),

                  /*  Expanded(
                                flex: 1,
                                child:

                                Container(
                                  padding: EdgeInsets.only(bottom: 0),
                                  decoration: BoxDecoration(
                                    color: Color(0xffDCB265),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10)
                                    ),


                                  ), height: 40,
                                  child: Center(
                                    child: IconButton(
                                      padding: EdgeInsets.zero,

                                      constraints: BoxConstraints(),
                                      alignment: Alignment.bottomLeft,
                                      color: Colors.white,
                                      onPressed: () {
                                        /*openAttach(widget.data.attachmentURL.toString());*/
                                      },
                                      icon: Icon(Icons.download),
                                    ),
                                  ),
                                ),
                              ),*/
                ],
              ),
            )
          ],
        )),
      ),
      color: Colors.white,
    );
  }
}
