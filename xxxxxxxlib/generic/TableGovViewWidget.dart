import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reidsc/data/model/Indicators/Data.dart';

class TableGovViewWidget extends StatelessWidget {
  final String name;
  final String unit;
  final List<dynamic> data;

  const TableGovViewWidget({Key? key, required this.name, required this.unit,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white
      ),
      height:100.h,
      child:
      Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(

              children: [
                const Expanded(
                    flex:2,
                    child: Center(child: Text("المحافظة",style: TextStyle(fontSize: 20),))),
                Expanded(
                    flex:2,
                    child: Center(child: Text("القيمة"+" " + "(" + unit + ")",style: TextStyle(fontSize: 20))))

              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: ListView.builder(

                itemCount: data.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context,index){

                  return Row(

                    children: [
                      Expanded(
                          flex:2,
                          child: Container(
                            decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.all(Radius.zero),
                                border: Border.all(
                                    color: Colors.black12
                                )

                            ),
                            child: Center(child: Text(data[index].govName.toString(),
                              style:  TextStyle(color: Colors.black,fontSize: 16.sp),)),
                          )),
                      Expanded(
                          flex:2,
                          child: Container(
                            decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.all(Radius.zero),
                                border: Border.all(
                                    color: Colors.black12
                                )

                            ),
                            child: Center(child: Text(data[index].value.toString(),
                              style:  TextStyle(color: Colors.black,fontSize: 16.sp),)),
                          ))
                    ],
                  );
                }

            ),
          ),
        ],
      ),



    );
  }
}