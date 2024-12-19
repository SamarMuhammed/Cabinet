import 'dart:async';
import 'package:html/parser.dart' as htmlParser;

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reidsc/core/Helper/LangHelper.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'package:reidsc/core/services/PrimeMinisterService.dart';
import 'package:reidsc/data/model/Indicators/IndCategory.dart';
import 'package:reidsc/data/model/primeMinister/Biography.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generic/imageDialog.dart';

class BiographyScreen extends StatefulWidget {
  const BiographyScreen({Key? key}) : super(key: key);

  @override
  _BiographyScreenState createState() => _BiographyScreenState();
}

class _BiographyScreenState extends State<BiographyScreen> {
  late Biography bio = new Biography();
  String currentLanguage = 'en';

  void _loadLanguage() async {
    currentLanguage = await getSelectedLanguage();
    print("loadlang$currentLanguage");
    setState(() {}); // Update UI with the selected language
  }

  Future<String> getSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedLanguage') ?? 'en'; // Default to English
  }
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
  getBiography() async {
    var completer = Completer<Biography>();

    await PrimeMinisterService().getBiography().then((value) => setState(() {
          bio = value!;
        }));
    //  return completer.complete( await PrimeMinisterService().getBiography());

    return bio;
  }

  @override
  void initState() {
    // TODO: implement initState
    _loadLanguage();
    getBiography();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final rawContent = LocalizationHelper.getLocalizedValue(bio.toMap(), currentLanguage, 'content');
    final plainTextContent = extractTextFromHtml(rawContent);
    return FutureBuilder(
        future: getBiography(),
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
                    Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            await showDialog(
                                context: context,
                                builder: (_) => ImageDialog(
                                      imageURL:
                                          DioBaseService().Cap_Upload_URL +
                                              bio.photo!,
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
                                          bio.photo!),
                                  fit: BoxFit.fill),
                            ),
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
                          child: Html(
                            data:plainTextContent,

                            style: {
                              '#': Style(
                                fontSize: FontSize(20),
                                maxLines: 100,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            },
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
