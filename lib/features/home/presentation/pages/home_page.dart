import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/features/wishlist/presentation/pages/wishlist_page.dart';

import '../../../cart/presentation/pages/cart_page.dart';
import '../manager/home_bloc.dart';
import '../widgets/list_tile.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  static const String id='HomePage';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homebloc = HomeBloc();
  @override
  void initState() {
    // TODO: implement initState
    homebloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homebloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.pushNamed(context, Wishlist.id);
        } else if (state is HomeNavigateToCartPageActionState) {
          Navigator.pushNamed(context, Cart.id);
        }
        else if(state is HomeItemWishListed){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item Added to Wishlist")) );
        }
        else if(state is HomeItemAddedToCart) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item Added to Cart")) );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
              appBar: AppBar(
                title: Text("bloc"),
                actions: [
                  IconButton(
                      onPressed: () {
                        homebloc.add(HomeWishlistBtnNavigateEvent());
                      },
                      icon: Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        homebloc.add(HomeCartBtnNavigateEvent());
                      },
                      icon: Icon(Icons.shopping_cart_outlined)),
                ],
              ),
              body: Center(
                child: CircularProgressIndicator(color: Colors.teal),
              ),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;

            ///to access the list we created in this state
            return Scaffold(
              appBar: AppBar(
                title: Text("bloc"),
                actions: [
                  IconButton(
                      onPressed: () {
                        homebloc.add(HomeWishlistBtnNavigateEvent());
                      },
                      icon: Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        homebloc.add(HomeCartBtnNavigateEvent());
                      },
                      icon: Icon(Icons.shopping_cart_outlined)),
                ],
              ),
              body: ListView.builder(
                itemCount: successState.products.length,
                itemBuilder: (context, index) => ProductListTile(
                  homeBloc: homebloc,
                  productDataModel: successState.products[index],
                ),
              ),
            );
          case HomeErrorState:
            return Scaffold(
              appBar: AppBar(
                title: Text("bloc"),
                actions: [
                  IconButton(
                      onPressed: () {
                        homebloc.add(HomeWishlistBtnNavigateEvent());
                      },
                      icon: Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        homebloc.add(HomeCartBtnNavigateEvent());
                      },
                      icon: Icon(Icons.shopping_cart_outlined)),
                ],
              ),
              body: Center(
                child: Text("Error Occured"),
              ),
            );
          default:
            return Container();
        }
      },
    );
  }
}
