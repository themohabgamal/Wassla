import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grad/core/helpers/constants/fonts/font_helper.dart';
import 'package:grad/core/theming/theme.dart';
import 'package:grad/presentation/settings/address/add_address_screen.dart';

class MyAddressesScreen extends StatefulWidget {
  const MyAddressesScreen({super.key});

  @override
  _MyAddressesScreenState createState() => _MyAddressesScreenState();
}

class _MyAddressesScreenState extends State<MyAddressesScreen> {
  late String _currentUserId;
  List<UserAddress> _userAddresses = [];

  @override
  void initState() {
    super.initState();
    _currentUserId = FirebaseAuth.instance.currentUser!.uid;
    _fetchUserAddresses();
  }

  Future<void> _fetchUserAddresses() async {
    try {
      final userAddressesSnapshot = await FirebaseFirestore.instance
          .collection('addresses')
          .doc(_currentUserId)
          .collection('user_addresses')
          .get();

      setState(() {
        _userAddresses = userAddressesSnapshot.docs.map((doc) {
          return UserAddress.fromMap(doc.data());
        }).toList();
      });
    } catch (error) {
      print('Error fetching user addresses: $error');
      // Handle error fetching user addresses
    }
  }

  void _addNewAddress() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddAddressScreen(),
      ),
    ).then((result) {
      if (result == true) {
        // If the user successfully added a new address, refresh the list of addresses
        _fetchUserAddresses();
      }
    });
  }

  void _selectAddress(UserAddress selectedAddress) async {
    try {
      final CollectionReference userAddressesRef = FirebaseFirestore.instance
          .collection('addresses')
          .doc(_currentUserId)
          .collection('user_addresses');

      // Fetch all user addresses
      final userAddressesSnapshot = await userAddressesRef.get();

      // Update the selected address status to "selected" in Firestore
      await userAddressesRef
          .doc(selectedAddress.address)
          .update({'status': 'selected'});

      // Update status of other addresses to "false"
      for (final doc in userAddressesSnapshot.docs) {
        if (doc.id != selectedAddress.address) {
          await userAddressesRef.doc(doc.id).update({'status': 'false'});
        }
      }
      // Show a confirmation message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: MyTheme.mainColor,
          content: Text(
            'Address selected successfully',
            style: FontHelper.poppins16Regular().copyWith(color: Colors.white),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
    } catch (error) {
      // Show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to select address. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Addresses'),
      ),
      body: ListView.builder(
        itemCount: _userAddresses.length,
        itemBuilder: (BuildContext context, int index) {
          final userAddress = _userAddresses[index];
          return Container(
            color: Colors.grey[200],
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
            child: ListTile(
              leading: const Icon(Icons.location_on),
              title: Text(userAddress.address),
              subtitle: Text('${userAddress.city}, ${userAddress.state}'),
              onTap: () {
                _selectAddress(userAddress);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyTheme.mainColor,
        onPressed: () {
          _addNewAddress();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class UserAddress {
  final String address;
  final String city;
  final String state;

  UserAddress({
    required this.address,
    required this.city,
    required this.state,
  });

  factory UserAddress.fromMap(Map<String, dynamic> map) {
    return UserAddress(
      address: map['address'],
      city: map['city'],
      state: map['state'],
    );
  }
}
