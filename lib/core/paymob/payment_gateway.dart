import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:grad/core/helpers/constants/fonts/font_helper.dart';
import 'package:grad/presentation/settings/address/my_addresses_screen.dart';
import 'package:grad/widgets/alert.dart';
import 'package:intl/intl.dart';

class PaymentGateway extends StatefulWidget {
  final String paymentToken;
  final UserAddress address;
  const PaymentGateway(
      {super.key, required this.paymentToken, required this.address});

  @override
  State<PaymentGateway> createState() => _PaymentGatewayState();
}

class _PaymentGatewayState extends State<PaymentGateway> {
  InAppWebViewController? _webViewController;

  @override
  void initState() {
    super.initState();
    // Start the payment process when the screen is initialized
    startPayment();
  }

  void startPayment() {
    // Load the payment URL with the provided payment token
    _webViewController?.loadUrl(
      urlRequest: URLRequest(
        url: Uri.parse(
          'https://accept.paymob.com/api/acceptance/iframes/832300?payment_token=${widget.paymentToken}',
        ),
      ),
    );
  }

  String formattedDateTime(DateTime dateTime) {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    DateFormat timeFormat = DateFormat('hh:mm a');

    String datePart = dateFormat.format(dateTime);
    String timePart = timeFormat.format(dateTime);

    return '$datePart at $timePart';
  }

  Future<void> handlePaymentSuccess() async {
    try {
      // 1. Retrieve cart items for the current user
      String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> cartSnapshot =
          await FirebaseFirestore.instance
              .collection('carts')
              .doc(userId)
              .get();

      // 2. Retrieve user document
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();

      // 3. Create a new document in the "orders" collection with the user's UID as the document ID
      CollectionReference ordersCollection =
          FirebaseFirestore.instance.collection('orders');
      await ordersCollection.doc(userId).set({
        'userId': userId,
        'firstName': userSnapshot['firstName'],
        'lastName': userSnapshot['lastName'],
        'phone': userSnapshot['phone'],
        'items': cartSnapshot.data()!['products'],
        'address':
            '${widget.address.address}, ${widget.address.city}, ${widget.address.state}',
        'timestamp': formattedDateTime(DateTime.now()),
      });

      // 4. Optionally, delete the cart items from the "carts" collection
      await FirebaseFirestore.instance.collection('carts').doc(userId).delete();

      // Handle any other actions needed after successful payment
      Alert.showAlert(
        context: context,
        isLoading: false,
        text: 'Order placed successfully!',
        animation: 'asset/animations/order-placed.json',
        onContinue: () {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        },
      );
      print('Order placed successfully!');
    } catch (error) {
      Alert.showAlert(
          context: context,
          isLoading: false,
          text: 'Could not place order. Please try again.',
          animation: 'asset/animations/error.json',
          onContinue: () {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          });
      print('Error handling payment success: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: InAppWebView(
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            javaScriptEnabled: true,
          ),
        ),
        onWebViewCreated: (controller) {
          _webViewController = controller;
          // Start the payment process when the WebView is created
          startPayment();
        },
        onLoadStop: (controller, url) {
          if (url != null &&
              url.queryParameters.containsKey('success') &&
              url.queryParameters['success'] == 'true') {
            // Payment success logic
            print("success");
            handlePaymentSuccess();
          } else if (url != null &&
              url.queryParameters.containsKey('success') &&
              url.queryParameters['success'] == 'false') {
            // Payment failed logic
            print("failed");
          }
        },
      ),
    );
  }
}
