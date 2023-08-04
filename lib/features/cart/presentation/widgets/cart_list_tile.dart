import 'package:flutter/material.dart';

import '../../../../core/model/product_model.dart';
import '../manager/cart_bloc.dart';

class CartItemsListTile extends StatelessWidget {
  CartItemsListTile({Key? key, required this.productDataModel, required this.cartBloc}) : super(key: key);
  final ProductDataModel productDataModel;
  //todo 13: adding cartBloc
  final CartBloc cartBloc;
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
                  //todo 12: we have to add the functionality to remove the item from the cart list
                  ///for that first let us call cartBloc here as required param
                  IconButton(
                      onPressed: () {
                        //todo 15: call the event which is triggered (remove the item from cart)
                        ///mention which item to be removed using "productDataModel" and add this in ur event class as required field
                       cartBloc.add(CartRemovefromCartBtnClickedEvent(clickedProduct: productDataModel));
                      },
                      icon: Icon(Icons.shopping_cart)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
