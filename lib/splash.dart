// @dart=2.9


import 'package:flare_shock/controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class Splash extends StatefulWidget {

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var controller = Provider.of<ControllerProvider>(context, listen:  false);
    controller.initControllerEvent(context);
  }


  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ControllerProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Center(
            child: Text(controller.getControllerText(),
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 40
            ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20,),
          Expanded(
            child: RiveAnimation.asset("assets/flutter.riv",
            // animations: ['idle', 'lookUp'],
            controllers: controller.splashAnimation(),
            ),
          ),
          SizedBox(height: 50,),
        ],
      ),
    );
  }
}
