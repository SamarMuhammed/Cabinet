import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/services/PricesService.dart';
import 'package:reidsc/core/services/StockmarketService.dart';
import 'package:reidsc/data/model/Indicators/IndCategory.dart';
import 'package:reidsc/data/model/Indicators/IndChartData.dart';
import 'package:reidsc/data/model/generic/listItem.dart';
import 'package:reidsc/data/model/prices/PricesDataall.dart';
import 'package:reidsc/data/model/prices/globalPriceChartData.dart';
import 'package:reidsc/generic/Notifications/NotificationsMenu.dart';
import 'package:reidsc/generic/TableWidget.dart';
import 'package:reidsc/ui/Home.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class LatestPricesScreen extends StatefulWidget {
  const LatestPricesScreen({Key? key}) : super(key: key);

  @override
  State<LatestPricesScreen> createState() => _LatestPricesScreenState();
}

class _LatestPricesScreenState extends State<LatestPricesScreen> {
  late List<PricesDataall> indicators = [];

  late GlobalPriceChartData data = new GlobalPriceChartData();
  late int selectedCat;
  late int selectedDuration = 7;
  late int selectedSubcat;
  late List<CartesianSeries<dynamic, String>> seriesData = [];
  List<listItem> items = [];
  late TooltipBehavior _tooltipBehavior;

  Future<List<PricesDataall>> loadPricesData() async {
    var completer = Completer<List<PricesDataall>>();

    var inds = await PricesService().getLatestPrices();
    //for( final y in categories) {
    //subCategories = categories[0].subCategories!;
    //}
    completer.complete(await PricesService().getLatestPrices());
    // length = categories[index].subCategories!.length;
    setState(() {
      indicators = inds;
      loadChartData(7);
      //selectedCat = subCategories[0].id!;
      // getStockChartData(indicators[0].id!,30);
    });
    return completer.future;
  }

  loadChartData(duration) async {
    _tooltipBehavior = TooltipBehavior(enable: true, shouldAlwaysShow: true);
    items = [];
//    print("chart"+subCategories[selectedSubcat].id!.toString());
    //var chartData = await StockmarketService().getChartData(subCategories[selectedSubcat].id!,duration);
    var chartData = await PricesService()
        .getglobalChartData(indicators[selectedSubcat].id!, duration);

    setState(() {
      data = chartData;
      for (var m in data.pricesData!)
      //  data.indicators![0].data!.map((m)=>()
      {
        print(m.date!.toString());
        items.add(listItem(m.date!, m.value!, m.id!));
        // items.add( DatelistItem(DateTime.parse( DateFormat.yMMMd("en").format(DateTime.parse(m.date!.toString()))), m.value!));
//print(DateTime.parse( m.date!.toString()));
      }

      seriesData = [
        AreaSeries<listItem, String>(
          dataSource: items,
          //  sortingOrder: SortingOrder.ascending,
          //     sortFieldValueMapper: (listItem ind, _) => ind.id,
          markerSettings: MarkerSettings(
              isVisible: false,
              // Marker shape is set to diamond
              shape: DataMarkerType.circle),

          xValueMapper: (listItem ind, _) => ind.date,
          yValueMapper: (listItem ind, _) => ind.value,
          name: indicators[selectedSubcat].name,
          emptyPointSettings: EmptyPointSettings(mode: EmptyPointMode.average),
          enableTooltip: true,
          // Enable data label
          // dataLabelSettings: const DataLabelSettings(
          // angle: 45,
          // color: Colors.red,

          //      isVisible: true)
        )
      ];
    });
  }

  @override
  void initState() {
    selectedSubcat = 0;
    // TODO: implement initState
    _tooltipBehavior = TooltipBehavior(enable: true, shouldAlwaysShow: true);
    loadPricesData();
    super.initState();
    // loadPricesData();
    // loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    _tooltipBehavior.showByIndex(0, 2);

    return FutureBuilder(
        future: indicators.isEmpty ? loadPricesData() : null,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (indicators.length > 0 && seriesData.length > 0) {
            return Scaffold(
                appBar: AppBar(
                  elevation: 0.0,

                  // Here we take the value from the MyHomePage object that was created by
                  // the App.build method, and use it to set our appbar title.
                  title: Text(
                    " احدث الاسعار",
                    style: GoogleFonts.tajawal(
                        textStyle: TextStyle(fontSize: 17.sp)),
                  ),
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,

                  actions: [NotificationMenu()],
                  titleTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      /* Container(
             // alignment: Alignment.topRight,
              child: Text("أحدث الأسعار",style: TextStyle(color: Colors.black45,fontSize: 20,fontWeight: FontWeight.bold)),
            ),*/

                      Container(
                          margin: EdgeInsets.symmetric(vertical: 20.0.r),
                          height: 150.h,
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedSubcat = index;
                                    getStockChartData(indicators[index].id!, 7);
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(10.0.r),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      //   width: MediaQuery.of(context).size.width/2,

                                      height:
                                          MediaQuery.of(context).size.height,
                                      color: (selectedSubcat == index)
                                          ? Color(0xffF5E0F2).withOpacity(0.7)
                                          : Colors.white,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        //crossAxisAlignment: CrossAxisAlignment.stretch,

                                        children: <Widget>[
                                          Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0),
                                                      child: AutoSizeText(
                                                        indicators[index]
                                                            .name
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff0D005F),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15.sp),
                                                        minFontSize: 18,
                                                        maxFontSize: 20,
                                                      ),
                                                    ),
                                                    flex: 12),
                                              ]),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                AutoSizeText(
                                                  indicators[index]
                                                      .value
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Color(0xff8F3F71),
                                                      fontSize: 30.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  minFontSize: 18,
                                                  maxFontSize: 20,
                                                ),
                                              ]),
                                          Container(
                                            child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Expanded(
                                                      child: AutoSizeText(
                                                    indicators[index]
                                                        .unit
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.tajawal(
                                                        textStyle: TextStyle(
                                                            fontSize: 17),
                                                        color: Colors.black45),
                                                    minFontSize: 18,
                                                    maxFontSize: 20,
                                                  )),
                                                ]),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.date_range_rounded,
                                                  size: 15,
                                                  color: Colors.black45),
                                              AutoSizeText(
                                                indicators[index]
                                                    .date
                                                    .toString(),
                                                style: GoogleFonts.tajawal(
                                                    textStyle: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.black45)),
                                                minFontSize: 18,
                                                maxFontSize: 20,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: indicators.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                          )),
                      Container(
                        alignment: Alignment.topRight,
                        child: Text(" المؤشرات",
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.all(8.0.r),
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 4,
                                      child: Column(
                                        children: [
                                          Center(
                                              child: Text(
                                            "نسبة التغير",
                                            style: TextStyle(
                                                color: Color(0xff0D005F),
                                                fontSize: 18.sp),
                                          )),
                                        ],
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: VerticalDivider(
                                        color: Colors.black45,
                                        thickness: 2,
                                      )),
                                  Expanded(
                                      flex: 4,
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.arrow_downward,
                                                  color: Color(0xffE79D4F),
                                                ),
                                                Center(
                                                  child: Text(
                                                      '${indicators[selectedSubcat].dailyPercentage.toString()} %',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 22.sp,
                                                          color:
                                                              Color(0xff8F3F71),
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                Padding(
                                    padding: EdgeInsets.all(8.0.r),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: Center(
                                                child: AutoSizeText(
                                              "المدى:",
                                              style: TextStyle(
                                                  fontSize: 17.sp,
                                                  fontWeight: FontWeight.bold),
                                              minFontSize: 18,
                                              maxFontSize: 20,
                                            ))),
                                        Expanded(
                                            flex: 2,
                                            child: Center(
                                                child: GestureDetector(
                                                    onTap: () {
                                                      setState(() =>
                                                          getStockChartData(
                                                              selectedSubcat,
                                                              7));
                                                    },
                                                    child: AutoSizeText(
                                                      "أسبوع",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17.sp,
                                                          color:
                                                              selectedDuration ==
                                                                      7
                                                                  ? Color(
                                                                      0xff8F3F71)
                                                                  : Colors
                                                                      .black87),
                                                      minFontSize: 18,
                                                      maxFontSize: 20,
                                                    )))),
                                        Expanded(
                                            flex: 2,
                                            child: Center(
                                                child: GestureDetector(
                                                    onTap: () {
                                                      setState(() =>
                                                          getStockChartData(
                                                              selectedSubcat,
                                                              30));
                                                    },
                                                    child: AutoSizeText(
                                                      "شهر",
                                                      style: TextStyle(
                                                          fontSize: 17.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              selectedDuration ==
                                                                      30
                                                                  ? Color(
                                                                      0xff8F3F71)
                                                                  : Colors
                                                                      .black87),
                                                      minFontSize: 18,
                                                      maxFontSize: 20,
                                                    )))),
                                        Expanded(
                                            flex: 2,
                                            child: Center(
                                                child: GestureDetector(
                                                    onTap: () {
                                                      setState(() =>
                                                          getStockChartData(
                                                              selectedSubcat,
                                                              180));
                                                    },
                                                    child: AutoSizeText(
                                                      "6 أشهر",
                                                      style: TextStyle(
                                                          fontSize: 17.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              selectedDuration ==
                                                                      180
                                                                  ? Color(
                                                                      0xff8F3F71)
                                                                  : Colors
                                                                      .black87),
                                                      minFontSize: 18,
                                                      maxFontSize: 20,
                                                    )))),
                                        Expanded(
                                            flex: 2,
                                            child: Center(
                                                child: GestureDetector(
                                                    onTap: () {
                                                      setState(() =>
                                                          getStockChartData(
                                                              selectedSubcat,
                                                              365));
                                                    },
                                                    child: AutoSizeText(
                                                      "سنة",
                                                      style: TextStyle(
                                                          fontSize: 17.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              selectedDuration ==
                                                                      365
                                                                  ? Color(
                                                                      0xff8F3F71)
                                                                  : Colors
                                                                      .black87),
                                                      minFontSize: 18,
                                                      maxFontSize: 20,
                                                    )))),
                                      ],
                                    )),
                                Directionality(
                                  textDirection: Directionality.of(context),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 400.h,
                                        child: SfCartesianChart(
                                            tooltipBehavior: _tooltipBehavior,
                                            primaryYAxis: NumericAxis(
                                                //    minimum: 0,
                                                title: AxisTitle(
                                                    text:
                                                        indicators[selectedSubcat]
                                                            .unit,
                                                    textStyle:
                                                        GoogleFonts.tajawal(
                                                            textStyle:
                                                                TextStyle(
                                                                    fontSize:
                                                                        17))),
                                                majorGridLines: MajorGridLines(
                                                  width: 0,
                                                )),
                                            //   primaryXAxis: CategoryAxis(),
                                            primaryXAxis: CategoryAxis(
                                                majorGridLines: MajorGridLines(
                                                  width: 0,
                                                ),
                                                // Axis labels will be rotated to 90 degree
                                                labelRotation: 50,
                                                labelStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14.sp)
                                                // axisLine: AxisLine(
                                                //      color: Colors.deepOrange,
                                                //       width: 2,

                                                //     )
                                                ),
                                            onDataLabelRender:
                                                (DataLabelRenderArgs args) {
                                              //args.color = Colors.black;
                                            },
                                            // Chart title
                                            title: ChartTitle(
                                                text: indicators[selectedSubcat]
                                                    .name
                                                    .toString(),
                                                textStyle: GoogleFonts.tajawal(
                                                    textStyle: TextStyle(
                                                        fontSize: 17))),
                                            // Enable legend
                                            legend: Legend(
                                                overflowMode:
                                                    LegendItemOverflowMode.wrap,
                                                isVisible: true,
                                                position:
                                                    LegendPosition.bottom),
                                            // Enable tooltip

                                            series: seriesData),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: Container(
                            height: 30.h,
                            alignment: Alignment.centerRight,
                            child: Text(
                              "الجداول",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                  color: Colors.black45),
                            )),
                      ),
                      Padding(
                          padding: EdgeInsets.all(20.0.r),
                          child: TableViewWidget(
                            name: indicators[selectedSubcat].name.toString(),
                            unit: indicators[selectedSubcat].unit.toString(),
                            data: data.pricesData!,
                          )),
                    ],
                  ),
                ));
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

  void getStockChartData(int i, duration) {
    setState(() {
      selectedDuration = duration;
      loadChartData(duration);
    });
  }
}
