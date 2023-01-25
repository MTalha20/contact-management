import 'dart:math';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:todoapplication/Login/loginScreen.dart';
import 'package:todoapplication/register.dart';

class loginDashboard extends StatefulWidget {
  const loginDashboard({Key? key}) : super(key: key);

  @override
  State<loginDashboard> createState() => _loginDashboardState();
}

class _loginDashboardState extends State<loginDashboard> {
  
  int page = 0;
  late LiquidController liquidController;
  late UpdateType updateType;
  final pages = [logIn(), Register()];
  
  void initState(){
    liquidController = LiquidController();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: <Widget>[
            LiquidSwipe(
              pages: pages,
              slideIconWidget: Icon(Icons.arrow_back_ios),
              onPageChangeCallback: pageChangeCallback,
              waveType: WaveType.liquidReveal,
              liquidController: liquidController,
              enableSideReveal: true,
              ignoreUserGestureWhileAnimating: true,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(pages.length, _buildDot),
                  ),
                ],
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomLeft,
            //   child: Padding(
            //     padding: const EdgeInsets.all(25.0),
            //     child: TextButton(onPressed: () {
            //         liquidController.jumpToPage(
            //             page:
            //                 liquidController.currentPage + 1 > pages.length - 1
            //                     ? 0
            //                     : liquidController.currentPage + 1);
            //       },
            //       child: Text("Next"),
            //       style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.01),)),
            //       )          
                
            //   ),
            // )
          ],
        ),
      );
  }

Widget _buildDot(int index) {
  
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page ?? 0) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return new Container(
      width: 25.0,
      child: new Center(
        child: new Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: new Container(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }

}


