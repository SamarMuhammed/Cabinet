import 'dart:async';
import 'dart:isolate';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/services/PricesService.dart';
import 'package:reidsc/core/services/StockmarketService.dart';
import 'package:reidsc/data/model/Indicators/IndCategory.dart';
import 'package:reidsc/data/model/Indicators/IndChartData.dart';
import 'package:reidsc/data/model/generic/listItem.dart';
import 'package:reidsc/data/model/prices/PriceDataChart.dart';
import 'package:reidsc/generic/TableGovViewWidget.dart';
import 'package:reidsc/generic/TableWidget.dart';
import 'dart:io';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class PricesDetailsScreen extends StatefulWidget {

  final int? subCatID;
  final  String dailyPrice;
  final String  yearlyPrice;
  final String unit;
  final String name;
  const PricesDetailsScreen({Key? key, required this.subCatID, required this.dailyPrice, required this.yearlyPrice,required this.unit,required this.name}) : super(key: key);

  @override
  State<PricesDetailsScreen> createState() => _PricesDetailsScreenState();
}

class _PricesDetailsScreenState extends State<PricesDetailsScreen> {
  late List<IndCategory> categories = [];
  late List<IndCategory> subCategories = [];
  late PriceDataChart data = new PriceDataChart();
  late int selectedCat ;
  late int selectedDuration = 7 ;
  late int selectedSubcat;
  late List<CartesianSeries<dynamic, String>> seriesData = [];
  List<listItem> items = [];
  List<listGovItem> govItems = [];
  late TooltipBehavior _tooltipBehavior;





  Future<PriceDataChart> loadChartData(duration) async{
    _tooltipBehavior = TooltipBehavior(enable: true, shouldAlwaysShow: true);
    var completer = Completer<PriceDataChart>();

    items=[];
    govItems=[];
    print("chart"+widget.subCatID.toString());
    var chartData = await PricesService().getChartData(widget.subCatID!,duration);
    //print(chartData.pricesData![0].date);
    setState(() {
      data = chartData;
      for (var m in data.pricesData!)
        //  data.indicators![0].data!.map((m)=>()
          {
        print(m.date!.toString());
        items.add( listItem(m.date!, m.value!,m.id!));
        // items.add( DatelistItem(DateTime.parse( DateFormat.yMMMd("en").format(DateTime.parse(m.date!.toString()))), m.value!));
//print(DateTime.parse( m.date!.toString()));
      }

      for (var m in data.maxGovs!)
        //  data.indicators![0].data!.map((m)=>()
          {
        print("ID"+widget.subCatID.toString());

        print("govName"+m.govName.toString());
        govItems.add(listGovItem(m.govName!.toString(), m.value!));
        // items.add( DatelistItem(DateTime.parse( DateFormat.yMMMd("en").format(DateTime.parse(m.date!.toString()))), m.value!));
//print(DateTime.parse( m.date!.toString()));
      }
      for (var m in data.minGovs!)
        //  data.indicators![0].data!.map((m)=>()
          {
        print("ID"+widget.subCatID.toString());

        print("govName"+m.govName.toString());
        govItems.add(listGovItem(m.govName!.toString(), m.value!));
        // items.add( DatelistItem(DateTime.parse( DateFormat.yMMMd("en").format(DateTime.parse(m.date!.toString()))), m.value!));
//print(DateTime.parse( m.date!.toString()));
      }

      seriesData =
      [
        AreaSeries<listItem, String>(
          dataSource: items,
          //  sortingOrder: SortingOrder.ascending,
          //     sortFieldValueMapper: (listItem ind, _) => ind.id,
          markerSettings: MarkerSettings(
              isVisible: false,
              // Marker shape is set to diamond
              shape: DataMarkerType.circle
          ),

          xValueMapper: (listItem ind, _) =>  ind.date,
          yValueMapper: (listItem ind, _) => ind.value,
          name: widget.name,
          emptyPointSettings: EmptyPointSettings(mode:EmptyPointMode.average),
          enableTooltip: true,
          // Enable data label
          // dataLabelSettings: const DataLabelSettings(
          // angle: 45,
          // color: Colors.red,

          //      isVisible: true)
        )
      ];
    });

    completer.complete(await PricesService().getChartData(widget.subCatID!,duration));

    return completer.future;

  }
  @override
  void initState() {
    // TODO: implement initState
    _tooltipBehavior = TooltipBehavior(enable: true, shouldAlwaysShow: true);
    loadChartData(7);
    super.initState();
    //   loadCategories();
  }
  @override
  Widget build(BuildContext context) {
    _tooltipBehavior.showByIndex(0, 2);
    /* return
      FutureBuilder(
         future: data ==null ? loadChartData(30): null,

      //   future: loadChartData(30),
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            print("smr"+snapshot.hasData.toString());
    if (snapshot.hasData   ) {
*/
    FontSize: MediaQuery.of(context).size.width > 500  ?60
        : MediaQuery.of(context).size.width < 300 ?40: 30;
    return

      FutureBuilder(
          future: data== null ?getStockChartData(7): null,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if ( data!=null && seriesData.length >0 ) {
              return Scaffold(
                  appBar: AppBar(
                    elevation: 0.0,

                    // Here we take the value from the MyHomePage object that was created by
                    // the App.build method, and use it to set our appbar title.
                    title: Text(widget.name.toString(),style: TextStyle(fontSize: 17.sp,fontFamily: 'Cairo')
                    ),
                    backgroundColor: Colors.white,
                    automaticallyImplyLeading: false,

                    actions: [


                      IconButton(onPressed: (){
                        Navigator.of(context).pop();

                      },
                        icon: const Icon(Icons.arrow_back_ios,textDirection: ui.TextDirection.ltr),color: Colors.black,)
                    ],
                    titleTextStyle:  TextStyle(
                        color: Colors.black,
                        fontSize: 22.sp,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  body: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [


                        Container(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(" المؤشرات", style: TextStyle(
                                color: Colors.black45,
                                fontSize: 16.sp,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.all(8.0.r),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding:  EdgeInsets.all(8.0.r),
                              child:
                              Column(
                                children: [
                                  IntrinsicHeight(
                                    child:
                                    Row(
                                        children:[
                                          Expanded(
                                            flex:2,
                                            child: Column(
                                              children: [
                                                Center(
                                                    child: Text("نسبة التغير اليومي",
                                                        style: TextStyle(color: Color(0xff0D005F),
                                                            fontSize: 14.sp,fontFamily: 'Cairo'))
                                                )
                                              ],
                                            ),
                                          ),
                                          /*      Column(
                                    children: [
                                    ],
                                  ),*/
                                          Expanded(flex:1, child: VerticalDivider(color: Colors.black45,thickness: 1,)),

                                          Expanded(
                                            flex:2,
                                            child: Column(
                                              children: [
                                                Row(

                                                  children:[
                                                    Expanded(
                                                      flex:2,
                                                      child: Center(
                                                        child: Text('${widget.dailyPrice} %'
                                                            ,textAlign: TextAlign.center,style:  TextStyle(fontSize: 13.sp,
                                                                color: Color(0xff8F3F71)
                                                                ,fontWeight: FontWeight.bold)),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        flex:1,
                                                        child:
                                                        double.parse(widget.dailyPrice.toString()) >=0 ? Icon(Icons.arrow_upward_outlined,color: Colors.red,size: 18):Icon(Icons.arrow_downward,color: Colors.green,size: 18))                                        ,
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ]

                                    ),
                                  ),
                                  IntrinsicHeight(
                                    child: Row(
                                        children:[
                                          Expanded(
                                            flex:2,
                                            child: Column(
                                              children: [
                                                Center(
                                                    child: Text("نسبة التغير السنوي",
                                                        style: TextStyle(color: Color(0xff0D005F),
                                                            fontSize: 14.sp,fontFamily: 'Cairo'))
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              children: [
                                                Expanded(flex:1, child: VerticalDivider(color: Colors.black45,thickness: 1,)),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex:2,
                                                      child: Center(
                                                          child: Text('${widget.yearlyPrice} %'
                                                              ,textAlign: TextAlign.center,style:  TextStyle( fontSize: MediaQuery.of(context).size.width > 500  ?20.sp
                                                                  : MediaQuery.of(context).size.width < 300 ?40: 13 .sp,
                                                                  color: Color(0xff8F3F71)
                                                                  ,fontWeight: FontWeight.bold))),
                                                    ),
                                                    Expanded(
                                                        flex: 1,
                                                        child: double.parse(widget.yearlyPrice.toString()) >=0 ? Center(child: Icon(Icons.arrow_upward_outlined,color: Colors.red,size: 18)):Center(child: Icon(Icons.arrow_downward,color: Colors.green,size: 18)))                                        ,

                                                  ],
                                                )

                                              ],
                                            ),
                                          ),
                                        ]

                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.all(8.0).r,
                          child: Card(
                              shape: RoundedRectangleBorder(

                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child:
                              Column(
                                children: [
                                  Padding(
                                      padding:  EdgeInsets.all(8.0.r),
                                      child: Row(
                                        children: [
                                          Expanded(flex: 2, child: Center(child:
                                          AutoSizeText("المدى:", style: TextStyle(fontSize: 17.sp,
                                              fontWeight: FontWeight.bold,fontFamily: 'Cairo'),minFontSize: 17,maxFontSize: 19,))),

                                          Expanded(flex: 2, child: Center(child:
                                          GestureDetector(
                                              onTap: () {
                                                setState(() =>
                                                    getStockChartData(
                                                        7));
                                              },
                                              child: AutoSizeText("أسبوع",
                                                style: TextStyle(fontFamily: 'Cairo',fontSize: 17.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: selectedDuration == 7
                                                        ? Color(0xff8F3F71)
                                                        : Colors.black87),
                                                minFontSize: 17,maxFontSize: 19,)))),

                                          Expanded(flex: 2, child: Center(child:
                                          GestureDetector(
                                              onTap: () {
                                                setState(() =>
                                                    getStockChartData(
                                                        30));
                                              },
                                              child: AutoSizeText("شهر", style: TextStyle(fontFamily: 'Cairo',fontSize: 17.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: selectedDuration == 30
                                                      ? Color(
                                                      0xff8F3F71)
                                                      : Colors.black87),minFontSize: 17,maxFontSize: 19,)))),

                                          Expanded(flex: 2, child: Center(child:
                                          GestureDetector(
                                              onTap: () {
                                                setState(() =>
                                                    getStockChartData(
                                                        180));
                                              },
                                              child: AutoSizeText("6 أشهر", style: TextStyle(fontFamily: 'Cairo',fontSize: 17.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: selectedDuration == 180
                                                      ? Color(0xff8F3F71)
                                                      : Colors.black87),minFontSize: 17,maxFontSize: 19,)))),

                                          Expanded(flex: 2, child: Center(child:
                                          GestureDetector(
                                              onTap: () {
                                                setState(() =>
                                                    getStockChartData(
                                                        365));
                                              },
                                              child: AutoSizeText("سنة", style: TextStyle(fontFamily: 'Cairo',fontSize: 17.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: selectedDuration == 365
                                                      ? Color(0xff8F3F71)
                                                      : Colors.black87),minFontSize: 17,maxFontSize: 19,)))),
                                        ],
                                      )),


                                ],
                              )
                          ),
                        ),
                        Directionality(
                          textDirection: Directionality.of(context),
                          child:  Column(
                            children: [
                              SizedBox(
                                height: 400.h,
                                child:


                                SfCartesianChart(
                                    tooltipBehavior: _tooltipBehavior,

                                    primaryYAxis: NumericAxis(
                                      //    minimum: 0,
                                        title: AxisTitle(text: widget.unit,textStyle: TextStyle(fontSize: 17,fontFamily: 'Cairo')),
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
                                            fontFamily: 'Cairo',
                                            fontSize: 14.sp
                                        )
                                      // axisLine: AxisLine(
                                      //      color: Colors.deepOrange,
                                      //       width: 2,

                                      //     )
                                    ),
                                    onDataLabelRender: (DataLabelRenderArgs args) {
                                      //args.color = Colors.black;

                                    },
                                    // Chart title
                                    // title: ChartTitle(text: widget.name.toString(),textStyle: TextStyle(fontFamily:'tajawal')),
                                    // Enable legend
                                    legend: Legend(
                                        overflowMode: LegendItemOverflowMode.wrap,
                                        isVisible: true,
                                        textStyle:  TextStyle(fontSize: 16.sp,fontFamily: 'Cairo'),

                                        position: LegendPosition.bottom
                                    ),
                                    // Enable tooltip

                                    series:

                                    seriesData),
                              ),
                            ],
                          ),


                        ),

                        Padding(

                            padding:  EdgeInsets.all(20.0.r),
                            child:
                            TableViewWidget(name: widget.name,
                              unit: widget.unit,
                              data: data.pricesData!,
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            alignment: Alignment.topRight,
                            child: AutoSizeText("أعلى المحافظات", style: TextStyle(
                                color: Colors.black45,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,fontFamily: 'Cairo'),minFontSize: 16,maxFontSize: 18,),
                          ),
                        ),
                        Directionality(
                          textDirection: Directionality.of(context),
                          child:
                          Padding(

                              padding:  EdgeInsets.all(20.0.r),
                              child:
                              TableGovViewWidget(name: widget.name,
                                unit: widget.unit,
                                data: data.maxGovs!,
                              )
                          ),

                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            alignment: Alignment.topRight,
                            child: AutoSizeText("أدنى المحافظات", style: TextStyle(
                                color: Colors.black45,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,fontFamily: 'Cairo'),minFontSize: 16,maxFontSize: 18,),
                          ),
                        ),
                        Directionality(
                          textDirection: Directionality.of(context),
                          child:
                          Padding(

                              padding:  EdgeInsets.all(20.0.r),
                              child:
                              TableGovViewWidget(name: widget.name,
                                unit: widget.unit,
                                data: data.minGovs!,
                              )
                          ),
                        )  ],
                    ),
                  )
              );
            }
            else {
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
          }
      );




  }



  getStockChartData(duration) {
    setState(() {
      selectedDuration = duration;
      print("durationclicked$duration");
      loadChartData(duration);
    });

  }
}