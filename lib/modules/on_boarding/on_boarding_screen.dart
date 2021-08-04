import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:shop_app/modules/auth/login/ui/screens/login_screen.dart';
import 'package:shop_app/network/local/preference_utils.dart';
import '../../constant.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String body;

  OnBoardingModel({
    @required this.image,
    @required this.title,
    @required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final List<OnBoardingModel> _onBoardingList = [
    OnBoardingModel(
      image: "assets/images/on_boarding_1.png",
      title: "On Boarding 1 Title",
      body: "On Boarding 1 Body",
    ),
    OnBoardingModel(
      image: "assets/images/on_boarding_1.png",
      title: "On Boarding 2 Title",
      body: "On Boarding 2 Body",
    ),
    OnBoardingModel(
      image: "assets/images/on_boarding_1.png",
      title: "On Boarding 3 Title",
      body: "On Boarding 3 Body",
    ),
  ];

  final PageController onBoardingController = PageController();

  bool _isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              navigateToLoginScreen(context);
            },
            child: Text(
              "SKIP",
              style: TextStyle(color: Colors.deepOrange),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: onBoardingController,
                onPageChanged: (index) {
                  if (index == _onBoardingList.length - 1) {
                    setState(() {
                      _isLast = true;
                    });
                  } else {
                    setState(() {
                      _isLast = false;
                    });
                  }
                },
                itemCount: _onBoardingList.length,
                itemBuilder: (context, index) {
                  return buildOnBoardingItem(_onBoardingList[index]);
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Column(
              children: [
                SmoothPageIndicator(
                  controller: onBoardingController,
                  effect: SlideEffect(
                      dotColor: Colors.grey,
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 10,
                      paintStyle: PaintingStyle.stroke,
                      strokeWidth: 1,
                      activeDotColor: Colors.deepOrange),
                  count: _onBoardingList.length,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_isLast) {
                        navigateToLoginScreen(context);
                      } else {
                        onBoardingController.nextPage(
                          duration: Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void navigateToLoginScreen(BuildContext context) async {
    PreferenceUtils.setData(onBoardingKey, true);
    await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
      return LoginScreen();
    }), (route) => false);
  }

  Widget buildOnBoardingItem(OnBoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image(
              image: AssetImage("${model.image}"),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 30),
          Text(
            "${model.title}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 15),
          Text(
            "${model.body}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      );
}
