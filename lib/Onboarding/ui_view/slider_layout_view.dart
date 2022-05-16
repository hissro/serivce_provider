import 'dart:async';
import 'package:get/get.dart';
import 'package:serivce/Onboarding/model/slider.dart';
import 'package:serivce/Onboarding/widgets/slide_dots.dart';
import 'package:serivce/Onboarding/widgets/slide_items/slide_item.dart';
import 'package:flutter/material.dart';

import '../../Categories/Categories.dart';
import '../../Utilities/constants.dart';

class SliderLayoutView extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => _SliderLayoutViewState();
}




class _SliderLayoutViewState extends State<SliderLayoutView>
{

  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState()
  {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (Timer timer)
    {
      if (_currentPage < 2)
      {
        _currentPage++;
      } else
      {
        _currentPage = 0;
      }
    });
  }

  @override
  void dispose()
  {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) => topSliderLayout();

  Widget topSliderLayout() => Container(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: sliderArrayList.length,
                  itemBuilder: (ctx, i) => SlideItem(i),
                ),
                Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: <Widget>[

                    Align(
                      alignment: Alignment.bottomLeft ,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, bottom: 15.0),
                        child: InkWell(
                          onTap: (){
                            print(' Skip ');

                            Get.offAll( ()=> Categories() );
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
                          },
                          child: Text(
                            'skip'.tr ,
                            style: TextStyle(
                              fontFamily: Constants.Noura,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                              color: Constants.primery

                            ),
                          ),
                        ),
                      ),
                    ),

                    // Align(
                    //   alignment: Alignment.bottomRight ,
                    //   child: Padding(
                    //     padding: EdgeInsets.only(right: 15.0, bottom: 15.0),
                    //     child: InkWell(
                    //       onTap: (){
                    //         print(' Next ');
                    //       },
                    //       child: Text(
                    //         translate("app.next"),
                    //         style: TextStyle(
                    //           fontFamily: Constants.Noura,
                    //           fontWeight: FontWeight.w600,
                    //           fontSize: 14.0,
                    //
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    Container(
                      alignment: AlignmentDirectional.bottomCenter,
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for (int i = 0; i < sliderArrayList.length; i++)
                            if (i == _currentPage)
                              SlideDots(true)
                            else
                              SlideDots(false)
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )),
      );
}
