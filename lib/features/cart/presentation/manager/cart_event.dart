part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

///i'll be adding 2 navigation events for home page and wishlist list page and 2 events to add or subtract the quantity of that item

//todo 2: add ur events here
///once the events are added next step would be to add possible states they might result in..so go to cart_state


class CartInitialEvent extends CartEvent{}

//todo 16: call the product to be removed
class CartRemovefromCartBtnClickedEvent extends CartEvent{
   final ProductDataModel clickedProduct;

  CartRemovefromCartBtnClickedEvent({required this.clickedProduct});
}

class CartNavigatetoHomeBtnClickedEvent extends CartEvent{}

class CartNavigatetoWishlistBtnClickedEvent extends CartEvent{}

