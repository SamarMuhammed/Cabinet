import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'package:reidsc/data/model/Hierarchy/Minister.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../generic/imageDialog.dart';

class MinisterDetails extends StatefulWidget {
  const MinisterDetails({Key? key, required this.minister}) : super(key: key);
  final Minister minister;

  @override
  _MinisterDetailsState createState() => _MinisterDetailsState();
}

class _MinisterDetailsState extends State<MinisterDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Details",
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
              /*     InkWell(
              onTap: () async {
      await showDialog(
      context: context,
      builder: (_) => ImageDialog(imageURL: DioBaseService().Cap_Upload_URL+widget.minister.photo!,)
      );
      },
                child: Container(
                  height: 500,
                  child: PhotoView(
                  imageProvider: NetworkImage(DioBaseService().Cap_Upload_URL+widget.minister.photo!)),
                ),

                ),*/

              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (_) => ImageDialog(
                                imageURL: DioBaseService().Cap_Upload_URL +
                                    widget.minister.photo!,
                              ));
                    },
                    child: Container(
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.height / 2
                          : MediaQuery.of(context).size.height / 1.5,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                DioBaseService().Cap_Upload_URL +
                                    widget.minister.photo!),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              /*    Row(
                children: [
                  Text(
                    widget.minister.nameE.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),*/
              Row(
                children: [
                  Expanded(
                    child: Html(
                      data: widget.minister.briefE.toString(),
                      style: {
                        '#': Style(
                          fontSize: FontSize(18),
                          maxLines: 100,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.phone,
                        color: Color(0xffb5102b),
                      )),
                  Expanded(
                    flex: 12,
                    child: Text(
                      widget.minister.phone.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              if (widget.minister.fax != null)
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.fax,
                          color: Color(0xffb5102b),
                        )),
                    Expanded(
                      flex: 12,
                      child: Text(
                        widget.minister.fax.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.email,
                        color: Color(0xffb5102b),
                      )),
                  Expanded(
                      flex: 12,
                      child: RichText(
                          // textAlign: TextAlign.center,
                          text: TextSpan(children: [
                        TextSpan(
                            text: widget.minister.email,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff8F3F71),
                              // decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                final Uri params = Uri(
                                    scheme: 'mailto',
                                    path: widget.minister.email,
                                    queryParameters: {
                                      'subject': ' Subject',
                                      'body': ' body'
                                    });
                                var url = params.toString();
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }),
                      ]))),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              if (widget.minister.homepage != null)
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.home,
                          color: Color(0xffb5102b),
                        )),
                    Expanded(
                      flex: 12,
                      child: InkWell(
                        onTap: () => {launch(widget.minister.homepage)},
                        child: Text(
                          widget.minister.homepage.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 40.h,
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
      ),
    );
  }
}
