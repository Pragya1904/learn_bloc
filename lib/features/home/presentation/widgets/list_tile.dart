import 'package:flutter/material.dart';
import 'package:learn_bloc/core/model/product_model.dart';
import 'package:learn_bloc/features/home/presentation/manager/home_bloc.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({Key? key, required this.productDataModel, required this.homeBloc}) : super(key: key);
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(productDataModel.imageUrl))),
          ),
          Text(productDataModel.name,style: TextStyle(fontWeight: FontWeight.bold),),
          Text(productDataModel.description),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$${productDataModel.price}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeProductWishlistBtnClickedEvent(clickedProduct: productDataModel));
                      },
                      icon: Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeProductCartBtnClickedEvent(clickedProduct: productDataModel));
                      },
                      icon: Icon(Icons.shopping_cart_outlined)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
