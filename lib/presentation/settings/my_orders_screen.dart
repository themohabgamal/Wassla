import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad/core/helpers/constants/fonts/font_helper.dart';
import 'package:intl/intl.dart';

class MyOrdersScreen extends StatelessWidget {
  static const String routeName = 'myorders';
  MyOrdersScreen({super.key});
  String uId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: FontHelper.poppins20Bold(),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('userId', isEqualTo: uId)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No orders found.'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> orderData =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              String timestampString = orderData[
                  'timestamp']; // Assuming orderData['timestamp'] is the string "23/04/2024 at 12:18 PM"

// Split the string into date and time parts
              List<String> parts = timestampString.split(' at ');
              String dateString = parts[0]; // "23/04/2024"
              String timeString = parts[1]; // "12:18 PM"

// Parse the date and time strings separately
              DateTime dateTime = DateFormat('dd/MM/yyyy hh:mm a')
                  .parse('$dateString $timeString');

              var order = Order(
                userId: orderData['userId'],
                firstName: orderData['firstName'],
                lastName: orderData['lastName'],
                phone: orderData['phone'],
                items: orderData['items'],
                address: orderData['address'],
                timestamp:
                    dateTime, // Assign the DateTime object, not the formatted string
              );
              return buildOrderTile(order, index);
            },
          );
        },
      ),
    );
  }
}

class Order {
  final String userId;
  final String firstName;
  final String lastName;
  final String phone;
  final List<dynamic> items;
  final String address;
  final DateTime timestamp;

  Order({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.items,
    required this.address,
    required this.timestamp,
  });
}

Widget buildOrderTile(Order order, int index) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.grey[200], // Background color
      borderRadius: BorderRadius.circular(12.0), // Rounded corners
    ),
    child: ListTile(
      title: Text(
        'Order ${index + 1}',
        style: FontHelper.poppins16Bold(),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Timestamp: ${DateFormat('dd/MM/yyyy \'at\' hh:mm a').format(order.timestamp)}'),
          Text('Customer: ${order.firstName} ${order.lastName}'),
          Text('Phone: ${order.phone}'),
          Text('Address: ${order.address}'),
          // You can include more details here as needed
        ],
      ),
    ),
  );
}
