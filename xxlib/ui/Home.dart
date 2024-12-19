import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/services/LatestNewsService.dart';
import 'package:reidsc/core/services/LatestReportsService.dart';
import 'package:reidsc/core/services/MainCategoryService.dart';
import 'package:reidsc/core/services/MediaService.dart';
import 'package:reidsc/core/services/NewsService.dart';
import 'package:reidsc/core/services/ReportsService.dart';
import 'package:reidsc/core/services/TopicService.dart';
import 'package:reidsc/core/services/UserService.dart';
import 'package:reidsc/data/model/AllReports.dart';
import 'package:reidsc/data/model/News.dart';
//import 'package:idsc/data/model/MainCategory.dart';
import 'package:reidsc/data/model/Topic.dart';
import 'package:reidsc/data/model/media/Media.dart';
import 'package:reidsc/generic/Helper.dart';
import 'package:reidsc/generic/NewsCardWidget.dart';
import 'package:reidsc/generic/Notifications/NotificationsMenu.dart';
import 'package:reidsc/generic/TopicWidget.dart';
import 'package:reidsc/main.dart';
import 'package:reidsc/ui/Reports/AllReportsScreen.dart';

import 'package:reidsc/ui/Reports/ReportsDetailsScreen.dart';

import 'package:reidsc/ui/cashMarkets/CashMarket.dart';
import 'package:reidsc/ui/localIndicators/categoriesScreen.dart';
import 'package:reidsc/ui/intro/TopicsScreen.dart';

import 'package:reidsc/ui/media/MediaCategoriesScreen.dart';
import 'package:reidsc/ui/media/MediaDetailsScreen.dart';
import 'package:reidsc/ui/news/AllNewsScreen.dart';
import 'package:reidsc/ui/prices/PricesCategoryScreen.dart';
import 'package:reidsc/ui/prices/latestPricesScreen.dart';
import 'package:reidsc/ui/stockmarket/StockMarketScreen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'media/VideoMediaScreen.dart';
import 'news/NewsDetailsScreen.dart';

class Home extends StatefulWidget {
  // final String message;

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String title = "X";
  // late List<MainCategory> mainCategoryList;
  late List<Topic> userTopicsList;
  var mainCategoryLoaded = false;
  late List<News> newsList = [];
  var userID = 0;
  var usertopics = "";
  List<int> selectedTopics = [];
  bool isBookmarked = false;
  late List<String> bookmarks = [];
  late List<int> intbookmarks = [];
  late List<String> reportsbookmarks = [];
  late List<int> intreportsbookmarks = [];

  late List<Reports> RepoList = [];
  List<String> result = [];
  late Reports Reportslist = new Reports();

  void getUserSavedNews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userID = prefs.getInt("UserID") == null ? 0 : prefs.getInt("UserID")!;
      // print("userID$userID");
    });

    final userItems = await UserService().getUserById(userId: userID);
    // print(userItems.savedTopics);
    // print(userItems.savedTopics);
    usertopics = userItems.savedTopics.toString();
    // print("usertopics "+usertopics.length.toString());
    setState(() {
      String bookmarkednews = userItems.savedNews.toString();
      bookmarks = bookmarkednews.split(',');
      //print(bookmarks.length);
      //print("bookmarkednews"+bookmarkednews);
      // print(bookmarks[0]);
      intbookmarks = bookmarks.map(int.parse).toList();
      // print(intbookmarks.length);
      // print(intbookmarks[0]);
      // print(usertopics);
      // print("byyyyyye");
    });
  }

  void getUserSavedReports() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userID = prefs.getInt("UserID") == null ? 0 : prefs.getInt("UserID")!;
      // print("userID$userID");
    });
    //print("hiiii");
    final userItems = await UserService().getUserById(userId: userID);
    //print(userItems);
    //usertopics=userItems.savedTopics.toString();
    setState(() {
      String bookmarkedreports = userItems.savedReports.toString();
      reportsbookmarks = bookmarkedreports.split(',');
      print(bookmarks.length);
      //print(bookmarks[0]);
      intreportsbookmarks = reportsbookmarks.map(int.parse).toList();
    });
  }

  loadLatestreports() async {
    var res = await LatestReportsService().getLatestReports(topics: usertopics);
    //print(RepoList.length);

    //print(RepoList[0].title);
    setState(() {
      RepoList = res;
      String text = Reportslist.hashtags.toString();
      if (text != "") result = text.split(',');
      // print("Hashtag "+result[0]);
    });
  }

  void loginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //  print(prefs);
    userID = prefs.getInt("UserID") == null ? 0 : prefs.getInt("UserID")!;
    getUserTopics();
    usertopics = prefs.getString("SavedTopics") == null
        ? ""
        : prefs.getString("SavedTopics")!;
    //print("byeeeeeeeeeee" + usertopics);
    loadLatestNews();
    // loadLatestreports();
    //print(usertopics);

    // print(userID);
    //print("hhhhi");
  }

  getUserTopics() async {
    //print("userIdHome "+userID.toString());
    var topics = await TopicService().getSavedTopics(userID);
    setState(() {
      userTopicsList = topics;
      //print("userTopics "+userTopicsList.length.toString());

      mainCategoryLoaded = true;
    });
    // print("userTopics "+userTopicsList.length.toString());
  }

  loadMainCategories() async {
    //  mainCategoryList =await MainCategoryService().getMainCategories();
    setState(() {
      mainCategoryLoaded = true;
    });
  }

  loadLatestNews() async {
    //print("ghada "+usertopics);
    var res = await LatestNewsService().getLatestNews(topics: usertopics);
    //print(newsList[0].title);
    //print(newsList[0].title);
    loadLatestreports();
    setState(() {
      newsList = res;
      //String text =Reportslist.hashtags.toString();
      //result = text.split(',');
      //print("Hashtag "+result[0]);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      loginStatus();

      getUserSavedNews();
      getUserSavedReports();
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
        title: Text("الرئيسية",
            style: TextStyle(fontSize: 13, fontFamily: 'Cairo')),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          NotificationMenu()
          //  IconButton(onPressed: getNotifications, icon: const Icon(Icons.notifications),color: Colors.black,)
        ],
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  AutoSizeText(
                    "القطاعات التي تُهمك",
                    style: TextStyle(color: Colors.black87, fontSize: 16.sp),
                    minFontSize: 15,
                    maxFontSize: 18,
                  )
                ]),
              ),
              if (mainCategoryLoaded)
                Container(
                  height: 110,
                  child: ListView.builder(
                      itemCount: userTopicsList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        if (index == userTopicsList.length - 1)
                          return Row(
                            children: [
                              TopicIcon(context, index, []),
                              TopicIcon(context, 100, []),
                            ],
                          );
                        else
                          return TopicIcon(context, index, []);
                      }),
                ),
              Container(
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.height / 20
                          : MediaQuery.of(context).size.height / 15,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            height: MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? MediaQuery.of(context).size.height / 6
                                : MediaQuery.of(context).size.height / 0.3,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MediaCategories(),
                                ));
                                // Respond to button press
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xffFFD0F2).withOpacity(0.7)),
                              ),
                              icon: Icon(
                                Icons.image,
                                size: 15,
                                color: Color(0xffC64482),
                              ),
                              label: AutoSizeText(
                                "وسائط متعددة",
                                style: TextStyle(
                                  color: Color(0xffC64482),
                                ),
                                minFontSize: 15,
                                maxFontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 6,
                            child: OutlinedButton.icon(
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
                              icon: Icon(Icons.insert_chart_rounded,
                                  size: 18, color: Color(0xff494D51)),
                              label: AutoSizeText(
                                " المؤشرات",
                                style: TextStyle(color: Color(0xff494D51)),
                                minFontSize: 15,
                                maxFontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 6,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          StockMarketScreen()),
                                );
                                // Respond to button press
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xffD0D8FF).withOpacity(0.7)),
                              ),
                              icon: Icon(Icons.monetization_on_rounded,
                                  size: 18, color: Color(0xff4451C6)),
                              label: AutoSizeText(
                                "أسواق المال ",
                                style: TextStyle(color: Color(0xff4451C6)),
                                minFontSize: 15,
                                maxFontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 6,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CashMarketScreen()),
                                );
                                // Respond to button press
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xffD0D8FF).withOpacity(0.7)),
                              ),
                              icon: Icon(Icons.monetization_on_rounded,
                                  size: 18, color: Color(0xff4451C6)),
                              label: AutoSizeText(
                                "أسواق النقد ",
                                style: TextStyle(color: Color(0xff4451C6)),
                                minFontSize: 15,
                                maxFontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 6,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LatestPricesScreen()),
                                );
                                // Respond to button press
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xffFFE9D0).withOpacity(0.7)),
                              ),
                              icon: Icon(Icons.money,
                                  size: 18, color: Color(0xffC69844)),
                              label: AutoSizeText(
                                "  أحدث الأسعار",
                                style: TextStyle(color: Color(0xffC69844)),
                                minFontSize: 15,
                                maxFontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 6,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PricesCategoryScreen()),
                                );
                                // Respond to button press
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xffD0FFE3).withOpacity(0.7)),
                              ),
                              icon: Icon(Icons.energy_savings_leaf_rounded,
                                  size: 18, color: Color(0xff20965D)),
                              label: AutoSizeText(
                                " السلع",
                                style: TextStyle(color: Color(0xff20965D)),
                                minFontSize: 15,
                                maxFontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0,
                    top: 8.0,
                    right: 8.0,
                    bottom: 0.0), // Removed bottom padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        alignment: Alignment.topRight,
                        child: AutoSizeText(
                          "الأخبار",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14.sp), // Reduced font size
                          minFontSize: 14,
                          maxFontSize: 16,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: TextStyle(
                              fontSize: 14, // Reduced font size
                              color: Color(0xff8F3F71),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllNewsScreen(
                                      selectedTopics: selectedTopics.length == 0
                                          ? usertopics
                                          : selectedTopics
                                              .toString()
                                              .replaceAll("]", "")
                                              .replaceAll("[", ""))),
                            );
                          },
                          child: AutoSizeText(
                            'عرض الكل',
                            style: TextStyle(
                                fontSize: 14.sp, // Reduced font size
                                color: Color(0xff8F3F71),
                                fontFamily: 'Cairo'),
                            minFontSize: 14,
                            maxFontSize: 16,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 300.0,
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => DetailsScreen(
                                  newD: newsList[index],
                                  userID: userID,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                width: 220,
                                height: 250,
                                color: Colors.white,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Image.network(
                                                newsList[index]
                                                    .image
                                                    .toString(),
                                                width: 200,
                                                height: 180,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 9.0),
                                        child: Row(children: [
                                          Flexible(
                                            child: AutoSizeText(
                                              newsList[index].title.toString(),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 14
                                                      .sp, // Reduced font size
                                                  color: Color(0xff212121),
                                                  height: 1.5,
                                                  letterSpacing: 1.0),
                                              minFontSize: 14,
                                              maxFontSize: 15,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              if (intbookmarks.contains(
                                                      newsList[index].id) ==
                                                  true) {
                                                var msg = await NewsService()
                                                    .unBookmarkNews(
                                                        userID: userID,
                                                        parentID: int.parse(
                                                            newsList[index]
                                                                .id
                                                                .toString()));
                                                setState(() {
                                                  intbookmarks.remove(
                                                      newsList[index].id);
                                                  (intbookmarks.contains(
                                                          newsList[index].id) ==
                                                      false);
                                                  getUserSavedNews();
                                                });
                                                return showDialog<void>(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text('نجاح'),
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
                                                              'حسنا'),
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
                                              } else if (intbookmarks.contains(
                                                      newsList[index].id) ==
                                                  false) {
                                                var msg = await NewsService()
                                                    .bookmarkNews(
                                                        userID: userID,
                                                        parentID: int.parse(
                                                            newsList[index]
                                                                .id
                                                                .toString()));
                                                setState(() {
                                                  (intbookmarks.contains(
                                                          newsList[index].id) ==
                                                      true);
                                                  getUserSavedNews();
                                                });
                                                return showDialog<void>(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title:
                                                            const Text('نجاح'),
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
                                                                'حسنا'),
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
                                            icon: intbookmarks.contains(
                                                    newsList[index].id)
                                                ? Icon(Icons.bookmark,
                                                    color: Color(0xff212121),
                                                    size:
                                                        20.0) // Reduced icon size
                                                : Icon(Icons.bookmark_outline,
                                                    color: Color(0xff212121),
                                                    size:
                                                        20.0), // Reduced icon size
                                          ),
                                        ]),
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Row(
                                            textDirection: TextDirection.rtl,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.date_range,
                                                color: Colors.black45,
                                                size: 18.0, // Reduced icon size
                                              ),
                                              AutoSizeText(
                                                newsList[index].date.toString(),
                                                style: TextStyle(
                                                    color: Colors.black45,
                                                    fontSize: 14
                                                        .sp), // Reduced font size
                                                minFontSize: 14,
                                                maxFontSize: 15,
                                              ),
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: newsList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 5.0,
                    right: 5.0,
                    top: 0.0,
                    bottom: 0.0), // Reduce padding to remove space
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        alignment: Alignment.topRight,
                        child: AutoSizeText(
                          "التقارير والإصدارات",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16.sp), // Smaller font size
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 15, // Smaller font size
                              color: Color(0xff8F3F71),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllReportsScreen(
                                    selectedTopics: selectedTopics.length == 0
                                        ? usertopics
                                        : selectedTopics
                                            .toString()
                                            .replaceAll("]", "")
                                            .replaceAll("[", "")),
                              ),
                            );
                          },
                          child: AutoSizeText(
                            'عرض الكل',
                            style: TextStyle(
                              fontSize: 16.sp, // Smaller font size
                              color: Color(0xff8F3F71),
                              fontFamily: 'Cairo',
                            ),
                            minFontSize: 15,
                            maxFontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height / 7
                        : MediaQuery.of(context).size.height / 3,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ListView.builder(
                        itemBuilder: (BuildContext context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 4, left: 8, top: 12), // Adjust padding
                            child: Container(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => ReportsDetailsScreen(
                                        ReportsD: RepoList[index],
                                        userID: userID,
                                      ),
                                    ),
                                  );
                                },
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
                                            padding: EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 75.0,
                                              height: 75,
                                              child: RepoList[index].image ==
                                                      null
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              17),
                                                      child: Image.network(
                                                        "http://new.idscapp.gov.eg/images/topics/checked/checkedCovid.png",
                                                        fit: BoxFit.cover,
                                                      ))
                                                  : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              17),
                                                      child: Image.network(
                                                        RepoList[index]
                                                            .image
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
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.calendar_today,
                                                      size: 14,
                                                    ),
                                                    AutoSizeText(
                                                      RepoList[index]
                                                          .createDate
                                                          .toString(),
                                                      minFontSize: 13,
                                                      maxFontSize: 15,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      ReportsDetailsScreen(
                                                    ReportsD: RepoList[index],
                                                    userID: userID,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 6.0),
                                                  child: SizedBox(
                                                    width: 145,
                                                    child: AutoSizeText(
                                                      RepoList[index]
                                                          .title
                                                          .toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      style: TextStyle(
                                                        fontSize: 14
                                                            .sp, // Smaller font size
                                                        height: 1.5,
                                                        letterSpacing: 1.0,
                                                      ),
                                                      minFontSize: 13,
                                                      maxFontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 18),
                                            child: IconButton(
                                              onPressed: () async {
                                                // Bookmark logic
                                              },
                                              icon: intreportsbookmarks
                                                      .contains(
                                                          RepoList[index].id)
                                                  ? Icon(Icons.bookmark,
                                                      color: Color(0xff212121),
                                                      size: 23.0)
                                                  : Icon(Icons.bookmark_outline,
                                                      color: Color(0xff212121),
                                                      size: 23.0),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: RepoList.length,
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

  Widget TopicIcon(context, index, savedTopics) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double deviceHeight = mediaQueryData.size.height;
    final double deviceWidth = mediaQueryData.size.width;
    var orientation = MediaQuery.of(context).orientation;

    // final double heightInDesign = 100;
    //   final double widthInDesign = 170;
    final double padding = 15;
    final double spaceBetween = 15;
    final double responsiveWidth = orientation == Orientation.portrait
        ? (deviceWidth / 3) - padding - (spaceBetween / 2)
        : (deviceWidth / 5) - padding - (spaceBetween / 2);
    final double responsiveHeight = 80;

    return InkWell(
      onTap: () async {
        var news, reports;
        print("selectedID " + userTopicsList[index].id.toString());
        if (!selectedTopics.contains(userTopicsList[index].id))
          selectedTopics.add(userTopicsList[index].id!);
        else
          selectedTopics.remove(userTopicsList[index].id!);
        print("selectedTopics " + selectedTopics.length.toString());

        if (!selectedTopics.contains(1)) selectedTopics.add(1);
        var topics = selectedTopics.length == 0
            ? usertopics
            : selectedTopics
                .toString()
                .replaceAll("]", "")
                .replaceAll("[", "")
                .replaceAll(" ", "");
        print("selectedTopics " + topics);
        if (selectedTopics.length == 1) {
          topics = usertopics;
        }
        news = await LatestNewsService().getLatestNews(topics: topics);

        reports = await LatestReportsService().getLatestReports(topics: topics);

        setState(() {
          print("bbefore if" +
              selectedTopics
                  .toString()
                  .replaceAll("]", "")
                  .replaceAll("[", ""));
          newsList = news;
          RepoList = reports;
        });
        //print(userTopicsList[index].id);

        //print("selected"+selectedTopics.length.toString());
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: index != 100
            ? TopicWidget(
                title: userTopicsList[index].name.toString(),
                imageURL: selectedTopics.contains(userTopicsList[index].id)
                    ? userTopicsList[index].checkedImage.toString()
                    : userTopicsList[index].unCheckedImage.toString(),
                width: responsiveWidth,
                height: 100,
              )
            : InkWell(
                onTap: () {
                  /*    pushNewScreen(
              context,
              screen: TopicsScreen(previousPage: "Home", ),
              withNavBar: false,
            //  pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );*/
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TopicsScreen(
                              previousPage: "Home",
                            )),
                  );
                },
                child: TopicWidget(
                  title: "",
                  imageURL: "http://new.idscapp.gov.eg/images/topics/add.png",
                  width: responsiveWidth,
                  height: 100,
                ),
              ),
      ),
    );
  }
}
