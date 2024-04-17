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
      appBar: AppBar(
        title: Center(child: Text("SKYLINE")),
        backgroundColor: Colors.blue,
      ),
      body: ListView.separated(
        itemCount: widget.journeys.length,
        separatorBuilder: (context, index) => Divider(
          height: 20,
        ),
        itemBuilder: (context, index) {
          final journey = widget.journeys[index];
          return ListTile(
            leading: Icon(Icons.airplane_ticket_outlined),
            title: Row(
              children: [
                Spacer(flex: 1,),
                Text('Flight Number: ${journey[0]}'),
                Spacer(flex: 2,),
                Text('₹${journey[4]}'),
                Spacer(flex: 1,)
              ],
            ),
            trailing: IconButton(icon: Icon(Icons.arrow_forward),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => flight_book(data: journey,)),
                );
              },
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Row(
                  children: [
                    Spacer(flex: 1,),
                    Text('${journey[1]}'),
                    Spacer(flex: 1,),
                    Icon(Icons.arrow_forward_ios),
                    Spacer(flex: 1,),
                    Text('${journey[3]}'),
                    Spacer(flex: 1,),
                    Icon(Icons.arrow_forward_ios),
                    Spacer(flex: 1,),
                    Text('${journey[2]}'),
                    Spacer(flex: 1,),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Spacer(flex: 1,),
                    Text('Date: ${journey[5]}'),
                    Spacer(flex: 2,),
                    Text('Time: ${journey[6]}'),
                    Spacer(flex: 1,)
                  ],
                ),
              ],
            ),
          );
        },
      )
    );
  }
}

/*Flight({
    required this.flightNumber,
    required this.fromPlace,
    required this.toPlace,
    required this.travelTime,
    required this.ticketFare,
    required this.date,
    required this.time,
  });*/
