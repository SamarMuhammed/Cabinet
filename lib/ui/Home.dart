import 'package:auto_size_text/auto_size_text.dart';
import 'dart:ui'  as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/Helper/LangHelper.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'package:reidsc/core/services/HierarchyService.dart';
import 'package:reidsc/core/services/LatestNewsService.dart';
import 'package:reidsc/core/services/LatestReportsService.dart';
import 'package:reidsc/core/services/MainCategoryService.dart';
import 'package:reidsc/core/services/MediaService.dart';
import 'package:reidsc/core/services/NewsService.dart';
import 'package:reidsc/core/services/ReportsService.dart';
import 'package:reidsc/core/services/TopicService.dart';
import 'package:reidsc/core/services/UserService.dart';
import 'package:reidsc/data/model/Hierarchy/Minister.dart';
import 'package:reidsc/data/model/AllReports.dart';
import 'package:reidsc/data/model/News.dart';
import 'package:reidsc/data/model/license/License.dart';
import 'package:reidsc/data/model/news/NewsVM.dart';
//import 'package:idsc/data/model/MainCategory.dart';
import 'package:reidsc/data/model/Topic.dart';
import 'package:reidsc/data/model/media/Media.dart';
import 'package:reidsc/generic/Helper.dart';
import 'package:reidsc/generic/NewsCardWidget.dart';
import 'package:reidsc/generic/Notifications/NotificationsMenu.dart';
import 'package:reidsc/generic/TopicWidget.dart';
import 'package:reidsc/main.dart';
import 'package:reidsc/ui/License/LicenseScreen.dart';
import 'package:reidsc/ui/PoliciesAndInformations/tabsScreen.dart';
import 'package:reidsc/ui/Reports/AllReportsScreen.dart';

import 'package:reidsc/ui/Reports/ReportsDetailsScreen.dart';
import 'package:reidsc/ui/cabinet/tabsScreen.dart';

import 'package:reidsc/ui/cashMarkets/CashMarket.dart';
import 'package:reidsc/ui/hierarchy/allMinistersScreen.dart';
import 'package:reidsc/ui/hierarchy/ministerDetailsScreen.dart';
import 'package:reidsc/ui/localIndicators/categoriesScreen.dart';
import 'package:reidsc/ui/intro/TopicsScreen.dart';

import 'package:reidsc/ui/news/AllNewsScreen.dart';
import 'package:reidsc/ui/prices/PricesCategoryScreen.dart';
import 'package:reidsc/ui/prices/latestPricesScreen.dart';
import 'package:reidsc/ui/stockmarket/StockMarketScreen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../core/services/LicenseService.dart';
import 'news/NewsDetailsScreen.dart';
import 'primeMinister/tabsScreen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String title = "X";
  // late List<MainCategory> mainCategoryList;
  late List<Topic> userTopicsList;
  var mainCategoryLoaded = false;
  late List<NewsVM> newsList = [];
  late List<Minister> ministersList = [];
  late Minister minister;

  var userID = 0;
  var usertopics = "";
  List<int> selectedTopics = [];
  bool isBookmarked = false;
  late List<String> bookmarks = [];
  late List<int> intbookmarks = [];
  late List<String> reportsbookmarks = [];
  late List<int> intreportsbookmarks = [];
  List<String> savedNews = [];

  late List<Reports> RepoList = [];
  List<String> result = [];
  late Reports Reportslist = new Reports();
  late License license = new License();
  String currentLanguage = 'en';

  void getSavedBookmarkedNews() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      savedNews = prefs.getStringList('savedNews') ?? [];
      // userID = prefs.getInt("UserID") ?? 0;
      print("savedNews: $savedNews");
    });
  }

  void addSavedBookmarkedNews() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('savedNews', savedNews);

    setState(() {
      savedNews = prefs.getStringList('savedNews')!;
      //userID = prefs.getInt("UserID") == null ?0:prefs.getInt("UserID")!;
      print("savedNews:$savedNews");
    });
  }

  void removeSavedBookmarkedNews(articleId) async {
    final prefs = await SharedPreferences.getInstance();
    savedNews = prefs.getStringList('savedNews')!;
    savedNews.removeWhere((item) => item == articleId);

    await prefs.setStringList('savedNews', savedNews);

    setState(() {
      //userID = prefs.getInt("UserID") == null ?0:prefs.getInt("UserID")!;
      print("savedNews:$savedNews");
    });
  }

  loadMainCategories() async {
    //  mainCategoryList =await MainCategoryService().getMainCategories();
    setState(() {
      mainCategoryLoaded = true;
    });
  }

  loadLatestNews() async {
    print("ghada " + usertopics);
    var res = await NewsService().getNews(page: 1);
    //print(newsList[0].title);
    //print(newsList[0].title);
    //loadLatestreports();
    setState(() {
      newsList = res;
      //String text =Reportslist.hashtags.toString();
      //result = text.split(',');
      //print("Hashtag "+result[0]);
    });
  }

  getMinisters() async {
    var res = await HierarchyService().getMinisters(1);
    setState(() {
      ministersList = res;
    });
  }
  void _loadLanguage() async {
    currentLanguage = await getSelectedLanguage();
    print("loadlang$currentLanguage");
    setState(() {}); // Update UI with the selected language
  }

  Future<String> getSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedLanguage') ?? 'en'; // Default to English
  }
  getLicense() async {
    await LicenseService().getLicense().then((value) => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LicenseScreen(
                  license: value!,
                ))));

    print("StartL");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      //loginStatus();
      _loadLanguage();

      loadLatestNews();
      getMinisters();
      getSavedBookmarkedNews();
print("langsamar$currentLanguage");
      //getUserSavedNews();
      //getUserSavedReports();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F4F4),
      appBar: AppBar(
        elevation: 0.0,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        //leading: Image.asset('assets/images/icon.png'),

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/icon.png',
              fit: BoxFit.contain,
              height: 35,
            ),
            Text('home_title'.tr(),
                style: GoogleFonts.tajawal(textStyle: TextStyle(fontSize: 20))),
          ],
        ),

        //Text("The Egyptian Cabinet",style:GoogleFonts.tajawal(textStyle: TextStyle(fontSize: 20))),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          //NotificationMenu()
          //  IconButton(onPressed: getNotifications, icon: const Icon(Icons.notifications),color: Colors.black,)
        ],
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.height / 20
                          : MediaQuery.of(context).size.height / 10,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Container(
                            height: MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? MediaQuery.of(context).size.height / 6
                                : MediaQuery.of(context).size.height / 0.5,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TabsScreen()),
                                );
                                // Respond to button press
                              },

                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xffD2D2D2)),
                              ),
                              //  icon: Icon(Icons.image, size: 18,color:Color(0xffC64482) ,),
                              child: AutoSizeText(
                                'home_prime'.tr(),
                                style: TextStyle(
                                    color: Color(0xffb5102b),
                                    fontWeight: FontWeight.bold),
                                minFontSize: 16,
                                maxFontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 6,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CabinetTabsScreen()),
                                );
                                // Respond to button press
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xffD2D2D2).withOpacity(0.7)),
                              ),
                              child: AutoSizeText(
                              'home_cabinet'.tr(),
                                style: TextStyle(
                                    color: Color(0xffb5102b),
                                    fontWeight: FontWeight.bold),
                                minFontSize: 15,
                                maxFontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 6,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PoliciesTabsScreen()),
                                );
                                // Respond to button press
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xffD2D2D2).withOpacity(0.7)),
                              ),
                              // icon: Icon(Icons.insert_chart_rounded, size: 18,color: Color(0xff494D51)),
                              child: AutoSizeText(
                               'home_policies'.tr(),
                                style: TextStyle(
                                    color: Color(0xffb5102b),
                                    fontWeight: FontWeight.bold),
                                minFontSize: 15,
                                maxFontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 6,
                            child: ElevatedButton(
                              onPressed: () {
                                getLicense();

                                // Respond to button press
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xffD2D2D2).withOpacity(0.7)),
                              ),
                              //     icon: Icon(Icons.insert_chart_rounded, size: 18,color: Color(0xff494D51)),
                              child: AutoSizeText(
                              'home_license'.tr(),
                                style: TextStyle(
                                    color: Color(0xffb5102b),
                                    fontWeight: FontWeight.bold),
                                minFontSize: 15,
                                maxFontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 6,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LocalIndCategories(
                                          selectedTopics:
                                              selectedTopics.length == 0
                                                  ? usertopics
                                                  : selectedTopics
                                                      .toString()
                                                      .replaceAll("]", "")
                                                      .replaceAll("[", ""))),
                                );
                                // Respond to button press
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xffD2D2D2).withOpacity(0.7)),
                              ),
                              //    icon: Icon(Icons.insert_chart_rounded, size: 18,color: Color(0xff494D51)),
                              child: AutoSizeText(
                               'home_indicators'.tr(),
                                style: TextStyle(
                                    color: Color(0xffb5102b),
                                    fontWeight: FontWeight.bold),
                                minFontSize: 15,
                                maxFontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        )
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: AutoSizeText(
                           'home_news'.tr(),
                            style:
                                TextStyle(color: Colors.black87, fontSize: 14),
                            minFontSize: 14,
                            maxFontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: TextStyle(
                              fontSize: 14,
                              color: Color(0xff8F3F71),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllNewsScreen()),
                            );
                          },
                          child: Container(
                              alignment: Alignment.topRight,
                              child: AutoSizeText(
                                'home_more'.tr(),
                                style: GoogleFonts.tajawal(
                                  textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xff8F3F71)),
                                ),
                                minFontSize: 14,
                                maxFontSize: 20,
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height / 2.2,
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, index) {
                          return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => DetailsScreen(
                                      newD: newsList[index],

                                    ),
                                  ),
                                );

                                /* Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) =>
                                  DetailsScreen(
                                    newD: newsList[index],
                                    userID: userID,
                                  ),
                            ),
                          );*/
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Container(
                                    width: 280,
                                    height: 250,
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      //crossAxisAlignment: CrossAxisAlignment.stretch,

                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Container(
                                              alignment: Alignment.center,

                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: Image.network(
                                                  DioBaseService()
                                                          .Cap_Upload_URL +
                                                      newsList[index]
                                                          .photo
                                                          .toString(),
                                                  width: 280,
                                                  height: 200,
                                                  fit: BoxFit.cover,
                                                ),
                                              ), // If it's missing, display an empty box
                                              // If it's missing, display an empty box
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Row(children: [
                                            Flexible(
                                              child: AutoSizeText(
                                                LocalizationHelper.getLocalizedValue(newsList[index].toMap(), currentLanguage, 'title'),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff212121)),
                                                minFontSize: 15,
                                                maxFontSize: 20,
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () async {
                                                  if (savedNews.contains(
                                                          newsList[index]
                                                              .id
                                                              .toString()) ==
                                                      true) {
                                                    removeSavedBookmarkedNews(
                                                        newsList[index]
                                                            .id
                                                            .toString());
                                                    getSavedBookmarkedNews();

                                                    //  setState(() {
                                                    // savedNews.remove(newsList[index].id.toString()
                                                    //  );
                                                    //   (savedNews.contains(newsList[index].id)== false);
                                                    //  getSavedBookmarkedNews();
                                                    //  getUserSavedNews();
                                                    // });
                                                    // savedNews.remove(newsList[index].id.toString();

                                                    var msg =
                                                        "Item removed from bookmark list";
                                                    //  print(msg);

                                                    return showDialog<void>(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      // user must tap button!
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'Success'),
                                                          content:
                                                              SingleChildScrollView(
                                                            child: ListBody(
                                                              children: <Widget>[
                                                                Text(msg),
                                                              ],
                                                            ),
                                                          ),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              child: const Text(
                                                                  'ok'),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  } else if (savedNews.contains(
                                                          newsList[index]
                                                              .id
                                                              .toString()) ==
                                                      false) {
                                                    addSavedBookmarkedNews();

                                                    var msg =
                                                        "Item added to bookmark list";

                                                    //  print(msg);
                                                    setState(() {
                                                      savedNews.add(
                                                          newsList[index]
                                                              .id
                                                              .toString());
                                                      (savedNews.contains(
                                                              newsList[index]
                                                                  .id) ==
                                                          true);
                                                      getSavedBookmarkedNews();
                                                      //getUserSavedNews();
                                                    });
                                                    return showDialog<void>(
                                                        context: context,
                                                        barrierDismissible:
                                                            false, // user must tap button!
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Success'),
                                                            content:
                                                                SingleChildScrollView(
                                                              child: ListBody(
                                                                children: <Widget>[
                                                                  Text(msg),
                                                                ],
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child:
                                                                    const Text(
                                                                        'ok'),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        });
                                                  }
                                                },
                                                icon: savedNews.contains(
                                                        newsList[index]
                                                            .id
                                                            .toString())
                                                    ? Icon(Icons.bookmark,
                                                        color:
                                                            Color(0xffb5102b),
                                                        size: 25.0)
                                                    : Icon(
                                                        Icons.bookmark_outline,
                                                        color:
                                                            Color(0xff212121),
                                                        size: 25.0)),
                                          ]),
                                        ),
                                        SizedBox(height: 5),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Row(
                                              textDirection: ui.TextDirection.ltr,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.date_range,
                                                  color: Colors.black45,
                                                  size: 15.0,
                                                ),
                                                AutoSizeText(
                                                  newsList[index]
                                                      .formatedPublishDate
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 13),
                                                  minFontSize: 13,
                                                  maxFontSize: 16,
                                                ),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                        },
                        itemCount: newsList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: AutoSizeText('home_ministry'.tr(),
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 15.sp)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                                fontSize: 17, color: Color(0xff8F3F71)),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        allMinistersScreen()));
                          },
                          child: Container(
                              alignment: Alignment.topRight,
                              child: AutoSizeText(
                                'home_more'.tr(),
                                style: GoogleFonts.tajawal(
                                  textStyle: TextStyle(
                                      fontSize: 15.sp,
                                      color: Color(0xff8F3F71)),
                                ),
                                minFontSize: 15,
                                maxFontSize: 20,
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height / 4.5
                        : MediaQuery.of(context).size.height / 3,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ListView.builder(
                        itemBuilder: (BuildContext context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 6, left: 10, top: 1),
                            child: Container(
//height: 80,
                              //width:400,
                              child: GestureDetector(
                                onTap: () {
                                  getMinisterByID(ministersList[index].id)
                                      .then((value) => {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (ctx) =>
                                                    MinisterDetails(
                                                        minister: value!),
                                              ),
                                            )
                                          });

                                  /*   Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => ReportsDetailsScreen(ReportsD: RepoList[index],userID:userID),
                                    ),
                                  );*/
                                },
                                child: Container(
                                  width: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? MediaQuery.of(context).size.width / 1.1
                                      : MediaQuery.of(context).size.width / 3,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    elevation: 10,
                                    child: Row(
                                      children: <Widget>[
                                        Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Container(
                                                width: 80.0,
                                                height: MediaQuery.of(context)
                                                            .orientation ==
                                                        Orientation.portrait
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        6
                                                    : MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        5,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            17),
                                                    child: Image.network(
                                                      DioBaseService()
                                                              .Cap_Upload_URL +
                                                          ministersList[index]
                                                              .photo
                                                              .toString(),
                                                      fit: BoxFit.cover,
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0),
                                                      child: SizedBox(
                                                        width: 250,
                                                        //  width: 150,
                                                        child: AutoSizeText(
                                                          LocalizationHelper.getLocalizedValue(ministersList[index].toMap(), currentLanguage, 'name'),

                                                          //   overflow: TextOverflow.ellipsis,
                                                          //        textDirection: TextDirection.rtl,

                                                          style: (TextStyle(
                                                              fontSize: 15.sp,
                                                              color: Color(
                                                                  0xffb5102b),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                          minFontSize: 15,
                                                          maxFontSize: 20,
                                                        ),
                                                      ),
                                                    ),

                                                    /*  Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: (){print("On Click icon");},
                                          child: Container(

                                              child: Icon(
                                                Icons.bookmark_border_outlined,
                                                color: Colors.black87,
                                                size: 23,
                                              ),
                                          ),
                                        ),
                                      ),*/
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: SizedBox(
                                                        width: 250,
                                                        child: AutoSizeText(
                                                          LocalizationHelper.getLocalizedValue(ministersList[index].toMap(), currentLanguage, 'ministryName'),
                                                        //  LocalizationHelper.getLocalizedValue(ministersList[index].toMap(), currentLanguage, 'ministryName'),

                                                          maxLines: 2,

                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          //        textDirection: TextDirection.rtl,

                                                          style: (TextStyle(
                                                              fontSize: 15.sp)),
                                                          minFontSize: 15,
                                                          maxFontSize: 16,
                                                        ),
                                                      ),
                                                    ),

                                                    /*  Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: (){print("On Click icon");},
                                          child: Container(

                                              child: Icon(
                                                Icons.bookmark_border_outlined,
                                                color: Colors.black87,
                                                size: 23,
                                              ),
                                          ),
                                        ),
                                      ),*/
                                                  ],
                                                ),
                                                /*   Row(

                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:8.0),
                                                    child:SizedBox(
                                                      width: 250,
                                                      child: AutoSizeText(
                                                      "Since March 2019"  ,maxLines: 2,

                                                        overflow: TextOverflow.ellipsis,
                                                        //        textDirection: TextDirection.rtl,

                                                        style: (TextStyle(fontSize: 16.sp)),
                                                        minFontSize: 15,maxFontSize: 16,
                                                      ),
                                                    ),
                                                  ),


                                                ],
                                              ),
                                              Row(

                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:8.0),
                                                    child:SizedBox(
                                                      width: 150,
                                                      child: AutoSizeText(
                                                       'Date Of Birth '+ ministersList[index].ministryNameE.toString(),maxLines: 2,

                                                        overflow: TextOverflow.ellipsis,
                                                        //        textDirection: TextDirection.rtl,

                                                        style: (TextStyle(fontSize: 16.sp)),
                                                        minFontSize: 15,maxFontSize: 16,
                                                      ),
                                                    ),
                                                  ),

                                                  /*  Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: (){print("On Click icon");},
                                          child: Container(

                                              child: Icon(
                                                Icons.bookmark_border_outlined,
                                                color: Colors.black87,
                                                size: 23,
                                              ),
                                          ),
                                        ),
                                      ),*/
                                                ],
                                              ),*/
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: ministersList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
