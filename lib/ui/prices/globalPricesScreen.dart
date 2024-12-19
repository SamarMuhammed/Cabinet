import 'dart:async';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reidsc/core/services/PricesService.dart';
import 'package:reidsc/data/model/Indicators/IndCategory.dart';
import 'package:reidsc/core/services/LocalIndicatorsService.dart';
import 'package:reidsc/data/model/Indicators/LocalIndSubCategory.dart';
import 'package:reidsc/data/model/prices/PricesCategory.dart';

import 'package:reidsc/data/model/prices/PricesCategory.dart';
import 'package:reidsc/data/model/prices/PricesDataall.dart';
import 'package:reidsc/data/model/prices/PricesSubCategory.dart';
import 'package:reidsc/ui/localIndicators/chartScreen.dart';

import 'package:reidsc/ui/prices/globalPricesDetails.dart';
import 'package:loading_indicator/loading_indicator.dart';

class globalPricesScreen extends StatefulWidget {
  const globalPricesScreen({Key? key}) : super(key: key);

  @override
  _globalPricesScreenState createState() => _globalPricesScreenState();
}

class _globalPricesScreenState extends State<globalPricesScreen> {
  late List<PricesCategory> categories = [];
  late List<SubCategories> subCategories = [];

  late List<PricesDataall> indicators = [];

  late int selectedCat;
  late int length = 0;
  Future<List<PricesCategory>> loadLocalCat() async {
    var completer = Completer<List<PricesCategory>>();

    categories = await PricesService().getMainPricesCategories();
    //for( final y in categories) {
    subCategories = categories[1].subCategories!;
    //}
    completer.complete(await PricesService().getMainPricesCategories());
    // length = categories[index].subCategories!.length;
    setState(() {
      // subCategories.removeAt(3);

      selectedCat = subCategories[0].id!;
      loadPricesData(selectedCat);
      //getData(int.parse(categories[0].id.toString()));
    });
    return completer.future;
  }

  loadPricesData(int id) async {
    indicators = await PricesService().getGlobalPrices(id: id);
    setState(() {
      selectedCat = id;

      // mainCategoryLoaded=true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: subCategories.isEmpty ? loadLocalCat() : null,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: const Color(0xffF4F4F4),
              body: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.all(15.0).r,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r)),
                        child: Container(
                          padding:
                              EdgeInsets.only(right: 5, left: 5, bottom: 0).r,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              for (final cat in subCategories)
                                GestureDetector(
                                    onTap: () {
                                      setState(() => loadPricesData(cat.id!));
                                    },
                                    child: ChoiceChip(
                                        label: Text(cat.name.toString()),
                                        selected: cat.isSelected!,
                                        selectedColor: const Color(0xff8F3F71),
                                        labelStyle: TextStyle(
                                            color: selectedCat == cat.id!
                                                ? Colors.white
                                                : Colors.black45,
                                            fontSize: 17.sp),
                                        onSelected: (value) {
                                          loadPricesData(cat.id!);
                                          // getData(cat.id!);
                                        },
                                        backgroundColor: selectedCat == cat.id!
                                            ? Color(0xff8F3F71)
                                            : Colors.white))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: indicators.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CardIcon(context, index);
                        }),
                  ),
                ],
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

  Widget CardIcon(context, index) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(8.0).r,
        child: SizedBox(
          // height: 50,
          width: MediaQuery.of(context).size.width,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => globalPricesDetailsScreen(
                    subCatID: indicators[index].id,
                    dailyPrice: indicators[index].dailyPercentage.toString(),
                    yearlyPrice: indicators[index].yearlyPercentage.toString(),
                    unit: indicators[index].unit.toString(),
                    name: indicators[index].name.toString(),
                    //   newD: item,
                    // userID:this.userID,
                  ),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Center(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    AutoSizeText(
                      indicators[index].name.toString(),
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
                        ' ${indicators[index].value.toString()} ${indicators[index].unit.toString()}',
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
                            "نسبة التغير اليومي",
                            style: TextStyle(
                                fontSize: 15.sp, color: Color(0xff0D005F)),
                            minFontSize: 15,
                            maxFontSize: 17,
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                double.parse(indicators[index]
                                            .dailyPercentage
                                            .toString()) >=
                                        0
                                    ? Icon(Icons.arrow_upward_outlined,
                                        color: Color(0xff23244B), size: 20)
                                    : Icon(Icons.arrow_downward,
                                        color: Color(0xff23244B), size: 20),
                                AutoSizeText(
                                  ' ${indicators[index].dailyPercentage.toString()} %',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
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
                              "نسبة التغير السنوي",
                              style: TextStyle(
                                  fontSize: 15.sp, color: Color(0xff0D005F)),
                              minFontSize: 15,
                              maxFontSize: 17,
                            )),
                        Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                double.parse(indicators[index]
                                            .yearlyPercentage
                                            .toString()) >=
                                        0
                                    ? Icon(Icons.arrow_upward_outlined,
                                        color: Color(0xffE79D4F), size: 20)
                                    : Icon(Icons.arrow_downward,
                                        color: Color(0xffE79D4F), size: 20),
                                AutoSizeText(
                                  ' ${indicators[index].yearlyPercentage.toString()} %',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Color(0xffE79D4F),
                                      fontWeight: FontWeight.bold),
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
                                  padding: EdgeInsets.only(
                                      right: 8, top: 8, bottom: 8),
                                  child: Icon(
                                    Icons.calendar_today_outlined,
                                    size: 25,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0.r),
                                  child: AutoSizeText(
                                    indicators[index].date.toString(),
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
            ),
          ),
        ),
      ),
    );
  }
}
