import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<bool> add_flight(
    String flight_no,
    String pilot_1,
    String pilot_2,
    String pilot_3,
    String crew_1,
    String crew_2,
    String crew_3,
    DateTime date,
    String from,
    String to,
    int no_of_seats,
    double e_price,
    double b_price,
    double extra_baggage,
    String status,
    String? cancellation_reason) async {
  try {
    await FirebaseFirestore.instance.collection('flights').add({
      'flight_no': flight_no,
      'pilot_1': pilot_1,
      'pilot_2': pilot_2,
      'pilot_3': pilot_3,
      'crew_1': crew_1,
      'crew_2': crew_2,
      'crew_3': crew_3,
      'date': Timestamp.fromDate(date),
      'from': from,
      'to': to,
      'no_of_seats': no_of_seats,
      'e_price': e_price,
      'b_price': b_price,
      'extra_baggage': extra_baggage,
      'status': 'A',
      'cancellation_reason': null,
    });
    return true;
  } catch (e) {
    print('Error adding flight: $e');
    return false;
  }
}

Future<List<List<dynamic>>> find_flight(
    String from, String to, DateTime date, int passengers) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('flights')
        .where('from', isEqualTo: from)
        .where('to', isEqualTo: to)
        .where('date', isEqualTo: Timestamp.fromDate(date))
        .where('status', isEqualTo: 'A')
        .get();
    List<List<dynamic>> availableFlights = [];
    querySnapshot.docs.forEach((DocumentSnapshot doc) {
      String flightno = doc['flight_no'];
      DateTime flightdatetime = (doc['date'] as Timestamp).toDate();
      double costperperson = doc['e_price'] as double;
      int availableseats = doc['no_of_seats'] as int;
      if (passengers <= availableseats) {
        availableFlights.add([flightno, flightdatetime, costperperson]);
      }
    });
    return availableFlights;
  } catch (e) {
    print('Error finding flight: $e');
    return [];
  }
}

Future<String?> book_flight(
    String flight_no,
    TimeOfDay time,
    String meal_preference,
    double baggage,
    String seat_type,
    int no_of_seats,
    String customer_id) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('flights')
        .where('flight_no', isEqualTo: flight_no)
        .where('status', isEqualTo: 'A')
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot flightDoc = querySnapshot.docs.first;
      int availableSeats = flightDoc['no_of_seats'] as int;
      await flightDoc.reference
          .update({'no_of_seats': availableSeats - no_of_seats});
      String booking_id =
          FirebaseFirestore.instance.collection('bookings').doc().id;
      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(booking_id)
          .set({
        'booking_id': booking_id,
        'flight_no': flight_no,
        'time':
            Timestamp.fromDate(DateTime(2024, 1, 1, time.hour, time.minute)),
        'meal_preference': meal_preference,
        'baggage': baggage,
        'seat_type': seat_type,
        'no_of_seats': no_of_seats,
        'booked_by': customer_id
      });
      return booking_id;
    } else {
      print('Flight not found.');
      return null;
    }
  } catch (e) {
    print('Error booking flight: $e');
    return null;
  }
}

Future<List<List<dynamic>>> get_history(String customer_id) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('bookings')
        .where('booked_by', isEqualTo: customer_id)
        .get();
    List<List<dynamic>> bookingHistory = [];
    for (DocumentSnapshot doc in querySnapshot.docs) {
      String flight_no = doc['flight_no'];
      Timestamp timeStamp = doc['time'];
      TimeOfDay time = TimeOfDay.fromDateTime(timeStamp.toDate());
      String meal_preference = doc['meal_preference'];
      double baggage = doc['baggage'];
      double no_of_seats = doc['no_of_seats'];
      String seat_type = doc['seat_type'];
      QuerySnapshot employeeSnapshot = await FirebaseFirestore.instance
          .collection('employees')
          .where('customer_id', isEqualTo: customer_id)
          .get();
      String booked_by_name = employeeSnapshot.docs.isNotEmpty
          ? employeeSnapshot.docs.first['name']
          : 'Unknown';
      String status = doc['status'] ?? '';
      bookingHistory.add([
        flight_no,
        time,
        meal_preference,
        baggage,
        seat_type,
        status,
        no_of_seats,
        booked_by_name
      ]);
    }
    return bookingHistory;
  } catch (e) {
    print('Error getting booking history: $e');
    return [];
  }
}

Future<String?> add_employee(
    String email,
    String password,
    String name,
    DateTime dob,
    String gender,
    String role,
    double salary,
    String address,
    String home_station) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('employees')
        .where('email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return "error";
    } else {
      String employee_id =
          FirebaseFirestore.instance.collection('employees').doc().id;
      await FirebaseFirestore.instance
          .collection('employees')
          .doc(employee_id)
          .set({
        'employee_id': employee_id,
        'email': email,
        'password': password,
        'name': name,
        'dob': Timestamp.fromDate(dob),
        'gender': gender,
        'role': role,
        'salary': salary,
        'address': address,
        'home_station': home_station,
      });
      return employee_id;
    }
  } catch (e) {
    print('Error adding employee: $e');
    return null;
  }
}

Future<Map<String, dynamic>> edit_employee(String employee_id) async {
  try {
    DocumentSnapshot employeeDoc = await FirebaseFirestore.instance
        .collection('employees')
        .doc(employee_id)
        .get();
    if (employeeDoc.exists) {
      String name = employeeDoc['name'];
      String email = employeeDoc['email'];
      String password = employeeDoc['password'];
      Timestamp dobTimestamp = employeeDoc['dob'];
      DateTime dob = dobTimestamp.toDate();
      String gender = employeeDoc['gender'];
      String role = employeeDoc['role'];
      double salary = employeeDoc['salary'];
      String address = employeeDoc['address'];
      String home_station = employeeDoc['home_station'];

      Map<String, dynamic> employeeDetails = {
        'employee_id': employee_id,
        'email': email,
        'password': password,
        'name': name,
        'dob': dob,
        'gender': gender,
        'role': role,
        'salary': salary,
        'address': address,
        'home_station': home_station,
      };
      await FirebaseFirestore.instance
          .collection('employees')
          .doc(employee_id)
          .update(employeeDetails);
      return employeeDetails;
    } else {
      print('Employee with ID $employee_id does not exist.');
      return {'error': 'Employee not found'};
    }
  } catch (e) {
    print('Error editing employee: $e');
    return {'error': 'Error editing employee'};
  }
}

Future<String?> add_customer(String email, String password, String name,
    DateTime dob, String gender, String address, String home_station) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('customers')
        .where('email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return "error";
    } else {
      String customer_id =
          FirebaseFirestore.instance.collection('customers').doc().id;
      await FirebaseFirestore.instance
          .collection('customers')
          .doc(customer_id)
          .set({
        'customer_id': customer_id,
        'email': email,
        'password': password,
        'name': name,
        'dob': Timestamp.fromDate(dob),
        'gender': gender,
        'address': address,
        'home_station': home_station,
      });
      return customer_id;
    }
  } catch (e) {
    print('Error adding customer: $e');
    return null;
  }
}

Future<Map<String, dynamic>> edit_customer(String customer_id) async {
  try {
    DocumentSnapshot customerDoc = await FirebaseFirestore.instance
        .collection('customers')
        .doc(customer_id)
        .get();
    if (customerDoc.exists) {
      String name = customerDoc['name'];
      String email = customerDoc['email'];
      String password = customerDoc['password'];
      Timestamp dobTimestamp = customerDoc['dob'];
      DateTime dob = dobTimestamp.toDate();
      String gender = customerDoc['gender'];
      String address = customerDoc['address'];
      String home_station = customerDoc['home_station'];

      Map<String, dynamic> customerDetails = {
        'customer_id': customer_id,
        'email': email,
        'password': password,
        'name': name,
        'dob': dob,
        'gender': gender,
        'address': address,
        'home_station': home_station,
      };
      await FirebaseFirestore.instance
          .collection('customers')
          .doc(customer_id)
          .update(customerDetails);
      return customerDetails;
    } else {
      print('Customer with ID $customer_id does not exist.');
      return {'error': 'Customer not found'};
    }
  } catch (e) {
    print('Error editing customer: $e');
    return {'error': 'Error editing customer'};
  }
}

Future<bool> cancel_flight(
    String flight_no, TimeOfDay time, String reason) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('flights')
        .where('flight_no', isEqualTo: flight_no)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      await querySnapshot.docs.first.reference.update({
        'status': 'C',
        'cancellation_reason': reason,
      });
      return true;
    } else {
      print('Flight not found.');
      return false;
    }
  } catch (e) {
    print('Error cancelling flight: $e');
    return false;
  }
}

Future<String?> signin_customer(String email, String password) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('customers')
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first['customer_id'];
    } else {
      return null;
    }
  } catch (e) {
    print('Error signing in: $e');
    return null;
  }
}

Future<String?> signin_employee(String email, String password) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('employees')
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first['employee_id'];
    } else {
      return null;
    }
  } catch (e) {
    print('Error signing in: $e');
    return null;
  }
}

Future<String?> signin_admin(String email, String password) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('admins')
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first['admin_id'];
    } else {
      return null;
    }
  } catch (e) {
    print('Error signing in: $e');
    return null;
  }
}

Future<String?> add_admin(String email, String password, String name) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('admins')
        .where('email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return "error";
    } else {
      String admin_id =
          FirebaseFirestore.instance.collection('admins').doc().id;
      await FirebaseFirestore.instance.collection('admins').doc(admin_id).set({
        'admin_id': admin_id,
        'email': email,
        'password': password,
        'name': name,
      });
      return admin_id;
    }
  } catch (e) {
    print('Error adding customer: $e');
    return null;
  }
}

Future<Map<String, dynamic>> edit_admin(String admin_id) async {
  try {
    DocumentSnapshot adminDoc = await FirebaseFirestore.instance
        .collection('admins')
        .doc(admin_id)
        .get();
    if (adminDoc.exists) {
      String name = adminDoc['name'];
      String email = adminDoc['email'];
      String password = adminDoc['password'];

      Map<String, dynamic> adminDetails = {
        'admin_id': admin_id,
        'email': email,
        'password': password,
        'name': name,
      };
      await FirebaseFirestore.instance
          .collection('admins')
          .doc(admin_id)
          .update(adminDetails);
      return adminDetails;
    } else {
      print('Customer with ID $admin_id does not exist.');
      return {'error': 'Customer not found'};
    }
  } catch (e) {
    print('Error editing customer: $e');
    return {'error': 'Error editing customer'};
  }
}
