import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learn_bloc/features/cart/data/data_sources/cart_items.dart';
import 'package:learn_bloc/features/home/data/data_sources/grocery_data.dart';
import 'package:learn_bloc/features/wishlist/data/data_sources/wishlist_item.dart';
import 'package:meta/meta.dart';

import '../../../../core/model/product_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishlistBtnClickedEvent>(homeProductWishlistBtnClickedEvent);
    on<HomeProductCartBtnClickedEvent>(homeProductCartBtnClickedEvent);
    on<HomeWishlistBtnNavigateEvent>(homeWishlistBtnNavigateEvent);
    on<HomeCartBtnNavigateEvent>(homeCartBtnNavigateEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    print("the initial state of app");
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 3));
    emit(HomeLoadedSuccessState(
        products: GroceryData.products.map((e) => ProductDataModel(
            id: e['id'],
            name: e['name'],
            description: e['description'],
            price: e['price'],
            imageUrl: e['imageUrl'])).toList()
    ));
    ///here we have to pass the list of my products from data_source
    ///the data in data_source is a list which i have to map into my product model
  }

  FutureOr<void> homeProductWishlistBtnClickedEvent(
      HomeProductWishlistBtnClickedEvent event, Emitter<HomeState> emit) {
    print("item added to Wishlist ");
    ///now here when the btn is clicked i must append the item to the wislist waali list which i have created in the data source(data dir) of wishlist feature
    ///and for that i would need the product list here in this event but how will i access that??
    ///so in the class of this event i can add my requirement of fetching the product item due to which this event triggered in the first place
    WishlistItems.wishlistItems.add(event.clickedProduct);
    emit(HomeItemWishListed());
  }

  FutureOr<void> homeProductCartBtnClickedEvent(
      HomeProductCartBtnClickedEvent event, Emitter<HomeState> emit) {
    print("item added to cart");
    CartItems.cartItems.add(event.clickedProduct);
    emit(HomeItemAddedToCart());
  }

  FutureOr<void> homeWishlistBtnNavigateEvent(
      HomeWishlistBtnNavigateEvent event, Emitter<HomeState> emit) {
    print("Wishlist clicked going to wishlist page ");
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeCartBtnNavigateEvent(
      HomeCartBtnNavigateEvent event, Emitter<HomeState> emit) {
    print("Cart clicked going to cart page");
    emit(HomeNavigateToCartPageActionState());
  }
}
