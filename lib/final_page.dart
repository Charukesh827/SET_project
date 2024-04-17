import 'package:flutter/material.dart';
import 'dart:async';
class final_page extends StatelessWidget {
  final bool state;
  // const flight_book({Key? key, required this.data}):super(key:key);
  const final_page({required this.state});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: (true)? successPage(): failurePage(),
      home: successPage(),
    );
  }
}

class successPage extends StatefulWidget {
  @override
  _successPageState createState() => _successPageState();
}

class _successPageState extends State<successPage> {
  late final Timer timer;
  final images = ['assets/images/infinity_flight.gif', 'assets/images/success.gif'];
  int _index = 0;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if(_index==3){
        Navigator.pop(context);
      }
      setState(() => _index++);
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: Image.asset(
            images[_index % images.length],
            key: UniqueKey(),
          ),
        ),
      ),
    );
  }
}
