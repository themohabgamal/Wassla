// ignore_for_file: must_be_immutable

import 'package:grad/business_logic/cart/bloc/cart_bloc.dart';
import 'package:grad/business_logic/home/bloc/home_bloc.dart';
import 'package:grad/models/category_response_model.dart';
import 'package:grad/presentation/cart/cart_screen.dart';
import 'package:grad/theming/theme.dart';
import 'package:flutter/material.dart';

class CartTileWidget extends StatefulWidget {
  CategoryResponseModel categoryResponseModel;
  CartBloc cartBloc;
  HomeBloc? homeBloc;

  CartTileWidget({
    super.key,
    required this.categoryResponseModel,
    required this.cartBloc,
    this.homeBloc,
  });

  @override
  State<CartTileWidget> createState() => _CartTileWidgetState();
}

class _CartTileWidgetState extends State<CartTileWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.cartBloc.add(GoToCartSingleProductEvent(
            categoryResponseModel: widget.categoryResponseModel));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 220,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).canvasColor),
        child: Row(
          children: [
            Image.network(
              "${widget.categoryResponseModel.image}",
              width: 80,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                Container(
                  child: Text(
                    "${categoryTitleBuilder(widget.categoryResponseModel.title)}",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Theme.of(context).textTheme.titleLarge?.color),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$ ${widget.categoryResponseModel.price.toString().length > 3 ? widget.categoryResponseModel.price.toString().substring(0, 3) : widget.categoryResponseModel.price.toString()}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color:
                                Theme.of(context).textTheme.titleLarge?.color),
                      ),
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            color: MyTheme.mainColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.categoryResponseModel.quantity =
                                      widget.categoryResponseModel.quantity! +
                                          1;
                                });
                                widget.cartBloc.add(Reload());
                              },
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${widget.categoryResponseModel.quantity}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.categoryResponseModel.quantity =
                                      widget.categoryResponseModel.quantity! -
                                          1;
                                });
                                widget.cartBloc.add(Reload());
                              },
                              child: const Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  String? categoryTitleBuilder(String? title) {
    if (title!.length > 30) {
      return title.substring(0, 30);
    } else {
      return title;
    }
  }
}
