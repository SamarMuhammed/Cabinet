import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'package:reidsc/core/services/PoliciesandInformationsService.dart';
import 'package:reidsc/core/services/PrimeMinisterService.dart';
import 'package:reidsc/data/model/Indicators/IndCategory.dart';
import 'package:reidsc/data/model/PoliciesAndInformations/GovYearlyReport.dart';
import 'package:reidsc/data/model/PoliciesAndInformations/Vision2030.dart';
import 'package:reidsc/data/model/primeMinister/Biography.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../generic/imageDialog.dart';

class GovAnnualReportScreen extends StatefulWidget {
  const GovAnnualReportScreen({Key? key}) : super(key: key);

  @override
  _GovAnnualReportScreenState createState() => _GovAnnualReportScreenState();
}

class _GovAnnualReportScreenState extends State<GovAnnualReportScreen> {
  late GovYearlyReport report = new GovYearlyReport();

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
                      height: 10.h,
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
                            data: report.briefE.toString(),
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
