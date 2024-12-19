import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reidsc/data/model/Indicators/Data.dart';

class TableViewWidget extends StatelessWidget {
  final String name;
  final String unit;
  final List<dynamic> data;

  const TableViewWidget(
      {Key? key, required this.name, required this.unit, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white),
      height: 340.h,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                const Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        "التاريخ",
                        style: TextStyle(fontSize: 16, fontFamily: 'Cairo'),
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: Center(
                        child: Text(
                      name + " " + "(" + unit + ")",
                      style: TextStyle(fontSize: 16, fontFamily: 'Cairo'),
                    )))
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: ListView.builder(
                itemCount: data.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 40.h,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.all(Radius.zero),
                                  border: Border.all(color: Colors.black12)),
                              child: Container(
                                child: Center(
                                  child: Text(
                                    data[index].date.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.sp,
                                        fontFamily: 'Cairo'),
                                  ),
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.all(Radius.zero),
                                  border: Border.all(color: Colors.black12)),
                              child: Center(
                                  child: Text(
                                data[index].value.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                    fontFamily: 'Cairo'),
                              )),
                            ))
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
