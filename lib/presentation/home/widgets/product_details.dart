import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grad/presentation/home/widgets/search_product.dart';

class ProductDetailsScreen extends StatelessWidget {
  final SearchProduct product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 200.h,
                  child: CachedNetworkImage(
                    imageUrl: product.imageUrl,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                product.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Description: ${product.description}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text('Price: \$${product.price}',
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Text('Quantity: ${product.quantity}',
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
