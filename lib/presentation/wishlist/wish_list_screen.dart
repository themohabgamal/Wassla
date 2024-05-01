import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grad/core/helpers/constants/fonts/font_helper.dart';
import 'package:grad/models/category_response_model.dart';
import 'package:grad/models/hot_deal_model.dart';
import 'package:grad/widgets/alert.dart';
import 'package:lottie/lottie.dart';

class WishListScreen extends StatelessWidget {
  static const String routeName = 'wishlist';
  final String userId;

  const WishListScreen({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          "Wishlist",
          style: FontHelper.poppins24Bold(),
        ),
        centerTitle: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('wishlist')
            .doc(userId)
            .collection('items')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            List<DocumentSnapshot> documents = snapshot.data!.docs;
            if (documents.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LottieBuilder.asset('assets/animations/sad.json'),
                    SizedBox(height: 20.h),
                    Text(
                      'No items in wishlist yet',
                      style: FontHelper.poppins14Regular(),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  var itemData =
                      documents[index].data() as Map<String, dynamic>;

                  if (itemData.containsKey('discounted_price')) {
                    // Treat as HotDealModel
                    HotDealModel hotDealModel = HotDealModel.fromJson(itemData);
                    return buildListTile(
                      imageUrl: hotDealModel.image,
                      title: hotDealModel.title,
                      price: hotDealModel.discountedPrice.toString(),
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('wishlist')
                            .doc(userId)
                            .collection('items')
                            .doc(documents[index].id)
                            .delete();
                      },
                    );
                  } else {
                    // Treat as CategoryResponseModel
                    CategoryResponseModel categoryResponseModel =
                        CategoryResponseModel.fromJson(itemData);
                    return buildListTile(
                      imageUrl: categoryResponseModel.image ?? '',
                      title: categoryResponseModel.title ?? '',
                      price: categoryResponseModel.price.toString(),
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('wishlist')
                            .doc(userId)
                            .collection('items')
                            .doc(documents[index].id)
                            .delete();
                      },
                    );
                  }
                },
              );
            }
          } else {
            return const SizedBox(); // Placeholder widget
          }
        },
      ),
    );
  }

  Widget buildListTile({
    required String imageUrl,
    required String title,
    required String price,
    required VoidCallback onPressed,
  }) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 50,
      ),
      title: Text(title),
      subtitle: Text('Price: $price EGP'),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onPressed,
      ),
    );
  }
}
