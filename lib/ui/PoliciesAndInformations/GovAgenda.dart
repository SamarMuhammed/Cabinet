import 'dart:async';

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
import 'package:reidsc/data/model/PoliciesAndInformations/GovernmentAgenda.dart';
import 'package:reidsc/data/model/PoliciesAndInformations/Vision2030.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

var urlimage = "";
var imageURL = "";
int Mlength = 0;

class GovAgendaScreen extends StatefulWidget {
  const GovAgendaScreen({Key? key}) : super(key: key);

  @override
  _GovAgendaScreenState createState() => _GovAgendaScreenState();
}

class _GovAgendaScreenState extends State<GovAgendaScreen> {
  late GovernmentAgenda agenda = new GovernmentAgenda();
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
  getGovAgenda() async {
    var completer = Completer<GovernmentAgenda>();

    await PoliciesandInformationsService()
        .getGovAgenda()
        .then((value) => setState(() {
              agenda = value!;
            }));
    //  return completer.complete( await PrimeMinisterService().getBiography());

    return agenda;
  }

  @override
  void initState() {
    // TODO: implement initState
    _loadLanguage();
    getGovAgenda();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getGovAgenda(),
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
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0).r,
                                child: GestureDetector(
                                  onTap: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (_) => ImageDialog(
                                              'assets/images/egypt rises.png',
                                            ));
                                  },
                                  child: Container(
                                    width: 200.w,
                                    height: 250,
                                    decoration: BoxDecoration(
                                      // color: Colors.red,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/egypt rises.png'),
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
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0).r,
                                child: GestureDetector(
                                  onTap: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (_) => ImageDialog(
                                              'assets/images/egypt rises 2.png',
                                            ));
                                  },
                                  child: Container(
                                    width: 200.w,
                                    height: 250,
                                    decoration: BoxDecoration(
                                      // color: Colors.red,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/egypt rises 2.png'),
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
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0).r,
                                child: GestureDetector(
                                  onTap: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (_) => ImageDialog(
                                              'assets/images/egypt rises 3.png',
                                            ));
                                  },
                                  child: Container(
                                    width: 200.w,
                                    height: 250,
                                    decoration: BoxDecoration(
                                      // color: Colors.red,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/egypt rises 3.png'),
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
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0).r,
                                child: GestureDetector(
                                  onTap: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (_) => ImageDialog(
                                              'assets/images/egypt rises 4.png',
                                            ));
                                  },
                                  child: Container(
                                    width: 200.w,
                                    height: 250,
                                    decoration: BoxDecoration(
                                      // color: Colors.red,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/egypt rises 4.png'),
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
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0).r,
                                child: GestureDetector(
                                  onTap: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (_) => ImageDialog(
                                              'assets/images/egypt rises 5.png',
                                            ));
                                  },
                                  child: Container(
                                    width: 200.w,
                                    height: 250,
                                    decoration: BoxDecoration(
                                      // color: Colors.red,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/egypt rises 5.png'),
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
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Html(
                            data:LocalizationHelper.getLocalizedValue(agenda.toMap(), currentLanguage, 'content'),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text:  'detail_document'.tr(),
                                    style: GoogleFonts.tajawal(
                                        textStyle: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xffb5102b)))),
                                TextSpan(
                                    text: agenda.titleE.toString(),
                                    style: GoogleFonts.tajawal(
                                        textStyle: TextStyle(
                                            fontSize: 20, color: Colors.blue)),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        var url =
                                            DioBaseService().Cap_Upload_URL +
                                                agenda.attachmentE.toString();
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
                      ],
                    ),
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

class ImageDialog extends StatelessWidget {
  // String? pathh;
  ImageDialog(this.pathh);
  final String? pathh;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),

          height: MediaQuery.of(context).orientation == Orientation.portrait
              ? MediaQuery.of(context).size.height / 2
              : MediaQuery.of(context).size.height / 1.5,

          //   height: MediaQuery.of(context).size.height/2.2,
          width: MediaQuery.of(context).size.width,
          child: PhotoView(
            customSize: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height * 2),
            backgroundDecoration: BoxDecoration(color: Colors.transparent),
            initialScale: PhotoViewComputedScale.contained * 1,
            maxScale: PhotoViewComputedScale.contained * 8,
            imageProvider: AssetImage(
              pathh!,
            ),
          ),
        ));
  }
}
