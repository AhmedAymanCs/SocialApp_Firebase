import 'package:chatapplication/modules/loginscreen/loginscreen.dart';
import 'package:chatapplication/shared/constats.dart';
import 'package:chatapplication/shared/network/local/cache_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class on_boarding extends StatelessWidget {
late  List<Widget> onboardingScreen=[
    onBoarding(
      onBoardingTitle: 'Title1',
      onBoardingText: 'Text 22222222222222222'
    ),
    onBoarding(),
    onBoarding(),
  ];
var pageController= PageController();
bool isLast=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){
                submit(context);
              },
              child: Text(
                  'Skip',
                      style: TextStyle(
                        color: Colors.white
                      ),
              )
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 400,
              width: 400,
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: pageController,
                  onPageChanged: (index) {
                  if(index==onboardingScreen.length-1)
                    {
                      isLast=true;
                    }
                  else
                    {
                      isLast=false;
                    }
                  print(isLast);
                  },
                  itemBuilder: (context,index)=>onboardingScreen[index],
                itemCount: onboardingScreen.length,
              ),
            ),
            Spacer(),
            SmoothPageIndicator(controller: pageController, count:onboardingScreen.length,
              effect: ExpandingDotsEffect(

              )
              ,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(isLast)
            {
              submit(context);
            }
          else
            {
              pageController.nextPage(
                  duration: Duration(
                    milliseconds: 350
                  ),
                  curve: Curves.fastOutSlowIn
              );
            }
            },
        child: Icon(
          Icons.arrow_forward_outlined
        ),
      ),
    );
  }

  Widget onBoarding ({
  String? onBoardingTitle,
  String? onBoardingText,
})
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$onBoardingTitle',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          '$onBoardingText',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey
          ),
        ),

      ],
    );
  }

  void submit(context)
  {
    CacheHelper.putData('onboarding', true)!.then((value) {
      navigatToAndFinish(context, loginScreen());
    });
  }
}
