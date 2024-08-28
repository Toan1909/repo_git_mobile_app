import 'package:assign01/utils/colors.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 32),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CircleAvatar(backgroundImage:AssetImage('assets/logo.png'),radius: 30,),
                SizedBox(width: 16,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Mynameeee",style: TextStyle(color: secondDartColor,fontSize: 16),),
                    Text("ductoanvip123@gmail.com",style: TextStyle(color: secondDartColor.withOpacity(0.5),fontSize: 12))
                  ],
                )
              ],),
            )
          ],
        ),
      ),
    );
  }
}
