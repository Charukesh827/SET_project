import 'package:flutter/material.dart';
import 'package:airline_reservation_system/final_page.dart';
class flight_book extends StatefulWidget {
  final List<String> data;
  // const flight_book({Key? key, required this.data}):super(key:key);
  const flight_book({required this.data});
  @override
  State<flight_book> createState() => _flight_bookState();
}

class _flight_bookState extends State<flight_book> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String age = '';
  String gender = '';
  String passportNumber = '';
  String mealPreference = '';
  String extraBaggage = '';
  String seatType = '';
  String flightClass = '';
  List<String> journey=[];
  bool state=false;
  @override
  Widget build(BuildContext context) {
    journey=widget.data;
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListTile(
                  tileColor: Colors.lightBlue,
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
                ),
              ),
              Container(
                margin: EdgeInsets.all(50.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueAccent,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Name'),
                          onSaved: (value) => name = value!,
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Age'),
                          onSaved: (value) => age = value!,
                        ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(labelText: 'Gender'),
                          items: ['Male', 'Female', 'Other'].map((gender) {
                            return DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            );
                          }).toList(),
                          onChanged: (value) => setState(() => gender = value.toString()),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Passport Number'),
                          onSaved: (value) => passportNumber = value!,
                        ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(labelText: 'Meal Preference'),
                          items: ['Veg', 'Non-Veg', 'Vegan', 'Jain'].map((meal) {
                            return DropdownMenuItem(
                              value: meal,
                              child: Text(meal),
                            );
                          }).toList(),
                          onChanged: (value) => setState(() => mealPreference = value.toString()),
                        ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(labelText: 'Extra Baggage'),
                          items: ['5kg' , '10kg' , '15kg'].map((bag) {
                            return DropdownMenuItem(
                              value: bag,
                              child: Text(bag),
                            );
                          }).toList(),
                          onChanged: (value) => setState(() => extraBaggage = value.toString()),
                        ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(labelText: 'Seat Type'),
                          items: ['Window', 'Middle', 'Aisle'].map((seat) {
                            return DropdownMenuItem(
                              value: seat,
                              child: Text(seat),
                            );
                          }).toList(),
                          onChanged: (value) => setState(() => seatType = value.toString()),
                        ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(labelText: 'Class'),
                          items: ['Economy', 'Business'].map((flightClass) {
                            return DropdownMenuItem(
                              value: flightClass,
                              child: Text(flightClass),
                            );
                          }).toList(),
                          onChanged: (value) => setState(() => flightClass = value.toString()),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              //TODO:save form to DB
                              // Handle form submission
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => final_page(state: state,)),
                              );
                            }
                          },
                          child: Text('Book now!'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
