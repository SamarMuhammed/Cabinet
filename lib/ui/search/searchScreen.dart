import 'dart:async';
import 'dart:ui' as ui;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/Helper/LangHelper.dart';
import 'package:reidsc/core/services/BookmarkService.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'package:reidsc/core/services/MediaService.dart';
import 'package:reidsc/core/services/NewsService.dart';

import 'package:reidsc/core/services/ReportsService.dart';
import 'package:reidsc/core/services/SearchService.dart';
import 'package:reidsc/core/services/UserService.dart';
import 'package:reidsc/data/model/news/NewsVM.dart';

import 'package:reidsc/data/model/selectedCategories/SelectedData.dart';
import 'package:reidsc/data/model/selectedCategories/selectedCat.dart';
import 'package:reidsc/generic/Helper.dart';
import 'package:reidsc/generic/Notifications/NotificationsMenu.dart';
import 'package:reidsc/ui/news/NewsDetailsScreen.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<SelectedCat> categories = [];
  late int selectedCat;
  var userID = 0;
  String userTopics = "";
  late String selectedCatName;
  late List<NewsVM> searchResult = [];
  bool isBookmarked = false;
  late List<String> bookmarks = [];
  late List<int> intbookmarks = [];
  late List<String> reportsbookmarks = [];
  late List<String> newsbookmarks = [];
  late List<String> mediabookmarks = [];
  var items;
  bool isSearch = false;
  String currentLanguage = 'en';

  final fieldText = TextEditingController();

  //TextEditingController controllerFullName = TextEditingController();

  void _loadLanguage() async {
    currentLanguage = await getSelectedLanguage();
    print("loadlang$currentLanguage");
    setState(() {}); // Update UI with the selected language
  }

  Future<String> getSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedLanguage') ?? 'en'; // Default to English
  }
  loadResult(name) async {
    var items = await SearchService().search(
      page: 1,
      searchItem: fieldText.text,
    );
    // print(items[0].image);
    setState(() {
      searchResult = items;
      if (searchResult.length > 0) {
        isVisible = true;
        isSearch = true;
      } else {
        isVisible = false;
        isSearch = false;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    // loadCategories();
    //getUserSavedTopics();
    //getUserSavedNews();
    //getUserSavedReports();
    isVisible = true;
    isSearch = false;
    _loadLanguage();
    super.initState();
    //fieldText.addListener(_onSearchClicked);
  }

  void dispose() {
    fieldText.dispose();
    super.dispose();
  }

  String _name = '';
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,

          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(
            'nav_search'.tr(),
            style: GoogleFonts.tajawal(
                textStyle: TextStyle(
              fontSize: 18,
            )),
          ),
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
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(children: [
            Padding(
              padding:
                  EdgeInsets.only(left: 24.0, right: 23.0, top: 20, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),

              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: fieldText,

                          textDirection: ui.TextDirection.ltr,

                          //controller:controllerFullName ,
                          textAlign: TextAlign.left,
                          //     textInputAction: TextInputAction.go,
                          //onTap: _onSearchClicked(),
                          onChanged:
                              // print("hello"+text);

                              _onSearchClicked(),

//onSubmitted: _onSearchClicked(),
                          decoration: InputDecoration(
                            // errorText:  _submitted  ? _errorNameText : null,
                            hintText: 'nav_search'.tr(),

                            prefixIcon: IconButton(
                              onPressed: _onSearchClicked,
                              icon: Icon(
                                Icons.search,
                                color: Color(0xff888888),
                                size: 25,
                              ),
                            ),
                            suffixIcon: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween, // added line
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.transparent,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  // color: Colors.white,
                                  child: IconButton(
                                    onPressed: clearText,
                                    icon: Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            isDense: true,
                            // Added this
                            contentPadding: EdgeInsets.all(12),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff21212133), width: 1.5),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff21212133), width: 1.5),
                              borderRadius: BorderRadius.circular(20.0),
                            ),

                            //hintText: 'Enter valid email id as abc@gmail.com'
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _onSearchClicked();
                        },
                        child:  Text(
                          'nav_search'.tr(),
                          //  style: TextStyle(color:Colors.white,backgroundColor:Color(0xffb5102b)  ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffb5102b),
                          elevation: 0,
                        ),
                      ),
                    ],
                  )),
            ),
            (isSearch == true)
                ? Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Container(
                      child: Center(
                        child: Text('search_results'.tr(),
                            style: GoogleFonts.tajawal(
                              textStyle: TextStyle(
                                  fontSize: 16.sp, color: Color(0xffb5102b)),
                            )),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      child: Center(
                        child: Text("",
                            style: GoogleFonts.tajawal(
                              textStyle: TextStyle(
                                  fontSize: 12.sp, color: Color(0xff8F3F71)),
                            )),
                      ),
                    ),
                  ),
            if (isVisible == true)
              Container(
                  color: Colors.black12,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(right: 14, left: 14, top: 14),
                        child: GestureDetector(
                          onTap: () {
                            getNewsByID(searchResult[index].id)
                                .then((value) => {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ctx) => DetailsScreen(
                                            newD: value!,
                                          ),
                                        ),
                                      )
                                    });
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
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          width: 97.0,
                                          height: 120,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(17),
                                              child: Image.network(
                                                DioBaseService()
                                                        .Cap_Upload_URL +
                                                    searchResult[index]
                                                        .photo
                                                        .toString()
                                                        .toString(),
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        Expanded(
                                          flex: 6,
                                          child: AutoSizeText(
                                            LocalizationHelper.getLocalizedValue( searchResult[index].toMap(), currentLanguage, 'title'),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: Color(0xff212121)),
                                            minFontSize: 16,
                                            maxFontSize: 18,
                                          ),
                                        ),
                                      ]),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text.rich(
                                                TextSpan(
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                  ),
                                                  children: [
                                                    WidgetSpan(
                                                      child: Icon(
                                                        Icons
                                                            .calendar_today_rounded,
                                                        size: 16,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                        text: searchResult[
                                                                index]
                                                            .formatedPublishDate
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 15)),

                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                /*  GestureDetector(


                            )),
                        ),*/
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: searchResult.length,
                    shrinkWrap: true,
                  ))
            else if (isVisible == false)
              Container()
          ]),
        ));
  }

  _onSearchClicked() {
    print("onseatrch" + fieldText.text);
    TextEditingController controllerFullName = TextEditingController();
    if (fieldText.text != null &&
        fieldText.text.isNotEmpty &&
        fieldText.text != " ") {
      //TextEditingController controllerEmail=TextEditingController();
      setState(() {
        loadResult(fieldText.text);
        if (searchResult.length > 0) {
          isVisible = true;
        } else {
          searchResult.clear();
          isSearch = true;
          isVisible = false;
        }
      });
      print(fieldText.text);
      // print(selectedCat);
      // print(selectedCatName);
      // print(userTopics);
//loadResult(id, catName, userID)
//items= await SearchService().search(mainCatID: selectedCat, mainCatName: selectedCatName, searchItem: _name, selectedTopics: userTopics);
// print(searchResult.length);
    } else {
      clearText();
    }
  }

  void clearText() {
    fieldText.clear();
    setState(() {
      searchResult = [];

      isVisible = false;
      isSearch = true;
    });
  }
}
