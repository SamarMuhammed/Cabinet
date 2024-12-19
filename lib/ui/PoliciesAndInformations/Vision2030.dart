import 'dart:async';
import 'package:html/parser.dart' as htmlParser;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/Helper/LangHelper.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'package:reidsc/core/services/PoliciesandInformationsService.dart';
import 'package:reidsc/core/services/PrimeMinisterService.dart';
import 'package:reidsc/data/model/Indicators/IndCategory.dart';
import 'package:reidsc/data/model/PoliciesAndInformations/Vision2030.dart';
import 'package:reidsc/data/model/primeMinister/Biography.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../generic/imageDialog.dart';

class Vision2030Screen extends StatefulWidget {
  const Vision2030Screen({Key? key}) : super(key: key);

  @override
  _Vision2030ScreenState createState() => _Vision2030ScreenState();
}

class _Vision2030ScreenState extends State<Vision2030Screen> {
  late Vision2030 vision = new Vision2030();
  String currentLanguage = 'en';
  String extractTextFromHtml(String htmlData) {
    if (htmlData.isEmpty) return '';

    // Parse the HTML data
    final document = htmlParser.parse(htmlData);

    // Remove `text-align: justify` from inline styles
    document
        .querySelectorAll('[style]')
        .forEach((element) {
      final styleAttr = element.attributes['style'] ?? '';
      final updatedStyle = styleAttr
          .split(';')
          .where((style) => !style.trim().startsWith('text-align: justify'))
          .join(';')
          .trim();
      if (updatedStyle.isNotEmpty) {
        element.attributes['style'] = updatedStyle;
      } else {
        element.attributes.remove('style'); // Remove empty style attribute
      }
    });

    // Remove `text-align: justify` from <style> tags
    document.getElementsByTagName('style').forEach((styleElement) {
      final cssContent = styleElement.text;
      final updatedCss = cssContent.replaceAll(RegExp(r'text-align:\s*justify;?'), '');
      styleElement.text = updatedCss;
    });

    // Extract text from the body or the entire document
    final bodyText = document.body?.text ?? '';
    final documentText = document.documentElement?.text ?? '';

    // Return the most complete available text
    return bodyText.isNotEmpty ? bodyText : documentText;
  }

  void _loadLanguage() async {
    currentLanguage = await getSelectedLanguage();
    print("loadlang$currentLanguage");
    setState(() {}); // Update UI with the selected language
  }

  Future<String> getSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedLanguage') ?? 'en'; // Default to English
  }
  getVision() async {
    var completer = Completer<Vision2030>();

    await PoliciesandInformationsService()
        .getVision()
        .then((value) => setState(() {
              vision = value!;
            }));
    //  return completer.complete( await PrimeMinisterService().getBiography());

    return vision;
  }

  @override
  void initState() {
    // TODO: implement initState
    _loadLanguage();

    getVision();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final rawContent = LocalizationHelper.getLocalizedValue(vision.toMap(), currentLanguage, 'content');
    final plainTextContent = extractTextFromHtml(rawContent);
    return FutureBuilder(
        future: getVision(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: MediaQuery.of(context).size.height * 1.5,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    CachedNetworkImage(
                      width: MediaQuery.of(context).size.width,
                      imageUrl: DioBaseService().Cap_Upload_URL + vision.cover!,
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Html(
                            data:plainTextContent,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'detail_document'.tr(),
                                      style: GoogleFonts.tajawal(
                                          textStyle: TextStyle(
                                              fontSize: 20,
                                              color: Color(0xffb5102b)))),
                                  TextSpan(
                                      text: vision.titleE.toString(),
                                      style: GoogleFonts.tajawal(
                                          textStyle: TextStyle(
                                              fontSize: 20,
                                              color: Colors.blue)),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          var url =
                                              DioBaseService().Cap_Upload_URL +
                                                  vision.attachmentE.toString();
                                          if (await canLaunch(url)) {
                                            await launch(url);
                                          } else {
                                            throw 'contact_url'.tr()+ url;
                                          }
                                        })
                                ],
                              ),
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
