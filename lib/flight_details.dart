import 'package:flutter/material.dart';
import 'package:airline_reservation_system/flight_book.dart';
class Flights_details extends StatefulWidget {
  final List<List<String>> journeys;

  const Flights_details({Key? key, required this.journeys}):super(key:key);

  @override
  State<Flights_details> createState() => _Flights_detailsState();
}

class _Flights_detailsState extends State<Flights_details> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: widget.journeys.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${widget.journeys[index][0]} to ${widget.journeys[index][1]}'),
            subtitle: Text('Date: ${widget.journeys[index][2]}, Passengers: ${widget.journeys[index][3]}'),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => flight_book(data: widget.journeys[index])),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
