import 'dart:async';
import 'dart:ui' as ui;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reidsc/core/Helper/LangHelper.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'package:reidsc/core/services/PoliciesandInformationsService.dart';
import 'package:reidsc/core/services/PrimeMinisterService.dart';
import 'package:reidsc/data/model/Indicators/IndCategory.dart';
import 'package:reidsc/data/model/PoliciesAndInformations/GovYearlyReport.dart';
import 'package:reidsc/data/model/PoliciesAndInformations/Vision2030.dart';
import 'package:reidsc/data/model/primeMinister/Biography.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../generic/imageDialog.dart';

class GovAnnualReportScreen extends StatefulWidget {
  const GovAnnualReportScreen({Key? key}) : super(key: key);

  @override
  _GovAnnualReportScreenState createState() => _GovAnnualReportScreenState();
}

class _GovAnnualReportScreenState extends State<GovAnnualReportScreen> {
  late GovYearlyReport report = new GovYearlyReport();
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
  getAnnualReport() async {
    var completer = Completer<GovYearlyReport>();

    await PoliciesandInformationsService()
        .getGovAnnualReport()
        .then((value) => setState(() {
              report = value!;
            }));
    //  return completer.complete( await PrimeMinisterService().getBiography());

    return report;
  }

  @override
  void initState() {
    // TODO: implement initState
    _loadLanguage();

    getAnnualReport();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAnnualReport(),
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
                      height: 80.h,
                      imageUrl:
                          "https://cabinet.gov.eg/UI/img/EgyptrisesEn.png",
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Html(
                            data: LocalizationHelper.getLocalizedValue(report.toMap(), currentLanguage, 'brief_'),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                         'policies_annual'.tr(),
                          style: TextStyle(
                              color: Color(0xffb5102b),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ))
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height / 5,
                            child: ListView.builder(
                              itemBuilder: (BuildContext context, index) {
                                return InkWell(
                                    onTap: () async {
                                      var url =
                                          report.reports![index].url.toString();
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        throw 'contact_url'.tr()+ url;
                                      }
                                      /* Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) =>
                              DetailsScreen(
                                newD: newsList[index],
                                userID: userID,
                              ),
                        ),
                      );*/
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Container(
                                          width: 150,
                                          height: 150,
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            //crossAxisAlignment: CrossAxisAlignment.stretch,

                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: Container(
                                                    alignment: Alignment.center,

                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        child: Icon(
                                                          Icons.picture_as_pdf,
                                                          size: 45,
                                                          color:
                                                              Color(0xffb5102b),
                                                        )), // If it's missing, display an empty box
                                                    // If it's missing, display an empty box
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12.0),
                                                child: Row(children: [
                                                  Flexible(
                                                    child: AutoSizeText(
                                                      report
                                                          .reports![index].title
                                                          .toString(),
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color(
                                                              0xff212121)),
                                                      minFontSize: 20,
                                                      maxFontSize: 20,
                                                    ),
                                                  ),
                                                ]),
                                              ),
                                              SizedBox(height: 10),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12.0),
                                                child: Row(
                                                    textDirection:
                                                       ui.TextDirection.ltr,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: []),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                              },
                              itemCount: report.reports!.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                            ))
                      ],
                    )
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
