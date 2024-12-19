import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'package:reidsc/core/services/PoliciesandInformationsService.dart';
import 'package:reidsc/core/services/PrimeMinisterService.dart';
import 'package:reidsc/data/model/Indicators/IndCategory.dart';
import 'package:reidsc/data/model/PoliciesAndInformations/OwnerShipDocument.dart';
import 'package:reidsc/data/model/PoliciesAndInformations/Vision2030.dart';
import 'package:reidsc/data/model/primeMinister/Biography.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../generic/imageDialog.dart';

class OwnerShipDocumentScreen extends StatefulWidget {
  const OwnerShipDocumentScreen({Key? key}) : super(key: key);

  @override
  _OwnerShipDocumentScreenState createState() =>
      _OwnerShipDocumentScreenState();
}

class _OwnerShipDocumentScreenState extends State<OwnerShipDocumentScreen> {
  late OwnerShipDocument document = new OwnerShipDocument();

  getOwnershipDocument() async {
    var completer = Completer<OwnerShipDocument>();

    await PoliciesandInformationsService()
        .getOwnershipDocument()
        .then((value) => setState(() {
              document = value!;
            }));
    //  return completer.complete( await PrimeMinisterService().getBiography());

    return document;
  }

  @override
  void initState() {
    // TODO: implement initState
    getOwnershipDocument();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getOwnershipDocument(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: MediaQuery.of(context).size.height * 1.5,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    CachedNetworkImage(
                      width: MediaQuery.of(context).size.width,
                      imageUrl:
                          "https://www.cabinet.gov.eg//UI/img/stateownershippolicyEn.png",
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Html(
                            data: document.contentE.toString(),
                            style: {
                              '#': Style(
                                fontSize: FontSize(15),
                                maxLines: 100,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Document: ',
                                    style: GoogleFonts.tajawal(
                                        textStyle: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xffb5102b)))),
                                TextSpan(
                                    text: document.titleE.toString(),
                                    style: GoogleFonts.tajawal(
                                        textStyle: TextStyle(
                                            fontSize: 20, color: Colors.blue)),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        var url =
                                            DioBaseService().Cap_Upload_URL +
                                                document.attachmentE.toString();
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      })
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    /*  Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.all(20).r,
                    child: ListView(
                      //shrinkWrap: true,
                      children: [


                        Text(
                          widget.minister.nameE.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20.sp,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),


                          Html(data: widget.minister.briefE.toString(),style: {
                            '#': Style(
                              fontSize: FontSize(18),
                              maxLines: 100,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          },),






                      ],
                    ),
                  ),
                ],
              ),*/
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Transform.scale(
                scale: 0.1,
                child: Center(
                  child: LoadingIndicator(
                      indicatorType: Indicator.ballRotateChase,

                      /// Required, The loading type of the widget
                      colors: const [Colors.blue],

                      /// Optional, The color collections
                      strokeWidth: 2,

                      /// Optional, The stroke of the line, only applicable to widget which contains line
                      //backgroundColor: Colors.white,      /// Optional, Background of the widget
                      pathBackgroundColor: Colors.green

                      /// Optional, the stroke backgroundColor
                      ),
                ),
              ),
            );
          }
        });
  }
}
