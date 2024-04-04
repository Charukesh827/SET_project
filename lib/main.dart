import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:airline_reservation_system/SkylineHomePage.dart';
void main() {
  runApp(SkylineApp());
}

class SkylineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skyline',
      theme: ThemeData(
        primarySwatch: Colors.red, // Changed theme to red
      ),
      home: Home_page(),
    );
  }
}

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  @override
  Widget build(BuildContext context) {
    var selectedIndex=0;
    Widget page=SkylineHomePage();

    switch(selectedIndex){
      case 0:
        page=SkylineHomePage();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('SKYLINE'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification button tap
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('You have new notifications!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: page,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.airplanemode_active),
              onPressed: () {
                selectedIndex=0;
              },
            ),
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckInPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.assignment),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookingsPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BookFlightPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Flight'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Find Your Flight',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title: Text('One-way'),
                    value: 'One-way',
                    groupValue: null,
                    onChanged: null,
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: Text('Round Trip'),
                    value: 'Round Trip',
                    groupValue: null,
                    onChanged: null,
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: Text('Multi-city'),
                    value: 'Multi-city',
                    groupValue: null,
                    onChanged: null,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'From',
                hintText: 'Enter origin',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) {},
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'To',
                hintText: 'Enter destination',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) {},
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Departure Date',
                      hintText: 'Select date',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onTap: () async {},
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Passengers',
                      hintText: 'Select count',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('Search Flights'),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Check-in'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Check-in for Your Flight',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Select Airline',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: [
                '1A',
                '2A',
                '3A',
                '4A',
                '5A',
                '6A',
                '7A',
                '8A',
                '9A',
                '1B',
                '2B',
                '3B',
                '4B',
                '5B',
                '6B',
                '7B',
                '8B',
                '9B',
                '1C',
                '2C',
                '3C',
                '4C',
                '5C',
                '6C',
                '7C',
                '8C',
                '9C',
                '1D',
                '2D',
                '3D',
                '4D',
                '5D',
                '6D',
                '7D',
                '8D',
                '9D',
                '1E',
                '2E',
                '3E',
                '4E',
                '5E',
                '6E',
                '7E',
                '8E',
                '9E',
              ].map((airline) {
                return DropdownMenuItem(
                  value: airline,
                  child: Text(airline),
                );
              }).toList(),
              onChanged: (value) {
                // Handle airline selection
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Booking Ref/PNR',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Booking Ref/PNR';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email/Lastname',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Email/Lastname';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle submit button tap
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class BookingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bookings'),
      ),
      body: Center(
        child: Text('My Bookings Page'),
      ),
    );
  }
}
