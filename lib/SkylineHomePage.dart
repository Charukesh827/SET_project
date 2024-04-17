
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:airline_reservation_system/flight_details.dart';
class SkylineHomePage extends StatefulWidget {
  @override
  _SkylineHomePageState createState() => _SkylineHomePageState();
}

class _SkylineHomePageState extends State<SkylineHomePage> {
  String _origin = '';
  String _destination = '';
  DateTime _departureDate = DateTime.now();
  int _passengerCount = 1;
  String _tripType = 'One-way'; // Default trip type
  DateTime _selectedDate=DateTime.now().add(const Duration(days: 1));
  int? selectedOption = 1;
  final List<List<String>> journeys = [
    ['FL123', 'New York', 'London', '7 hours', '500.00', '2024-04-05', '10:00'],
    ['FL456', 'London', 'Paris', '1 hour', '100.00', '2024-04-06', '15:00'],
    ['FL789', 'Paris', 'Tokyo', '12 hours', '750.00', '2024-04-07', '20:00'],
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)), // Tomorrow or later
      lastDate: DateTime(2030), // Limit to a reasonable future year
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _searchFlights() {
    // Implement flight search logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Find Your Flight',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'From',
                hintText: 'Enter origin',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _origin = value;
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'To',
                hintText: 'Enter destination',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _destination = value;
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              readOnly: true, // Prevent keyboard from appearing
              controller: TextEditingController(
                text: _selectedDate != null ? DateFormat("dd-MM-yyyy").format(_selectedDate)
                    : '', // Format the selected date
              ),
              decoration: InputDecoration(
                labelText: 'Select a future date',
                hintText: 'Tap to choose a date',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onTap: () {
                print("Tapped");
                _selectDate(context);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a date';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Expanded(child: Text("Enter number of passengers: ")),
                DropdownButton<int>(
                  value: selectedOption,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedOption = newValue;
                    });
                  },
                  items: List.generate(6, (index) {
                    return DropdownMenuItem<int>(
                      value: index + 1,
                      child: Text('${index + 1}'),
                    );
                  }),
                ),
                const Spacer(flex: 2,),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  //TODO: get the array and pass to journeys
                  MaterialPageRoute(builder: (context) => Flights_details(journeys: journeys,)),
                );
              },
              child: const Text('Search Flights'),
            ),
          ),
        ],
      ),
    );
  }
}

/*
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title: Text('One-way'),
                    value: 'One-way',
                    groupValue: _tripType,
                    onChanged: (value) {
                      setState(() {
                        _tripType = value as String;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: Text('Round Trip'),
                    value: 'Round Trip',
                    groupValue: _tripType,
                    onChanged: (value) {
                      setState(() {
                        _tripType = value as String;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: Text('Multi-city'),
                    value: 'Multi-city',
                    groupValue: _tripType,
                    onChanged: (value) {
                      setState(() {
                        _tripType = value as String;
                      });
                    },
                  ),
                ),
              ],
            ),
             */
