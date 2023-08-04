import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/features/cart/presentation/manager/cart_bloc.dart';
import 'package:learn_bloc/features/home/presentation/pages/home_page.dart';
import 'package:learn_bloc/features/wishlist/presentation/pages/wishlist_page.dart';

import '../../../home/presentation/manager/home_bloc.dart';
import '../widgets/cart_list_tile.dart';

///breaking down into steps while i do my cart here to understand the flow and how to make it more efficient
//todo 1: create a page and wrap ur scaffold with blocConsumer and also create an object of that bloc (cartBloc in this case as in line number 16)
///now the consumer is asking about 2 things 1 being listener and 2nd being the builder..builder is to change the states and listener is to listen to the events which may or maynot change the state of app
///next step is to add the possible events for this cart page..go to cart_event in manager directory
class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);
  static const String id = 'CartPage';
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();
//todo 10: creating a init state to call the initial event of cart
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      bloc:
          cartBloc, //todo 4: add the bloc which u'll use whom this consumer belongs to
      buildWhen: (previous, current) =>
          current is! CartActionableState, //todo 5:
      listenWhen: (previous, current) =>
          current is CartActionableState, //todo 6:
      //todo 7: add the actionable states in listener and what should happen when it's listened
      listener: (context, state) {
        if (state is CartNavigateToHomePageActionState) {
          Navigator.pop(context);
        } else if (state is CartNavigateToWishlistPageActionState) {
          Navigator.popAndPushNamed(context, Wishlist.id);
        }
        else if (state is CartRemovedItemActionState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item Removed from Cart")));
        }
      },
      builder: (context, state) {
        //todo 8: now for all the possible buildUI states add the ui widget tree to be displayed
        switch(state.runtimeType)
        {
          case CartLoadingState:
              return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios)),
                title: Text("Cart Page"),
                actions: [
                  IconButton(
                      onPressed: () {
                        cartBloc.add(CartNavigatetoWishlistBtnClickedEvent());
                      },
                      icon: Icon(Icons.favorite_border)),
                ],
              ),
              body:  Center(child:CircularProgressIndicator())
            );
          case CartSuccessfullyLoadedState:
            final successState= state as CartSuccessfullyLoadedState;
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.teal,
                  leading: IconButton(onPressed: (){
                    cartBloc.add(CartNavigatetoHomeBtnClickedEvent());
                  }, icon: Icon(Icons.arrow_back_ios)),
                  title: Text("Cart Page"),
                  actions: [
                    IconButton(
                        onPressed: () {
                          cartBloc.add(CartNavigatetoWishlistBtnClickedEvent());
                        },
                        icon: Icon(Icons.favorite_border)),
                  ],
                ),
                body:  ListView.builder(
                  itemCount: successState.cartItemsList.length,
                  //todo 14: paasing cartBloc param here
                  itemBuilder: (context, index)=> CartItemsListTile(productDataModel: successState.cartItemsList[index],cartBloc: cartBloc,),)
            );
          case CartErrorState:
              return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.teal,
              leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios)),
              title: Text("Cart Page"),
              actions: [
                IconButton(
                    onPressed: () {
                      cartBloc.add(CartNavigatetoWishlistBtnClickedEvent());
                    },
                    icon: Icon(Icons.favorite_border)),
              ],
            ),
            body: Center(child: Text("Error Occured"))
          );
          default: return Container();
        }
      },
    );
  }
}
