import 'package:flutter/material.dart';
class flight_book extends StatefulWidget {
  final List<String> data;
  const flight_book({Key? key, required this.data}):super(key:key);

  @override
  State<flight_book> createState() => _flight_bookState();
}

class _flight_bookState extends State<flight_book> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const Text('${widget.data[0]} to ${widget.data[1]}')
    );
  }
}
