// @dart=2.9

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import 'controller_provider.dart';


class Centaur extends StatefulWidget {


  @override
  State<Centaur> createState() => _CentaurState();
}

class _CentaurState extends State<Centaur> {
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
            child: Text("Wolvie",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 40
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20,),
          Expanded(
            child: RiveAnimation.asset("assets/wolverine_turn.riv",

              // animations: ['idle'],
              controllers: controller.wolfAnimation(),
            ),
          ),
          SizedBox(height: 50,),
        ],
      ),
    );
  }
}
