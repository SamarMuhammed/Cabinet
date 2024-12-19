
import 'package:flutter/material.dart';
import 'package:reidsc/core/services/LatestNewsService.dart';
import 'package:reidsc/data/model/News.dart';

class testnews extends StatefulWidget {
  const testnews({Key? key}) : super(key: key);

  @override
  State<testnews> createState() => _testnewsState();
}

class _testnewsState extends State<testnews> {
  late List<News> newsList=[];
  late bool isBookmarked;
  loadLatestNews() async{

    newsList =await LatestNewsService().getLatestNews(topics:"1");
    setState(() {
      //mainCategoryLoaded=true;
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadLatestNews();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(),
        body:Container(
            color:Colors.black12,
            margin: const EdgeInsets.symmetric(vertical: 20.0),

            height: 380.0,
            child: ListView.builder( itemBuilder: (BuildContext context,index){
              return NewsCardWidget(isBookmarked:isBookmarked,id:newsList[index].id!,title: newsList[index].title!, image: newsList[index].image.toString(), date: newsList[index].date!, width: 280,height:380);},
              itemCount: newsList.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,


            )
        )
    );
  }
}


class NewsCardWidget extends StatefulWidget {

  NewsCardWidget({Key? key,
    required this.isBookmarked,
    required this.id,
    required this.title,
    required this.image,
    required this.date,
    required this.width,
    required this.height}) : super(key: key);
  final bool isBookmarked;
  final int id;
  final String title;
  final String image;
  final String date;
  final double width;
  final double height;

  @override
  _NewsCardWidgetState createState() => _NewsCardWidgetState();
}

class _NewsCardWidgetState extends State<NewsCardWidget> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),

        child: Container(
          width: widget.width,

          height:widget.height,
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            //crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect (
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(

                    alignment: Alignment.center,

                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(widget.image,
                        width:widget.width,
                        height:200,
                        fit: BoxFit.cover,

                      ),
                    ),// If it's missing, display an empty box
                    // If it's missing, display an empty box

                  ),
                ),
              ),

              Row(
                  mainAxisSize: MainAxisSize.min,
                  children:[
                    Expanded(
                        child:  Padding(
                          padding: const EdgeInsets.only( right:12.0),
                          child: Text(widget.title,maxLines: 3,style: TextStyle(color: Color(0xff212121),fontSize: 15,fontWeight: FontWeight.bold,fontFamily:'Cairo')),
                        ),
                        flex:12
                    )
                    , Spacer(),
                    if(widget.isBookmarked == true)
                      Padding(
                        padding: const EdgeInsets.only(left:10.0,bottom: 30),
                        child: Expanded(flex:2,child: IconButton(onPressed:(

                            )async{

                        },icon: Icon(Icons.bookmark, color: Color(0xff212121), size:25.0))),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.only(left:10.0,bottom: 30),
                        child: Expanded(flex:2,child: Icon(Icons.bookmark_outline, color: Color(0xff212121), size:25.0)),
                      )
                    ,
                  ]
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children:[
                        Container(
                            child: Icon(Icons.date_range, color: Colors.black45, size: 20.0,)),
                        Padding(
                          padding: const EdgeInsets.only(left:157),
                          child: Expanded(child: Text(widget.date,style: TextStyle(color: Colors.black45))),
                        ),
                      ]),
                ),
              ),

            ],
          ),

        ),
      ),
    );
  }
}




