import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../styles/styles.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin{

  @override
  dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,)..repeat();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: backgroundStyle,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                child: Image.asset("assets/oliware_transparent_icon.png", fit: BoxFit.contain, height: 140,),
                builder: (BuildContext context, Widget? child){
                  return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi,
                    child: child,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("CARGANDO...", style: textWhiteSubTitle,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
