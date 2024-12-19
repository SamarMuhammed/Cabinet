import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/data/model/Indicators/IndCategory.dart';
import 'package:reidsc/data/model/Indicators/IndChartData.dart';
import 'package:reidsc/data/model/generic/listItem.dart';
import 'package:reidsc/generic/Notifications/NotificationsMenu.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../core/services/StockmarketService.dart';
import 'dart:ui' as ui;

class StockMarketScreen extends StatefulWidget {
  const StockMarketScreen({Key? key}) : super(key: key);

  @override
  _StockMarketScreenState createState() => _StockMarketScreenState();
}

class _StockMarketScreenState extends State<StockMarketScreen> {
  late List<IndCategory> categories = [];
  late List<IndCategory> subCategories = [];
  late IndChartData data = new IndChartData();
  late int selectedCat;
  late int selectedDuration = 7;
  late int selectedSubcat;
  late List<CartesianSeries<dynamic, String>> seriesData = [];
  List<listItem> items = [];
  late TooltipBehavior _tooltipBehavior;

  Future<List<IndCategory>> loadCategories() async {
    var completer = Completer<List<IndCategory>>();
    var cats = await StockmarketService().getCategories();
    completer.complete(await StockmarketService().getCategories());

    //
    setState(() {
      categories = cats;
      selectedCat = categories[0].id!;
      getSubCats(selectedCat);
    });

    return completer.future;

    //  return tabs;
  }

  Future<List<IndCategory>> loadSubCategories(id) async {
    var subcats = await StockmarketService().getSubCategories(id);
    setState(() {
      subCategories = subcats;
      selectedSubcat = 0;
      getStockChartData(selectedSubcat, 7);
    });

    //  completer.complete(await StockmarketService().getCategories());
    return subCategories;

    //  return tabs;
  }

  loadChartData(duration) async {
    _tooltipBehavior = TooltipBehavior(enable: true, shouldAlwaysShow: true);
    items = [];
//    print("chart"+subCategories[selectedSubcat].id!.toString());
    var chartData = await StockmarketService()
        .getChartData(subCategories[selectedSubcat].id!, duration);
    setState(() {
      data = chartData;
      if (duration == 180 || duration == 365) {
        for (var i = data.indicators![0].data!.length - 1; i >= 0; i--)
        //  data.indicators![0].data!.map((m)=>()
        {
          // print(data.indicators![0].data![i].date!.toString());
          items.add(listItem(
              data.indicators![0].data![i].date!,
              data.indicators![0].data![i].value!,
              data.indicators![0].data![i].id!));
          // items.add( DatelistItem(DateTime.parse( DateFormat.yMMMd("en").format(DateTime.parse(m.date!.toString()))), m.value!));
//print(DateTime.parse( m.date!.toString()));
        }
      } else {
        for (var m in data.indicators![0].data!)
        //  data.indicators![0].data!.map((m)=>()
        {
          print(m.date!.toString());
          items.add(listItem(m.date!, m.value!, m.id!));
          // items.add( DatelistItem(DateTime.parse( DateFormat.yMMMd("en").format(DateTime.parse(m.date!.toString()))), m.value!));
//print(DateTime.parse( m.date!.toString()));
        }
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
          name: data.indicators![0].name,
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
    // TODO: implement initState
    _tooltipBehavior = TooltipBehavior(enable: true, shouldAlwaysShow: true);
    super.initState();
    loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    _tooltipBehavior.showByIndex(0, 2);
    return FutureBuilder(
      future: categories.isEmpty ? loadCategories() : null,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (categories.length > 0 &&
            seriesData.length > 0 &&
            subCategories.length > 0 &&
            data.indicators!.length > 0) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,

              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Text("أسواق المال",
                  style: TextStyle(fontSize: 17, fontFamily: 'Cairo')),
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              actions: [
                NotificationMenu()
                //  IconButton(onPressed: getNotifications, icon: const Icon(Icons.notifications),color: Colors.black,)
              ],
              titleTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: const Color(0xffF4F4F4),
            body: Container(
              //    height: 500,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    // Text("hiiiiiiiiiiii"),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        height: 70,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              for (final cat in categories)
                                GestureDetector(
                                  onTap: () {
                                    setState(() => getSubCats(cat.id));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(12.0),
                                    child: AutoSizeText(
                                      cat.name!,
                                      style: TextStyle(
                                          color: Color(0xff0D005F),
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Cairo'),
                                      minFontSize: 17,
                                      maxFontSize: 19,
                                    ),
                                    decoration: selectedCat == cat.id
                                        ? BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(),
                                            ),
                                            color: Color(0xffF5E0F2))
                                        : null,
                                  ),
                                )
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              padding:
                                  EdgeInsets.only(right: 8, left: 8, bottom: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  for (int i = 0; i < subCategories.length; i++)
                                    ChoiceChip(
                                        label: AutoSizeText(
                                          subCategories[i].name.toString(),
                                          minFontSize: 15,
                                          maxFontSize: 17,
                                        ),
                                        selected: selectedSubcat == i,
                                        selectedColor: const Color(0xff8F3F71),
                                        labelStyle: TextStyle(
                                            color: selectedSubcat == i
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 15.sp,
                                            fontFamily: 'Cairo'),
                                        onSelected: (value) {
                                          setState(() {
                                            if (value) {
                                              selectedSubcat = i;
                                            }
                                          });
                                          getStockChartData(
                                              subCategories[i].id!, 7);
                                        },
                                        backgroundColor: Colors.white)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (data.indicators!.length > 0)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Center(
                                            child: AutoSizeText(
                                          "نسبة التغير",
                                          style: TextStyle(
                                              color: Color(0xff0D005F),
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Cairo'),
                                          minFontSize: 18,
                                          maxFontSize: 20,
                                        )),
                                        Center(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: AutoSizeText(
                                              data.indicators![1].data![0].date
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Color(0xff0D005F),
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold),
                                              minFontSize: 16,
                                              maxFontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              data.indicators![1].data![0]
                                                          .value! >=
                                                      0
                                                  ? Icon(
                                                      Icons.arrow_upward,
                                                      color: Colors.green,
                                                    )
                                                  : Icon(
                                                      Icons.arrow_downward,
                                                      color: Colors.red,
                                                    ),
                                              AutoSizeText(
                                                data.indicators![1].data![0]
                                                    .value
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 18.sp,
                                                    color: data
                                                                .indicators![1]
                                                                .data![0]
                                                                .value! >=
                                                            0
                                                        ? Colors.green
                                                        : Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                minFontSize: 18,
                                                maxFontSize: 20,
                                              ),
                                              AutoSizeText(
                                                data.indicators![1].unit
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 18.sp,
                                                    color: data
                                                                .indicators![1]
                                                                .data![0]
                                                                .value! >=
                                                            0
                                                        ? Colors.green
                                                        : Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                minFontSize: 18,
                                                maxFontSize: 20,
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Row(
                                              children: [
                                                AutoSizeText(
                                                  data
                                                      .indicators![0]
                                                      .data![data.indicators![0]
                                                              .data!.length -
                                                          1]
                                                      .value
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 18.sp,
                                                      color: data
                                                                  .indicators![
                                                                      1]
                                                                  .data![0]
                                                                  .value! >=
                                                              0
                                                          ? Colors.green
                                                          : Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  minFontSize: 18,
                                                  maxFontSize: 20,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: AutoSizeText(
                                                    data.indicators![0].unit
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 18.sp,
                                                        color: data
                                                                    .indicators![
                                                                        1]
                                                                    .data![0]
                                                                    .value! >=
                                                                0
                                                            ? Colors.green
                                                            : Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    minFontSize: 18,
                                                    maxFontSize: 20,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 2,
                                          child: Center(
                                              child: AutoSizeText(
                                            "المدى:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Cairo'),
                                            minFontSize: 16,
                                            maxFontSize: 18,
                                          ))),
                                      Expanded(
                                          flex: 2,
                                          child: Center(
                                              child: GestureDetector(
                                                  onTap: () {
                                                    setState(() =>
                                                        getStockChartData(
                                                            selectedSubcat, 7));
                                                  },
                                                  child: AutoSizeText(
                                                    "أسبوع",
                                                    style: TextStyle(
                                                        fontFamily: 'Cairo',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            selectedDuration ==
                                                                    7
                                                                ? Color(
                                                                    0xff8F3F71)
                                                                : Colors
                                                                    .black87),
                                                    minFontSize: 16,
                                                    maxFontSize: 18,
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
                                                        fontFamily: 'Cairo',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            selectedDuration ==
                                                                    30
                                                                ? Color(
                                                                    0xff8F3F71)
                                                                : Colors
                                                                    .black87),
                                                    minFontSize: 16,
                                                    maxFontSize: 18,
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
                                                        fontFamily: 'Cairo',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            selectedDuration ==
                                                                    180
                                                                ? Color(
                                                                    0xff8F3F71)
                                                                : Colors
                                                                    .black87),
                                                    minFontSize: 16,
                                                    maxFontSize: 18,
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
                                                        fontFamily: 'Cairo',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            selectedDuration ==
                                                                    365
                                                                ? Color(
                                                                    0xff8F3F71)
                                                                : Colors
                                                                    .black87),
                                                    minFontSize: 16,
                                                    maxFontSize: 18,
                                                  )))),
                                    ],
                                  )),
                              Directionality(
                                textDirection: ui.TextDirection.rtl,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 400,
                                      child: SfCartesianChart(
                                          tooltipBehavior: _tooltipBehavior,
                                          primaryYAxis: NumericAxis(
                                              //    minimum: 0,
                                              title: AxisTitle(
                                                  textStyle: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontFamily: 'Cairo'),
                                                  text:
                                                      data.indicators![0].unit),
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
                                                  fontSize: 14,
                                                  fontFamily: 'Cairo')
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
                                              text: data.name.toString(),
                                              textStyle: TextStyle(
                                                fontSize: 16.sp,
                                              )),
                                          // Enable legend
                                          legend: Legend(
                                              overflowMode:
                                                  LegendItemOverflowMode.wrap,
                                              textStyle: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontFamily: 'Cairo'),
                                              isVisible: true,
                                              position: LegendPosition.bottom),
                                          // Enable tooltip

                                          series: seriesData),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                    )
                  ],
                ),
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
      },
    );
  }

  getSubCats(int? id) {
    setState(() {
      selectedCat = id!;
      loadSubCategories(selectedCat);
    });
  }

  void getStockChartData(int i, duration) {
    setState(() {
      selectedDuration = duration;
      loadChartData(duration);
    });
  }
}
