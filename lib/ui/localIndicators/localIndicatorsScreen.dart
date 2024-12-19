import 'dart:async';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reidsc/data/model/Indicators/IndCategory.dart';
import 'package:reidsc/core/services/LocalIndicatorsService.dart';
import 'package:reidsc/data/model/Indicators/LocalIndSubCategory.dart';
import 'package:reidsc/ui/localIndicators/chartScreen.dart';

import 'package:loading_indicator/loading_indicator.dart';

class LocalIndicators extends StatefulWidget {
  final String selectedTopics;

  const LocalIndicators({Key? key, required this.selectedTopics})
      : super(key: key);

  @override
  _LocalIndicatorsState createState() => _LocalIndicatorsState();
}

class _LocalIndicatorsState extends State<LocalIndicators> {
  late List<IndCategory> categories = [];
  late List<LocalIndSubCategory> subCategories = [];

  Future<List<IndCategory>> loadLocalCat() async {
    var completer = Completer<List<IndCategory>>();

    categories = await LocalIndService().getLocIndCategories("1");
    completer.complete(await LocalIndService().getLocIndCategories("1"));

    setState(() {
      getData(int.parse(categories[0].id.toString()));
    });
    return completer.future;
  }

  loadLocalSubcat(int id) async {
    var subcats = await LocalIndService().getLocIndSubCategories(id);
    print(subcats[0].indicator!.date.toString());
    setState(() {
      subCategories = subcats;
      // mainCategoryLoaded=true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("IntSelectedTopics " + widget.selectedTopics);
    loadLocalCat();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: categories.isEmpty ? loadLocalCat() : null,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (categories.length > 0) {
            return Scaffold(
              backgroundColor: const Color(0xffF4F4F4),
              body: SingleChildScrollView(
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            padding:
                                EdgeInsets.only(right: 5, left: 5, bottom: 0),
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                for (final cat in categories)
                                  ChoiceChip(
                                      label: AutoSizeText(
                                        cat.name.toString(),
                                        minFontSize: 15,
                                        maxFontSize: 19,
                                      ),
                                      selected: cat.isSelected!,
                                      selectedColor: const Color(0xfff78c9c),
                                      labelStyle: TextStyle(
                                          color: cat.isSelected == true
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 15.sp),
                                      onSelected: (value) {
                                        getData(cat.id!);
                                      },
                                      backgroundColor: Colors.white)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),

                          // physics: ClampingScrollPhysics(),
                          itemCount: subCategories.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CardIcon(context, index);
                          }),
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

  getData(int id) {
    for (final cat in categories) {
      cat.setIsSelected(false);
    }
    final category = categories.firstWhere(
      (element) => element.id == id,
    );
    setState(() {
      category.setIsSelected(true);
      loadLocalSubcat(id);
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
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChartView(
                          subCatID:
                              int.parse(subCategories[index].id.toString()),
                          subCatName: subCategories[index].name.toString(),
                        )),
              );
            },
            child: Card(
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                title: Center(
                    child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0.r),
                      child: AutoSizeText(
                        subCategories[index].name.toString(),
                        style: TextStyle(
                            color: Color(0xff0D005F),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        minFontSize: 15,
                        maxFontSize: 17,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0).r,
                      child: AutoSizeText(
                        subCategories[index].indicator!.name.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          //  fontFamily: 'Cairo',
                        ),
                        textAlign: TextAlign.center,
                        minFontSize: 14,
                        maxFontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0.r),
                      child: AutoSizeText(
                        subCategories[index].indicator!.value.toString() +
                            " " +
                            subCategories[index].indicator!.unit.toString(),
                        style: TextStyle(
                            color: Color(0xff8F3F71),
                            fontSize: 16.sp,
                            //   fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        minFontSize: 18,
                        maxFontSize: 20,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0.r),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Icon(Icons.calendar_today_outlined),
                          AutoSizeText(
                            subCategories[index].indicator!.date.toString(),
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14.sp,
                              //   fontFamily: 'Cairo',
                            ),
                            textAlign: TextAlign.center,
                            minFontSize: 15,
                            maxFontSize: 16,
                          ),
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
