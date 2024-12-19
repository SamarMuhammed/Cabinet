import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'package:reidsc/core/services/PrimeMinisterService.dart';
import 'package:reidsc/data/model/Indicators/IndCategory.dart';
import 'package:reidsc/data/model/primeMinister/Biography.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../generic/imageDialog.dart';

class BiographyScreen extends StatefulWidget {
  const BiographyScreen({Key? key}) : super(key: key);

  @override
  _BiographyScreenState createState() => _BiographyScreenState();
}

class _BiographyScreenState extends State<BiographyScreen> {
  late Biography bio = new Biography();

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
    getBiography();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    Row(
                      children: [
                        Expanded(
                          child: Html(
                            data: bio.contentE.toString(),
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
