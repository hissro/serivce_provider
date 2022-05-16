import 'package:flutter/material.dart';

class TopContainer extends StatelessWidget
{
  final double height;
  final double width;
  final Widget child;
  final EdgeInsets ? padding;
  final String image ;

  const TopContainer({required this.height, required this.width, required this.child,   this.padding , required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(

         image: DecorationImage(
           colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
           image: NetworkImage(
                      image,
                   ),
                   fit: BoxFit.cover,
                 ),

          // color: LightColors.kDarkYellow,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(40.0),
            bottomLeft: Radius.circular(40.0),
          )),
      height: height,
      width: width,
      child: child,
    );
  }
}
