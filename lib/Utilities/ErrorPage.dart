import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ErrorPage extends StatelessWidget
{
    const ErrorPage({Key? key ,  this.Message}) : super(key: key);

  final Message ;

  @override
  Widget build(BuildContext context)
  {
    var size =  MediaQuery.of(context).size ;

    return Center(
      child: Container (
        padding: const EdgeInsets.only(top: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                SvgPicture.asset(
                  "assets/images/error404.svg",
                  width: size.width/3,
                  height: size.height/3,
                ),
              ],
            ),


            Container(
              padding: const EdgeInsets.all(20),
              margin:  const EdgeInsets.all(20),
              decoration: BoxDecoration(
                // color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFF05A22).withOpacity(0.3),
                  style: BorderStyle.solid,
                  width: 1.0,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  Text(Message, style: const TextStyle( fontWeight: FontWeight.bold , fontSize: 18 , fontFamily: "tajawal"),),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
