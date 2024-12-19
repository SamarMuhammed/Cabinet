import 'dart:async';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/services/LocalIndicatorsService.dart';
import 'package:reidsc/data/model/Indicators/IndChartData.dart';

import 'package:reidsc/data/model/Indicators/Indicators.dart';
import 'package:reidsc/data/model/generic/listItem.dart';
import 'package:reidsc/generic/TableWidget.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'dart:ui' as ui;

class ChartData {
  ChartData(this.x, this.y, this.y1, this.y2);
  final String x;
  final double? y;
  final double? y1;
  final double? y2;
}

int chartID = 0;
int _selectedIndex = 0;
num max = 0;
String firstAxisUnit = "";
String secondAxisUnit = "";


class ChartView extends StatefulWidget {
  final int subCatID;
  final String subCatName;
  const ChartView({Key? key, required this.subCatID, required this.subCatName}) : super(key: key);

  @override
  _ChartViewState createState() => _ChartViewState();
}



class _ChartViewState extends State<ChartView> {
  late IndChartData data = new IndChartData();
  late List<CartesianSeries<dynamic, String>> seriesData = [];
  late List<ChartSeries<dynamic, String>> stackedSeriesData = [];
  late TooltipBehavior _tooltipBehavior;
  List<ChartAxis> axis= [];
  loadData() async {
    print("enter");
    _tooltipBehavior = TooltipBehavior(enable: true);

    data = await LocalIndService().getLocIndChartData(widget.subCatID);
    List<listItem> items = [];
    if (data.indicators!.isNotEmpty) {
      for (var m in data.indicators![0].data!)
        //  data.indicators![0].data!.map((m)=>()
          {
        //  Indicator c = Indicator.fromJson(m);

        items.add(listItem(m.date!, m.value!,0));
        print("c");
      }

      print("parentChart"+data.chartID.toString());
      setState(() {


        if (data.chartID == 1) //single
            {
          chartID = 1;
          firstAxisUnit = data.indicators![0].unit.toString();
          //  for (int i = 0; i < data.indicators!.length; i++) {
          print("child "+data.indicators![0].chartTypeId.toString());
          if (data.indicators![0].chartTypeId == 2) // lineChart
              {
            seriesData =
            [
              LineSeries<listItem, String>(
                dataSource: items,
                markerSettings: MarkerSettings(
                    isVisible: true,
                    // Marker shape is set to diamond
                    shape: DataMarkerType.circle
                ),

                xValueMapper: (listItem ind, _) => ind.date,
                yValueMapper: (listItem ind, _) => double.parse((ind.value).toStringAsFixed(2)),
                name: data.indicators![0].name,
                enableTooltip: true,
                // Enable data label
                // dataLabelSettings: const DataLabelSettings(
                // angle: 45,
                // color: Colors.red,

                //      isVisible: true)
              )
            ];
          }
          else if (data.indicators![0].chartTypeId == 1) // columnChart
              {
            seriesData =
            [
              ColumnSeries<listItem, String>(
                dataSource: items,
                markerSettings: MarkerSettings(
                    isVisible: true,
                    // Marker shape is set to diamond
                    shape: DataMarkerType.circle
                ),

                xValueMapper: (listItem ind, _) => ind.date,
                yValueMapper: (listItem ind, _) => double.parse((ind.value).toStringAsFixed(2)),
                name: data.indicators![0].name,
                enableTooltip: true,
                // Enable data label
                // dataLabelSettings: const DataLabelSettings(
                // angle: 45,
                // color: Colors.red,

                //      isVisible: true)
              )
            ];
          }
          else if (data.indicators![0].chartTypeId == 6) // BarChart
              {
            seriesData =
            [
              BarSeries<listItem, String>(
                dataSource: items,
                markerSettings: MarkerSettings(
                    isVisible: true,
                    // Marker shape is set to diamond
                    shape: DataMarkerType.circle
                ),

                xValueMapper: (listItem ind, _) => ind.date,
                yValueMapper: (listItem ind, _) => double.parse((ind.value).toStringAsFixed(2)),
                name: data.indicators![0].name,
                enableTooltip: true,
                // Enable data label
                // dataLabelSettings: const DataLabelSettings(
                // angle: 45,
                // color: Colors.red,

                //      isVisible: true)
              )
            ];
          }
          // }
        }
        else if ( data.chartID == 2) ////group
            {


          chartID = 2;
          List <Indicators> indicators;
          var item;
          if(data.indicators![0].chartTypeId == 1)
            indicators = data.indicators!.reversed.toList();
          else
            indicators = data.indicators!;
          firstAxisUnit = indicators![0].unit.toString();
          secondAxisUnit = indicators[1].unit.toString();

          print(indicators.toString());

          for (int i = 0; i < indicators.length; i++) {
            items = [];
            /*  axis.add( NumericAxis(
              numberFormat: NumberFormat.compact(),
              majorGridLines: const MajorGridLines(
                  width: 0),

              opposedPosition: true,
              title: AxisTitle(text: indicators[i].unit,),

              name: 'yAxis'+i.toString(),
              //     interval: 1000,
              // interval:10,
              //  minimum: double.parse( min.toString()),
              //maximum: double.parse( max.toString()),

            ));*/
            for (var m in indicators[i].data!)
              //  data.indicators![0].data!.map((m)=>()
                {
              //  Indicator c = Indicator.fromJson(m);
              print(m.date!);
              items.add(listItem(m.date!, m.value!,0));

            }
            //      print("chilechart"+indicators![i].chartTypeId.toString());

            if (indicators[i].chartTypeId == 2) // line
                {
              item =
                  LineSeries<listItem, String>(
                    dataSource: items,
                    animationDuration: 4500,
                    animationDelay: 2000,
                    markerSettings: MarkerSettings(
                        isVisible: true,
                        // Marker shape is set to diamond
                        shape: DataMarkerType.circle
                    ),

                    xValueMapper: (listItem ind, _) => ind.date,
                    yValueMapper: (listItem ind, _) => double.parse((ind.value).toStringAsFixed(2)),
                    //     yAxisName: 'yAxis'+i.toString(),
                    //     sortingOrder: SortingOrder.ascending,
                    //   sortFieldValueMapper: (listItem ind, _) => ind.date,
                    //  xAxisName: 'xAxis1',
                    name: indicators[i].name,
                    yAxisName: 'yAxis'+i.toString(),
                    enableTooltip: true,
                    // Enable data label
                    // dataLabelSettings: const DataLabelSettings(
                    // angle: 45,
                    // color: Colors.red,

                    //      isVisible: true)
                  );
              List<listItem> sortedItems =[];
              // sortedItems = items;

              //  sortedItems.sort((a, b) => a.value.compareTo(b.value));
              //max = sortedItems.last.value ;
              //   min = sortedItems.first.value;



            }
            else if (indicators[i].chartTypeId == 1) // column {
                {
              //   firstAxisUnit = indicators[i].unit.toString();

              item =
                  ColumnSeries<listItem, String>(
                    dataSource: items,
                    markerSettings: MarkerSettings(
                        isVisible: true,
                        // Marker shape is set to diamond
                        shape: DataMarkerType.circle
                    ),

                    xValueMapper: (listItem ind, _) => ind.date,
                    yValueMapper: (listItem ind, _) => double.parse((ind.value).toStringAsFixed(2)),
                    name: indicators[i].name,
                    enableTooltip: true,
                    yAxisName: 'yAxis'+i.toString(),
                    //   yAxisName: 'yAxis'+i.toString(),
                    // Enable data label
                    // dataLabelSettings: const DataLabelSettings(
                    // angle: 45,
                    // color: Colors.red,

                    //      isVisible: true)
                  );
            }
            else if (data.indicators![i].chartTypeId == 4) // stackedChart
                {
              //   firstAxisUnit = indicators[1].unit.toString();
              item =

                  StackedColumnSeries<listItem, String>(
                    dataSource: items,
                    //  groupName: "Group "+i.toString(),


                    xValueMapper: (listItem ind, _) => ind.date,
                    yValueMapper: (listItem ind, _) => double.parse((ind.value).toStringAsFixed(2)),
                    name: indicators[i].name,
                    enableTooltip: true,
                    yAxisName: 'yAxis'+i.toString(),
                    // Enable data label
                    // dataLabelSettings: const DataLabelSettings(
                    // angle: 45,
                    // color: Colors.red,

                    //      isVisible: true)
                  );

            }
            seriesData.add(item);
            print("seriesData"+stackedSeriesData.length.toString());
          }
          //print("Length "+seriesData.length.toString());
        }


        else if (data.chartID == 3 ) ////multi
            {
          chartID = 3;
          firstAxisUnit = data.indicators![0].unit.toString();
          var item;
          for (int i = 0; i < data.indicators!.length; i++) {
            items = [];
            for (var m in data.indicators![i].data!)
              //  data.indicators![0].data!.map((m)=>()
                {
              //  Indicator c = Indicator.fromJson(m);

              items.add(listItem(m.date!, m.value!,0));
              print("c");
            }
            print("chilechart"+data.indicators![i].chartTypeId.toString());
            if (data.indicators![i].chartTypeId == 2) // line  {
              item =
                  LineSeries<listItem, String>(
                    dataSource: items,
                    markerSettings: MarkerSettings(
                        isVisible: true,
                        // Marker shape is set to diamond
                        shape: DataMarkerType.circle
                    ),

                    xValueMapper: (listItem ind, _) => ind.date,
                    yValueMapper: (listItem ind, _) => double.parse((ind.value).toStringAsFixed(2)),
                    name: data.indicators![i].name,
                    enableTooltip: true,
                    // Enable data label
                    // dataLabelSettings: const DataLabelSettings(
                    // angle: 45,
                    // color: Colors.red,

                    //      isVisible: true)
                  );
            else if (data.indicators![i].chartTypeId == 1) // column {
              item =
                  ColumnSeries<listItem, String>(
                    dataSource: items,
                    markerSettings: MarkerSettings(
                        isVisible: true,
                        // Marker shape is set to diamond
                        shape: DataMarkerType.circle
                    ),

                    xValueMapper: (listItem ind, _) => ind.date,
                    yValueMapper: (listItem ind, _) => double.parse((ind.value).toStringAsFixed(2)),
                    name: data.indicators![i].name,
                    enableTooltip: true,
                    // Enable data label
                    // dataLabelSettings: const DataLabelSettings(
                    // angle: 45,
                    // color: Colors.red,

                    //      isVisible: true)
                  );
            else if (data.indicators![i].chartTypeId == 4) // stackedChart
                {
              item =

                  StackedColumnSeries<listItem, String>(
                    dataSource: items,
                    //  groupName: "Group "+i.toString(),


                    xValueMapper: (listItem ind, _) => ind.date,
                    yValueMapper: (listItem ind, _) => double.parse((ind.value).toStringAsFixed(2)),
                    name: data.indicators![i].name,
                    enableTooltip: true,
                    // Enable data label
                    // dataLabelSettings: const DataLabelSettings(
                    // angle: 45,
                    // color: Colors.red,

                    //      isVisible: true)
                  );

            }
            seriesData.add(item);
            print("seriesData"+stackedSeriesData.length.toString());
          }
          //print("Length "+seriesData.length.toString());
        }
      });
    }

  }




  @override
  void initState() {
    // TODO: implement initState
    _tooltipBehavior = TooltipBehavior(enable: true, shouldAlwaysShow: true);

    super.initState();
    loadData();
  }


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //_tooltipBehavior.showByIndex(0, 2);
      // Added 300 milliseconds to the series animation duration and provided it as the duration for the Timer.
      // Timer(Duration(milliseconds: 1800), () {
      // Activated the tooltip of the second data point’s index.
      //   _tooltipBehavior.showByIndex(0, 2);
      //  });
    });
    return
      FutureBuilder(
        future: data== null ?loadData(): null,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (data != null && seriesData.length > 0) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0.0,

                // Here we take the value from the MyHomePage object that was created by
                // the App.build method, and use it to set our appbar title.
                title: AutoSizeText("تفاصيل", style:TextStyle(fontSize: 16.sp,fontFamily: 'Cairo'),minFontSize: 16,maxFontSize: 18,),
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,

                actions: [


                  IconButton(onPressed: () {
                    Navigator.of(context).pop();
                  }
                    ,icon: const Icon(Icons.arrow_back_ios,textDirection: ui.TextDirection.ltr),color: Colors.black,)

                ],
                titleTextStyle:  TextStyle(
                    color: Colors.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold
                ),
              ),
              body: SingleChildScrollView(

                scrollDirection: Axis.vertical,


                // height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(8.0).r,
                      child: Container(
                          height: 30.h,
                          alignment: Alignment.centerRight,
                          child:  Text("المؤشرات", style:
                          TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 16.sp,fontFamily: 'Cairo',
                              color: Color(0xff212121)),)),
                    ),
                    if(chartID == 1)
                      Padding(
                        padding:  EdgeInsets.all(20.0.r),

                        child: Container(
                          height: 70.h,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.white
                          ),
                          child:
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Center(child: AutoSizeText("آخر قيمة",
                                    style: TextStyle(fontSize: 18.sp,fontFamily: 'Cairo'),minFontSize: 18,maxFontSize: 20,),
                                  )),

                              Expanded(
                                  flex: 4,
                                  child: Center(
                                    child: Row(
                                      children: [
                                        AutoSizeText(data.indicators![0].data![data.indicators![0].data!.length-1].value
                                            .toString()
                                          , style:  TextStyle(fontSize: 20.sp,
                                              color: Color(0xff8F3F71),
                                              fontWeight: FontWeight.bold),minFontSize: 20,maxFontSize: 22,),
                                        Padding(
                                          padding: const EdgeInsets.only( right:8.0),
                                          child: AutoSizeText(data.indicators![0].unit.toString(),
                                            style:  TextStyle(fontSize: 18.sp),minFontSize: 18,),
                                        )
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),

                      )
                    ,
                    Padding(
                      padding:  EdgeInsets.all(20.0.r),
                      child: Container(
                        //  height: 500,
                        //padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white
                        ),

                        child: Column(
                          children: [
                            Directionality(
                              textDirection: ui.TextDirection.rtl,
                              child:

                              Column(
                                children: [
                                  SizedBox(
                                    height: 400.h,
                                    child:


                                    SfCartesianChart(
                                        tooltipBehavior: _tooltipBehavior,
                                        // primaryXAxis: CategoryAxis(),
                                        axes:<ChartAxis>[ NumericAxis(
                                          numberFormat: NumberFormat.compact(),
                                          majorGridLines: const MajorGridLines(
                                              width: 0),

                                          opposedPosition: true,
                                          title: AxisTitle(text: secondAxisUnit,textStyle: TextStyle(fontSize: 16.sp,fontFamily: 'Cairo')),

                                          name: 'yAxis1',
                                          //     interval: 1000,
                                          // interval:10,
                                          //  minimum: double.parse( min.toString()),
                                          //maximum: double.parse( max.toString()),

                                        )],
                                        primaryYAxis: NumericAxis(
                                            title: AxisTitle(text: firstAxisUnit,textStyle: TextStyle(fontSize: 16.sp,fontFamily: 'Cairo')  ),
                                            majorGridLines: MajorGridLines(
                                              width: 0,

                                            ),
                                            name:'yAxis0'),
                                        //   primaryXAxis: CategoryAxis(),
                                        primaryXAxis: CategoryAxis(

                                            majorGridLines: MajorGridLines(
                                              width: 0,

                                            ),
                                            // Axis labels will be rotated to 90 degree
                                            labelRotation: 290,
                                            labelStyle: TextStyle(
                                              //fontFamily: GoogleFonts.tajawal().fontFamily,
                                                color: Colors.black,
                                                fontSize: 14.sp
                                                ,fontFamily: 'Cairo'
                                            )
                                          // axisLine: AxisLine(
                                          //      color: Colors.deepOrange,
                                          //       width: 2,

                                          //     )
                                        ),
                                        onDataLabelRender: (
                                            DataLabelRenderArgs args) {
                                          //args.color = Colors.black;

                                        },
                                        // Chart title
                                        title: ChartTitle(
                                          text: data.name.toString(),textStyle:TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold,fontFamily: 'Cairo'), ),
                                        // Enable legend
                                        legend: Legend(
                                            overflowMode: LegendItemOverflowMode
                                                .wrap,
                                            textStyle:  TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,fontFamily: 'Cairo'),
                                            isVisible: true

                                            , position: LegendPosition.bottom
                                        ),
                                        // Enable tooltip

                                        series:

                                        seriesData),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h,)
                            ,
                            Container(
                              decoration: const BoxDecoration
                                (
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  color: Color(0xffF5E0F2)

                              ),
                              padding: const EdgeInsets.all(0),
                              child: Padding(
                                padding:  EdgeInsets.only(
                                    right: 12, top: 4, bottom: 4).r,
                                child: Container(

                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding:  EdgeInsets.only(top: 8.0.r),
                                      child: AutoSizeText(
                                        "المصدر : " + data.source.toString(), style:
                                      TextStyle(fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,fontFamily: 'Cairo'),minFontSize: 18,maxFontSize: 20,),
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.all(8.0.r),
                      child: Container(
                          height: 30.h,
                          alignment: Alignment.centerRight,
                          child:  AutoSizeText("الجداول", style:
                          TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 18.sp
                              ,fontFamily: 'Cairo',
                              color: Color(0xff212121)),minFontSize: 18,maxFontSize: 20,)),
                    ),

                    if(data.indicators!.length > 1)
                      SingleChildScrollView(

                        scrollDirection: Axis.horizontal,

                        child:

                        Card(
                          shape: RoundedRectangleBorder(

                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Container(

                            padding: EdgeInsets.only(right: 8, left: 8, bottom: 0).r,
                            child: Row(

                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children:

                              [for (int i = 0; i < data.indicators!.length; i++)
                                ChoiceChip(
                                    label: Text(
                                        data.indicators![i].name.toString()),
                                    selected: _selectedIndex == i
                                    ,
                                    selectedColor: const Color(0xff8F3F71),
                                    labelStyle: TextStyle(color: _selectedIndex == i
                                        ? Colors.white
                                        : Colors.black,
                                        fontSize: 14,fontFamily: 'Cairo'),
                                    onSelected: (value) {
                                      setState(() {
                                        if (value) {
                                          _selectedIndex = i;
                                        }
                                      });
                                      //  getData(data.indicators![i].id!);
                                    },
                                    backgroundColor: Colors.white)
                              ],
                            )
                            ,
                          ),
                        ),),
                    Padding(

                        padding: const EdgeInsets.all(20.0),
                        child:
                        TableViewWidget(
                          name: data.indicators![_selectedIndex].name.toString(),
                          unit: data.indicators![_selectedIndex].unit.toString(),
                          data: data.indicators![_selectedIndex].data!,

                        )
                    ),


                  ],

                ),

              ),
            );
          }


          else {
            return Scaffold(
              body: Transform.scale(
                scale: 0.1,

                child: Center(
                    child: LoadingIndicator(
                        indicatorType: Indicator.ballRotateChase, /// Required, The loading type of the widget
                        colors: const [Colors.blue],       /// Optional, The color collections
                        strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
                        //backgroundColor: Colors.white,      /// Optional, Background of the widget
                        pathBackgroundColor: Colors.green
                    )
                ),
              ),
            );
          }
        },
      )
    ;
  }
}

String formatxAxis(num year) {
  int value = year.toInt();
  return '$value 年';
}




