import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grad/core/helpers/constants/fonts/font_helper.dart';
import 'package:grad/core/paymob/payment_gateway.dart';
import 'package:grad/core/paymob/paymob_manager.dart';
import 'package:grad/core/theming/theme.dart';
import 'package:grad/presentation/settings/address/add_address_screen.dart';
import 'package:iconly/iconly.dart';

class MyAddressesScreen extends StatefulWidget {
  final num totalPrice;
  const MyAddressesScreen({super.key, required this.totalPrice});

  @override
  MyAddressesScreenState createState() => MyAddressesScreenState();
}

class MyAddressesScreenState extends State<MyAddressesScreen> {
  late String _currentUserId;
  List<UserAddress> _userAddresses = [];
  UserAddress? _selectedAddress;

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
      log(error.toString());
      // Handle error fetching user addresses
    }
  }

  void _selectAddress(UserAddress selectedAddress) {
    setState(() {
      _selectedAddress = selectedAddress;
    });
  }

  void _continueToPayment() {
    if (_selectedAddress != null) {
      PaymobManager()
          .getPaymentKey(widget.totalPrice.toInt())
          .then((paymentKey) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentGateway(
              paymentToken: paymentKey,
              address: _selectedAddress!,
            ),
          ),
        );
      });
    } else {
      // Show a message to select an address before continuing to payment
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Please select an address before continuing to payment.'),
          duration: Duration(seconds: 2),
        ),
      );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Addresses',
          style: FontHelper.poppins16Bold(),
        ),
      ),
      body: _userAddresses.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(IconlyLight.discount, size: 60),
                  Text(
                    'No addresses found \n Please add a new address.',
                    style: FontHelper.poppins16Regular(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _userAddresses.length,
              itemBuilder: (BuildContext context, int index) {
                final userAddress = _userAddresses[index];
                return Container(
                  color: _selectedAddress == userAddress
                      ? MyTheme.mainColor
                      : Colors.grey[200],
                  margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                  child: ListTile(
                    leading: const Icon(Icons.location_on),
                    title: Text(userAddress.address),
                    subtitle:
                        Text('${userAddress.city}, ${userAddress.governorate}'),
                    onTap: () {
                      _selectAddress(userAddress);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: _selectedAddress != null
          ? SizedBox(
              width: 100, // Adjust the width according to your preference
              child: FloatingActionButton(
                backgroundColor: MyTheme.mainColor,
                onPressed: () {
                  _continueToPayment();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Pay",
                      style: FontHelper.poppins18Bold()
                          .copyWith(color: Colors.white),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    const Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              ),
            )
          : FloatingActionButton(
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
  final String governorate;
  final String city;

  UserAddress({
    required this.address,
    required this.governorate,
    required this.city,
  });

  factory UserAddress.fromMap(Map<String, dynamic> map) {
    return UserAddress(
      address: map['address'] ?? '',
      governorate: map['governorate'] ?? '',
      city: map['city'] ?? '',
    );
  }
}
