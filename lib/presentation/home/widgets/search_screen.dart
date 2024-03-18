import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grad/core/helpers/constants/fonts/font_helper.dart';
import 'package:grad/models/category_response_model.dart';
import 'package:grad/widgets/category_tile_widget.dart';
import 'package:grad/widgets/single_product_page.dart';
import 'package:iconly/iconly.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            setState(() {
              searchText = value;
            });
          },
          decoration: const InputDecoration(
            hintText: 'Enter Product Name',
            suffixIcon: Icon(Icons.search), // Icon before the input field
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
                vertical: 15.0, horizontal: 10.0), // Padding inside the field
          ),
        ),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collectionGroup('products').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print("Error: ${snapshot.error}");
            return Text("Error: ${snapshot.error}");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Check if search text is empty
          if (searchText.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    IconlyLight.search,
                    size: 50,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Start searching for products",
                    style: FontHelper.poppins18Regular()
                        .copyWith(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No data available"),
            );
          }

          final List<DocumentSnapshot> filteredDocs =
              snapshot.data!.docs.where((doc) {
            final title = (doc.data() as Map<String, dynamic>)['title'] ?? '';
            return title.toLowerCase().contains(searchText.toLowerCase());
          }).toList();

          return GridView.builder(
            padding: const EdgeInsets.all(15),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // You can adjust the number of columns here
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 6 / 9,
            ),
            itemCount: filteredDocs.length,
            itemBuilder: (context, index) {
              final data = filteredDocs[index].data() as Map<String, dynamic>;

              return GestureDetector(
                onTap: () {
                  print("navigate");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SingleProductPage(
                          categoryResponseModel:
                              CategoryResponseModel.fromJson(data))));
                },
                child: CategoryTileWidget(
                  categoryResponseModel: CategoryResponseModel.fromJson(data),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
