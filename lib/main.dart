import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.teal),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  //the listener for the animation. Can perform animation related actions here
  void animListener(status) {
    if (status == AnimationStatus.completed) {
      _animation.removeStatusListener(animListener);
      _animationController.reset();
      _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _animationController, curve: Curves.fastOutSlowIn));
      _animationController.forward();
    }
  }

  //sets up animation and controllers with their values
  void setsAnimationLeftToRight() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 4));

    _animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn))
      ..addStatusListener(animListener);
  }

  //starting the animation on init state
  @override
  void initState() {
    super.initState();
    setsAnimationLeftToRight();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    //gets the width of the screen
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Ease-in animation"),
      ),
      //AnimatedBuilder widget used to animate a widget
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) => Transform(
          //transform helps us move the container along the horizontal axis
          transform:
                  Matrix4.translationValues(_animation.value * width, 0.0, 0.0),
              child: Center(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Text("Sample text"),
                      RaisedButton(
                        child: Text("Samplem button"),
                        onPressed: null,
                      )
                    ],
                  ),
                  height: 200,
                  width: 200,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
      ),
    );
  }
}
