import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'package:reidsc/core/services/LicenseService.dart';
import 'package:reidsc/data/model/license/License.dart';

import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../generic/imageDialog.dart';

class LicenseScreen extends StatefulWidget {
  final License license;

  const LicenseScreen({Key? key, required this.license}) : super(key: key);

  @override
  _LicenseScreenState createState() => _LicenseScreenState();
}

class _LicenseScreenState extends State<LicenseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Golden License",
            style: GoogleFonts.tajawal(textStyle: TextStyle(fontSize: 20.sp))),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,

        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_forward_ios,
                textDirection: TextDirection.ltr),
            color: Colors.black,
          )
        ],
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 22.sp, fontWeight: FontWeight.bold),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 1.5,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 1,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        initialPage: 1,
                        autoPlay: true,
                      ),
                      items: widget.license.photos!
                          .map((item) => InkWell(
                                onTap: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (_) => ImageDialog(
                                            imageURL: DioBaseService()
                                                    .Cap_Upload_URL +
                                                item,
                                          ));
                                },
                                child: Container(
                                  child: Center(
                                      child: Image.network(
                                    DioBaseService().Cap_Upload_URL +
                                        item.toString(),
                                    fit: BoxFit.fitWidth,
                                    colorBlendMode: BlendMode.colorDodge,
                                  )),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Html(
                      data: widget.license.contentE.toString(),
                      style: {
                        '#': Style(
                          fontSize: FontSize(16),
                          maxLines: 100,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: InkWell(
                      onTap: () => {
                        launch(DioBaseService().Cap_Upload_URL +
                            widget.license.attachmentE.toString())
                      },
                      child: Text(
                        "Download Golden License Guide",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w800,
                            fontSize: 15.sp,
                            color: Color(0xffb5102b)),
                      ),
                    ),
                  ),
                ],
              )
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
      ),
    );
  }
}
