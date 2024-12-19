import 'package:flutter/material.dart';

class listViewDemo extends StatefulWidget {
  const listViewDemo({Key? key}) : super(key: key);

  @override
  State<listViewDemo> createState() => _listViewDemoState();
}

class _listViewDemoState extends State<listViewDemo> {
  bool _value = true;
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body:

      Center(
        child: Column(
          children: <Widget>[
            Material(
              child: Container(
                width: 250,
                height: 250,
                decoration: const BoxDecoration(

                  image: DecorationImage(image:AssetImage("assets/images/env.png"),
                      fit: BoxFit.contain
                  )
                  ,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(30.0))


                  ,)
                ,



                child: Container(
                  width: 140,height: 120,
                  decoration: BoxDecoration(
                      color: _value? Colors.black26:Colors.transparent,
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(Radius.circular(15))

                  ),
                  child: Checkbox(
                    value: _value,

                    onChanged: (bool? value) {
                      print("$value  $_value");
                      setState(() => _value = value!);
                    },
                  ),

                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class OverlayClass extends StatefulWidget {
  final bool val;

  const OverlayClass({required this.val});

  @override
  _OverlayClassState createState() => _OverlayClassState();
}

class _OverlayClassState extends State<OverlayClass> {
  bool _value = false;
  @override
  void initState() {
    super.initState();
    _value = widget.val;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            Material(
              child: Container(
                decoration: const BoxDecoration(

                  image: DecorationImage(image:AssetImage("assets/images/env.png"))
                  ,
                  shape: BoxShape.rectangle
                  ,)
                ,

                padding: const EdgeInsets.all(10),

                child: Container(
                  width: 100,height: 100,
                  decoration: BoxDecoration(
                    color: _value? Colors.black26:Colors.transparent,
                    shape: BoxShape.rectangle,


                  ),
                  child: Checkbox(
                    value: _value,

                    onChanged: (bool? value) {
                      print("$value  $_value");
                      setState(() => _value = value!);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}