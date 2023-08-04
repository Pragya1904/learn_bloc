import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learn_bloc/features/cart/data/data_sources/cart_items.dart';
import 'package:meta/meta.dart';

import '../../../../core/model/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    // TODO 4: implement event handlers for each event created
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemovefromCartBtnClickedEvent>(cartRemovefromCartBtnClickedEvent);
    on<CartNavigatetoHomeBtnClickedEvent>(cartNavigatetoHomeBtnClickedEvent);
    on<CartNavigatetoWishlistBtnClickedEvent>(
        cartNavigatetoWishlistBtnClickedEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    print("cart initial state");
    //todo 11: now I'm adding which state to emit in which this event is triggered
   // emit(CartLoadingState());

    ///we can add a future till the data is being loaded from the data sources like home page but since I'm taking data from remote source it can be skipped
    emit(CartSuccessfullyLoadedState(
        cartItemsList: CartItems.cartItems.map((e) => ProductDataModel(
            id: e.id,
            name: e.name,
            description: e.description,
            price: e.price,
            imageUrl: e.imageUrl)).toList()
    ));
  }

  FutureOr<void> cartRemovefromCartBtnClickedEvent(
      CartRemovefromCartBtnClickedEvent event, Emitter<CartState> emit) {
    print("Item Removed from cart");
    //todo 17: removing that product item from the cart list
    print("Old length");
    print(CartItems.cartItems.length);
    CartItems.cartItems.remove(event.clickedProduct);
    print("new length");
    print(CartItems.cartItems.length);
    emit(CartRemovedItemActionState());
    emit(CartSuccessfullyLoadedState(cartItemsList: CartItems.cartItems));
  }

  FutureOr<void> cartNavigatetoHomeBtnClickedEvent(
      CartNavigatetoHomeBtnClickedEvent event, Emitter<CartState> emit) {
    print("home clicked going to home page ");
    emit(CartNavigateToHomePageActionState());
  }

  FutureOr<void> cartNavigatetoWishlistBtnClickedEvent(
      CartNavigatetoWishlistBtnClickedEvent event, Emitter<CartState> emit) {
    print("Wishlist clicked going to wishlist page ");
    emit(CartNavigateToWishlistPageActionState());
  }
}
