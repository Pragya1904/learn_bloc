part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeProductWishlistBtnClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;
  HomeProductWishlistBtnClickedEvent({required this.clickedProduct});
}

class HomeProductCartBtnClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;
  HomeProductCartBtnClickedEvent({required this.clickedProduct});
}

class HomeWishlistBtnNavigateEvent extends HomeEvent {}

class HomeCartBtnNavigateEvent extends HomeEvent {}
