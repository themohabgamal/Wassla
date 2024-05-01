import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad/core/widgets/my_button.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final TextEditingController _addressController = TextEditingController();
  String? _selectedGovernorate;
  String? _selectedCity;

  List<Map<String, dynamic>> governorates = [];

  @override
  void initState() {
    super.initState();
    loadGovernorates();
  }

  Future<void> loadGovernorates() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/governorates_cities.json');
    Map<String, dynamic> data = json.decode(jsonString);
    setState(() {
      governorates = List<Map<String, dynamic>>.from(data['governorates']);
    });
  }

  void _saveAddress() async {
    final String address = _addressController.text.trim();

    // Check if address, governorate, and city are not null
    if (address.isNotEmpty &&
        _selectedGovernorate != null &&
        _selectedCity != null) {
      try {
        await FirebaseFirestore.instance
            .collection('addresses')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('user_addresses')
            .doc(address)
            .set({
          'address': address,
          'governorate': _selectedGovernorate!,
          'city': _selectedCity!,
        });

        // Navigate back to the previous screen with a success result
        Navigator.pop(context, true);
      } catch (error) {
        print(error.toString());
        // Handle error saving address
      }
    } else {
      // Show error message if any of the fields are empty
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please fill in all fields.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedGovernorate,
              hint: const Text('Select Governorate'),
              items: governorates.map((governorate) {
                return DropdownMenuItem<String>(
                  value: governorate['name'],
                  child: Text(governorate['name']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGovernorate = value!;
                  _selectedCity = null; // Reset city when governorate changes
                });
              },
            ),
            const SizedBox(height: 16.0),
            if (_selectedGovernorate != null)
              DropdownButtonFormField<String>(
                value: _selectedCity,
                hint: const Text('Select City'),
                items: governorates
                    .firstWhere((governorate) =>
                        governorate['name'] == _selectedGovernorate)['cities']
                    .map<DropdownMenuItem<String>>((city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCity = value!;
                  });
                },
              ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            const SizedBox(height: 16.0),
            MyButton(text: 'Save', onPressed: _saveAddress),
          ],
        ),
      ),
    );
  }
}
