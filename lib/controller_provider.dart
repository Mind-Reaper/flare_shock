// @dart=2.9

import 'dart:async';

import 'package:flare_shock/centaur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gamepad/flutter_gamepad.dart';
import 'package:rive/rive.dart';

class ControllerProvider extends ChangeNotifier {
  StreamSubscription<GamepadEvent> _subscription;
  bool wolvie = false;
  bool clawIn = true;
  bool mouthOpen = true;


  //Both Animations
  RiveAnimationController idleAnim = SimpleAnimation('idle', autoplay: true);

  //Splash Animations
  RiveAnimationController lookUpAnim =
      OneShotAnimation('lookUp', autoplay: false);
  RiveAnimationController danceAnim =
      SimpleAnimation('slowDance', autoplay: false);

  //Wolvie Animations
  RiveAnimationController mouthOpenAnim = OneShotAnimation('mouthOpen', autoplay: false);
  RiveAnimationController mouthCloseAnim = OneShotAnimation('mouthClosed', autoplay: false);
  RiveAnimationController turnLeftAnim = OneShotAnimation('faceLeft', autoplay: false);
  RiveAnimationController turnRightAnim = OneShotAnimation('faceRight', autoplay: false);
  RiveAnimationController clawInAnim = OneShotAnimation('clawsStaticIn', autoplay: true);
  RiveAnimationController clawOutAnim = OneShotAnimation('clawsStaticOut', autoplay: false);
  RiveAnimationController walkAnim = SimpleAnimation('walk', autoplay: false);



  // RiveAnimationController walkForwardAnim =
  //     SimpleAnimation('Walk', autoplay: false);
  // RiveAnimationController walkBackwardAnim =
  //     SimpleAnimation('WalkBack', autoplay: false);

  String _controllerText = "Connect controller to continue";

  String getControllerText() => _controllerText;

  List<RiveAnimationController> splashAnimation() =>
      [idleAnim, lookUpAnim, danceAnim];
  List<RiveAnimationController> wolfAnimation() =>
      [mouthOpenAnim, mouthCloseAnim, turnLeftAnim, turnRightAnim, clawInAnim, clawOutAnim, walkAnim];

  initControllerEvent(BuildContext context) {
    _subscription = FlutterGamepad.eventStream.listen((event) {
      onControllerEvent(event, context);
    });
  }

  onControllerEvent(GamepadEvent event, BuildContext context) async {
    if (event is GamepadConnectedEvent) {
      _controllerText = "Controller connected\nPress X to continue";
      lookUp();
      await Future.delayed(Duration(milliseconds: 100));
      dance(true);
    }

    if (event is GamepadDisconnectedEvent) {
      _controllerText = "Connect controller to continue";
      lookUp();
      dance(false);
    }

    if (event is GamepadButtonEvent) {
      print(event.button);

      if (event.button == Button.a && event.pressed && !wolvie) {
        lookUp();
        await Future.delayed(Duration(seconds: 1));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Centaur()));
        wolvie = true;
        return;
      }

      if (event.button == Button.b && event.pressed && wolvie) {
        wolvie = false;
        Navigator.popUntil(context, (route) => route.isFirst);

      }

      if (event.button == Button.dpadLeft && event.pressed && wolvie) {
turnLeft();
      }

      if (event.button == Button.dpadRight && event.pressed && wolvie) {
        turnRight();
      }

      if (event.button == Button.leftShoulder && event.pressed && wolvie) {
       claw();
      }

      if (event.button == Button.rightShoulder && event.pressed && wolvie) {
        mouth();
      }
    }

    if (event is GamepadThumbstickEvent &&  wolvie) {
     if (event.thumbstick.index == 0) {
     if(event.x != 0.0) {
       walk(true);
     } else {
       walk(false);
     }
     }
    }
    notifyListeners();
  }

  lookUp() {
    lookUpAnim.isActive = true;
    notifyListeners();
  }

  idle(value) {
    idleAnim.isActive = value;
    notifyListeners();
  }

  dance(bool value) {
    danceAnim.isActive = value;
    notifyListeners();
  }

  walk(bool value) {
    walkAnim.isActive = value;
  }

  turnLeft() {
    turnLeftAnim.isActive = true;
  }

  turnRight() {
    turnRightAnim.isActive = true;
  }

  claw() {
    if(clawIn) {
      clawOutAnim.isActive = true;
      clawIn = false;
    } else {
      clawInAnim.isActive = true;

      clawIn = true;
    }
  }

  mouth() {
    if(mouthOpen) {
      mouthCloseAnim.isActive = true;
      mouthOpen = false;
    } else {

      mouthOpenAnim.isActive = true;
      // mouthCloseAnim.isActive = false;
      mouthOpen =true;
    }
  }

}
