

import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/services/CashService.dart';
import 'package:reidsc/data/model/cashMarkets/CashMarkets.dart';
import 'package:reidsc/data/model/cashMarkets/CashMarketsCat.dart';
import 'package:reidsc/generic/Notifications/NotificationsMenu.dart';
import 'package:reidsc/ui/cashMarkets/CashMarketCard.dart';


class CashMarketScreen extends StatefulWidget {
  const CashMarketScreen({Key? key}) : super(key: key);

  @override
  _CashMarketScreenState createState() => _CashMarketScreenState();
}

class _CashMarketScreenState extends State<CashMarketScreen> {
  late List<CashMarketsCat> categories = [] ;
  late List<CashMarkets> indicators = [] ;
  //late IndChartData data = new IndChartData();
  late int selectedCat ;
  // late int selectedDuration = 7 ;
  late int selectedSubcat;
  //late List<CartesianSeries<dynamic, String>> seriesData = [];
  // List<listItem> items = [];
  // late TooltipBehavior _tooltipBehavior;

  Future<List<CashMarketsCat>> loadCategories() async{
    var completer = Completer<List<CashMarketsCat>>();
    var cats = await CashService().getCashMarketsCategories();
    setState(() {
      categories = cats;
      selectedCat = categories[0].id!;
      getCats(selectedCat);
    });
    completer.complete(await CashService().getCashMarketsCategories());
    // print("cat"+categories.length.toString());
    return completer.future;


    //  return tabs;

  }


/*  Future<List<CashMarkets>> loadIndCategories(id) async{

    var ind =await CashMarketsService().getCashMarketsData(id);
    setState(() {
      subCategories = ind;
      selectedSubcat = 0;
      print("selectedSubcat"+selectedSubcat.toString());
      getStockChartData(selectedSubcat,7);
    });

    //  completer.complete(await StockmarketService().getCategories());
    print("SubCat"+subCategories.length.toString());
    return subCategories;

    //  return tabs;

  }*/



  @override
  void initState() {
    // TODO: implement initState
    // _tooltipBehavior = TooltipBehavior(enable: true, shouldAlwaysShow: true);

    super.initState();
    loadCategories();
  }
  @override
  Widget build(BuildContext context) {
    // _tooltipBehavior.showByIndex(0, 2);

              return Scaffold(
                appBar: AppBar(
                  elevation: 0.0,

                  // Here we take the value from the MyHomePage object that was created by
                  // the App.build method, and use it to set our appbar title.
                  title: Text("أسواق النقد",style:TextStyle(fontSize: 17.sp,fontFamily: 'Cairo') ,),
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  actions: [

                   NotificationMenu()
                    //  IconButton(onPressed: getNotifications, icon: const Icon(Icons.notifications),color: Colors.black,)
                  ],
                  titleTextStyle:  TextStyle(
                      color: Colors.black,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold
                  ),
                ),
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
                            height: 50.h,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  for (final cat in categories)
                                    GestureDetector(
                                      onTap: () {
                                        setState(() => getCats(cat.id));
                                      },
                                      child: Container(
                                        padding:  EdgeInsets.all(12.0.r),
                                        child: AutoSizeText(cat.name!,
                                          style: TextStyle(
                                              color: Color(0xff0D005F),
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.bold),minFontSize: 17,maxFontSize: 19,),
                                        decoration: selectedCat == cat.id
                                            ? BoxDecoration(border: Border(
                                          bottom: BorderSide(),
                                        ), color: Color(0xffF5E0F2))
                                            : null,
                                      ),
                                    )
                                ]),
                          ),


                        ),

                        for(int i = 0; i < indicators.length; i++)
                          Padding(
                            padding:  EdgeInsets.only(top: 8,
                                right: 8,
                                left: 8).r,
                            child: Column(
                              children: [
                                // categories[i].id.toString()!="81"?
                                //(indicators[i].name.toString()!= 81)

                                CashMarketCard(data: indicators[i]),
                                /* else
                                  CashMarketCard2(data:indicators[i]),*/


                                SizedBox(height: 10.h,)
                              ],
                            ),
                          ),


                      ],
                    ),
                  ),
                ),
              );
            }



  getCats(int? id) {
    setState(() {
      selectedCat = id!;
      loadIndicators(selectedCat);
      print(selectedCat);

    });
  }

  /* void getStockChartData(int i,duration) {
    setState(() {
      selectedDuration = duration;
      loadChartData(duration);
    });

  }*/
  loadIndicators(int id) async{

    var data =await CashService().getCashMarketsData(id);
    setState(() {
      indicators = data;
      print(id);
      print("hiii");
      print(indicators);
      // mainCategoryLoaded=true;
    });

  }
}
