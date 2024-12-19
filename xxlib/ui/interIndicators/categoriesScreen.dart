import 'dart:async';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reidsc/core/services/InterIndicatorsService.dart';
import 'package:reidsc/data/model/Indicators/IndCategory.dart';

import 'package:reidsc/ui/interIndicators/InterIndDataCard.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/model/Indicators/InterIndicatorData.dart';

class InterCategoriesScreen extends StatefulWidget {
  final int index;
  final String selectedTopics;

  const InterCategoriesScreen(
      {Key? key, required this.index, required this.selectedTopics})
      : super(key: key);

  @override
  _InterCategoriesScreenState createState() => _InterCategoriesScreenState();
}

class _InterCategoriesScreenState extends State<InterCategoriesScreen> {
  late List<IndCategory> categories = [];
  late List<InterIndicatorData> indicators = [];

  Future<List<IndCategory>> loadCategories() async {
    var completer = Completer<List<IndCategory>>();

    categories =
        await InterIndService().getInterIndCategories(widget.selectedTopics);
    print(categories.length);
    completer.complete(
        await InterIndService().getInterIndCategories(widget.selectedTopics));
    getData(int.parse(categories[widget.index].id.toString()));
    return completer.future;
    // print(tabs.length);

    //  return tabs;
  }

  @override
  void initState() {
    intialize();
    // TODO: implement initState
    loadCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: categories.isEmpty ? loadCategories() : null,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (categories.length > 0) {
            return Container(
              color: Color(0xffF4F4F4),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.all(15.0.r),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            padding: EdgeInsets.only(right: 5, bottom: 0).r,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                for (final cat in categories)
                                  ChoiceChip(
                                      label: AutoSizeText(
                                        cat.name.toString(),
                                        minFontSize: 17,
                                        maxFontSize: 19,
                                      ),
                                      selected: cat.isSelected!,
                                      selectedColor: const Color(0xff8F3F71),
                                      labelStyle: TextStyle(
                                          color: cat.isSelected == true
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 17.sp),
                                      onSelected: (value) {
                                        getData(cat.id!);
                                      },
                                      backgroundColor: Colors.white)
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      for (int i = 0; i < indicators.length; i++)
                        Column(
                          children: [
                            InterIndCard(data: indicators[i]),
                            SizedBox(
                              height: 10.h,
                            )
                          ],
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
        });
  }

  getData(int id) {
    for (final cat in categories) {
      cat.setIsSelected(false);
    }
    final category = categories.firstWhere(
      (element) => element.id == id,
    );
    setState(() {
      category.setIsSelected(true);
      loadIndicators(id);
    });
  }

  loadIndicators(int id) async {
    var data = await InterIndService().getInterIndData(id);
    setState(() {
      indicators = data;
      print(indicators);
      // mainCategoryLoaded=true;
    });
  }

  Future<void> intialize() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    //   String localPath = (await _findLocalPath()) + Platform.pathSeparator + 'Download';
    final savedDir = appDocDir;
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    // await FlutterDownloader.initialize();
  }
}
