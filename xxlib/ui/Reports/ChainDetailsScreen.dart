import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/services/ReportsService.dart';
import 'package:reidsc/core/services/UserService.dart';
import 'package:reidsc/data/model/AllReports.dart';
import 'package:reidsc/ui/Reports/ReportsDetailsScreen.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ar', ''), // English, no country code
      ],
      title: "GFG",
      theme: new ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      //home: ChainDetails()
    );
  }
}

class ChainDetails extends StatefulWidget {
  const ChainDetails({Key? key, required this.chainD}) : super(key: key);
  final int chainD;
  @override
  _ChainDetailsState createState() => _ChainDetailsState();
}

class _ChainDetailsState extends State<ChainDetails> {
/*  String longtext = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio." +
      "Praesent libero. Sed cursus ante dapibus diam. Sed nisi." +
      "Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum.";*/
  late AllReports Reportslist = new AllReports();
  bool _isShownPw = true;
  List<String> result = [];
  //late List<Reports> Reportslist=[];
  late Reports Repolist = new Reports();
  late int length = 0;
  var userID = 0;
  late List<int> intbookmarks = [];
  late List<String> reportsbookmarks = [];
  late List<int> intreportsbookmarks = [];
  void loginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs);
    userID = prefs.getInt("UserID") == null ? 0 : prefs.getInt("UserID")!;
    //usertopics = prefs.getString("SavedTopics") == null ?"":prefs.getString("SavedTopics")!;
    print("byeeeeeeeeeee");
    // print(usertopics);

    print(userID);
    print("hhhhi");
  }

  void getUserSavedReports() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      //  userID = prefs.getInt("UserID") == null ?0:prefs.getInt("UserID")!;
      // print("userID$userID");
    });
    print("hiiii");
    final userItems = await UserService().getUserById(userId: userID);
    print(userItems);
    //usertopics=userItems.savedTopics.toString();
    setState(() {
      String bookmarkedreports = userItems.savedReports.toString();
      reportsbookmarks = bookmarkedreports.split(',');
      // print(bookmarks.length);
      //print(bookmarks[0]);
      intreportsbookmarks = reportsbookmarks.map(int.parse).toList();
    });
  }

  loadReports() async {
    print(widget.chainD);
    Reportslist = await ReportsService().getChainDet(id: widget.chainD);
    print(Reportslist);
    setState(() {
      length = Reportslist.reports!.length;
      _isShownPw = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    loginStatus();
    loadReports();

    super.initState();
    String text = Repolist.hashtags.toString();
    result = text.split(',');
    print("Hashtag " + result[0]);
    //print("reports");
//print(Reportslist.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          "تفاصيل السلسلة ",
          style: TextStyle(fontSize: 17, fontFamily: 'Cairo'),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,

        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios,
                textDirection: TextDirection.ltr),
            color: Colors.black,
          )
        ],
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      body: _isShownPw
          ? Transform.scale(
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
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              //physics: ScrollPhysics(),
              physics: ClampingScrollPhysics(),

              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      (Reportslist.icon!.contains('.jpg') ||
                              Reportslist.icon!.contains('.png') ||
                              Reportslist.icon!.contains('.jpeg'))
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  top: 36, right: 30, left: 8, bottom: 14),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.2,
                                height: MediaQuery.of(context).size.height / 3,
                                //color: Colors.red,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image.network(
                                      Reportslist.icon!,
                                      fit: BoxFit.cover,
                                    )),
                              ))
                          : Padding(
                              padding: const EdgeInsets.only(
                                  top: 36, right: 30, left: 8, bottom: 14),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.2,
                                height: MediaQuery.of(context).size.height / 3,
                                //color: Colors.red,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image.asset(
                                      'assets/images/noimage.png',
                                      fit: BoxFit.cover,
                                    )),
                              )),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: Column(
                          children: [
                            Text(
                              Reportslist.name.toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(width: 190,),
                      /*    Column(
                  children: [
                    Icon(
                      Icons.bookmark_border_outlined,
                      color: Colors.black87,
                      size: 25.0,
                    ),
                  ],
                )*/
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 40, top: 14),
                    child: Row(
                      children: [
                        Container(
                          color: Colors.red,
                          //  child:SvgPicture.asset('assets/images/calendar.svg', width: 24, height: 29.2),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        //  Text("تاريخ اخر اصدارات النشرة :31 مايو 2022")
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 35, top: 14, left: 16),
                    child: Row(
                      children: [
                        (Reportslist.description != null)
                            ? Expanded(
                                child: Text(
                                  Reportslist.description
                                      .toString(), //put your own long text here.
                                  //maxLines: 3,
                                  //  overflow:TextOverflow.clip,
                                  style: TextStyle(fontSize: 18),
                                ),
                              )
                            : Expanded(
                                child: Text(
                                  "لا يوجد وصف", //put your own long text here.
                                  //maxLines: 3,
                                  //  overflow:TextOverflow.clip,
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: 'Cairo'),
                                ),
                              ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 40, top: 14, left: 16),
                        child: Text(
                          "الاصدارات",
                          style: TextStyle(fontSize: 20, fontFamily: 'Cairo'),
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    itemCount: length,
                    physics: NeverScrollableScrollPhysics(),

                    // scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) => Wrap(
                      // direction: Axis.horizontal,
                      //spacing:1.0,
                      //runSpacing: 20.0,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 14, left: 14, top: 14),
                          child: Container(
                            height: 170,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) =>
                                            ReportsDetailsScreen(
                                              ReportsD:
                                                  Reportslist.reports![index],
                                              userID: userID,
                                            )));
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
                                          padding: EdgeInsets.all(10.0),
                                          child: Container(
                                            width: 97.0,
                                            height: 140,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(17),
                                                child: Image.network(
                                                  Reportslist
                                                      .reports![index].image
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Flexible(
                                      child: Container(
                                        height: 170,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,

                                              //height: 20,
                                              // color:Colors.red,
                                              child: Reportslist.reports![index]
                                                          .hashtags ==
                                                      ""
                                                  ? Text("")
                                                  : SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        children: <Widget>[
                                                          for (var item
                                                              in Reportslist
                                                                  .reports![
                                                                      index]
                                                                  .hashtags!
                                                                  .split((',')))
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              child: InputChip(
                                                                label:
                                                                    Text(item),
                                                                labelStyle: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                disabledColor:
                                                                    Color(
                                                                        0xffbde3e7),
                                                                // backgroundColor: Color(0xffE1E1E1),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10))),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                    flex: 5,
                                                    child: Text(
                                                      Reportslist
                                                          .reports![index].title
                                                          .toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          height:
                                                              1.5, // the height between text, default is null
                                                          letterSpacing: 1.0,
                                                          color: Color(
                                                              0xff212121)),
                                                    )),

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
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Reportslist.reports![index]
                                                        .hashtags ==
                                                    ""
                                                ? Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .calendar_today,
                                                            size: 15,
                                                          ),
                                                          AutoSizeText(
                                                            Reportslist
                                                                .reports![index]
                                                                .createDate
                                                                .toString(),
                                                            minFontSize: 15,
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                : Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .calendar_today,
                                                            size: 15,
                                                          ),
                                                          AutoSizeText(
                                                            Reportslist
                                                                .reports![index]
                                                                .createDate
                                                                .toString(),
                                                            minFontSize: 15,
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Reportslist.reports![index].hashtags ==
                                                ""
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: IconButton(
                                                    onPressed: () async {
                                                      if (intreportsbookmarks
                                                              .contains(
                                                                  Reportslist
                                                                      .reports![
                                                                          index]
                                                                      .id) ==
                                                          true) {
                                                        var msg = await ReportsService()
                                                            .unBookmarkReports(
                                                                userID: userID,
                                                                parentID: int.parse(
                                                                    Reportslist
                                                                        .reports![
                                                                            index]
                                                                        .id
                                                                        .toString()));
                                                        //  print(msg);
                                                        setState(() {
                                                          intreportsbookmarks
                                                              .remove(
                                                                  Reportslist
                                                                      .reports![
                                                                          index]
                                                                      .id);
                                                          (intreportsbookmarks
                                                                  .contains(Reportslist
                                                                      .reports![
                                                                          index]
                                                                      .id) ==
                                                              false);
                                                          getUserSavedReports();
                                                        });
                                                        return showDialog<void>(
                                                          context: context,
                                                          barrierDismissible:
                                                              false,
                                                          // user must tap button!
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'نجاح'),
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
                                                                          'حسنا'),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      } else if (intreportsbookmarks
                                                              .contains(
                                                                  Reportslist
                                                                      .reports![
                                                                          index]
                                                                      .id) ==
                                                          false) {
                                                        var msg = await ReportsService()
                                                            .bookmarkReports(
                                                                userID: userID,
                                                                parentID: int.parse(
                                                                    Reportslist
                                                                        .reports![
                                                                            index]
                                                                        .id
                                                                        .toString()));
                                                        //  print(msg);
                                                        setState(() {
                                                          (intreportsbookmarks
                                                                  .contains(Reportslist
                                                                      .reports![
                                                                          index]
                                                                      .id) ==
                                                              true);
                                                          getUserSavedReports();
                                                        });
                                                        return showDialog<void>(
                                                            context: context,
                                                            barrierDismissible:
                                                                false, // user must tap button!
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title:
                                                                    const Text(
                                                                        'نجاح'),
                                                                content:
                                                                    SingleChildScrollView(
                                                                  child:
                                                                      ListBody(
                                                                    children: <Widget>[
                                                                      Text(msg),
                                                                    ],
                                                                  ),
                                                                ),
                                                                actions: <Widget>[
                                                                  TextButton(
                                                                    child: const Text(
                                                                        'حسنا'),
                                                                    onPressed:
                                                                        () {
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
                                                    icon: intreportsbookmarks
                                                            .contains(
                                                                Reportslist
                                                                    .reports![
                                                                        index]
                                                                    .id)
                                                        ? Icon(Icons.bookmark,
                                                            color: Color(
                                                                0xff212121),
                                                            size: 25.0)
                                                        : Icon(
                                                            Icons
                                                                .bookmark_outline,
                                                            color: Color(
                                                                0xff212121),
                                                            size: 25.0)),
                                              )
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 55),
                                                child: IconButton(
                                                    onPressed: () async {
                                                      if (intreportsbookmarks
                                                              .contains(
                                                                  Reportslist
                                                                      .reports![
                                                                          index]
                                                                      .id) ==
                                                          true) {
                                                        var msg = await ReportsService()
                                                            .unBookmarkReports(
                                                                userID: userID,
                                                                parentID: int.parse(
                                                                    Reportslist
                                                                        .reports![
                                                                            index]
                                                                        .id
                                                                        .toString()));
                                                        //  print(msg);
                                                        setState(() {
                                                          (intreportsbookmarks
                                                                  .contains(Reportslist
                                                                      .reports![
                                                                          index]
                                                                      .id) ==
                                                              false);
                                                          getUserSavedReports();
                                                        });
                                                        return showDialog<void>(
                                                          context: context,
                                                          barrierDismissible:
                                                              false,
                                                          // user must tap button!
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'نجاح'),
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
                                                                          'حسنا'),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      } else if (intreportsbookmarks
                                                              .contains(
                                                                  Reportslist
                                                                      .reports![
                                                                          index]
                                                                      .id) ==
                                                          false) {
                                                        var msg = await ReportsService()
                                                            .bookmarkReports(
                                                                userID: userID,
                                                                parentID: int.parse(
                                                                    Reportslist
                                                                        .reports![
                                                                            index]
                                                                        .id
                                                                        .toString()));
                                                        //  print(msg);
                                                        setState(() {
                                                          (intreportsbookmarks
                                                                  .contains(Reportslist
                                                                      .reports![
                                                                          index]
                                                                      .id) ==
                                                              true);
                                                          getUserSavedReports();
                                                        });
                                                        return showDialog<void>(
                                                            context: context,
                                                            barrierDismissible:
                                                                false, // user must tap button!
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title:
                                                                    const Text(
                                                                        'نجاح'),
                                                                content:
                                                                    SingleChildScrollView(
                                                                  child:
                                                                      ListBody(
                                                                    children: <Widget>[
                                                                      Text(msg),
                                                                    ],
                                                                  ),
                                                                ),
                                                                actions: <Widget>[
                                                                  TextButton(
                                                                    child: const Text(
                                                                        'حسنا'),
                                                                    onPressed:
                                                                        () {
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
                                                    icon: intreportsbookmarks
                                                            .contains(
                                                                Reportslist
                                                                    .reports![
                                                                        index]
                                                                    .id)
                                                        ? Icon(Icons.bookmark,
                                                            color: Color(
                                                                0xff212121),
                                                            size: 25.0)
                                                        : Icon(
                                                            Icons
                                                                .bookmark_outline,
                                                            color: Color(
                                                                0xff212121),
                                                            size: 25.0)),
                                              ),
                                      ],
                                    )
                                    /*  GestureDetector(

                            child: Container(
                                padding: EdgeInsets.all(5.0),
                                child: Chip(
                                  label: Text(sourceslist[index].name.toString()),
                                  shadowColor: Colors.blue,
                                  backgroundColor: Colors.green,
                                  elevation: 10,
                                  autofocus: true,
                                )),
                          ),*/
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
