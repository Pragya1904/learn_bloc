part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState{}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState{}

class HomeLoadedSuccessState extends HomeState {
  //i should get the list of products in this state
  final List<ProductDataModel> products;

  HomeLoadedSuccessState({required this.products});

}

class HomeErrorState extends HomeState {}

class HomeNavigateToWishlistPageActionState extends HomeActionState{}

class HomeNavigateToCartPageActionState extends HomeActionState{}

class HomeItemAddedToCart extends HomeActionState{}

class HomeItemWishListed extends HomeActionState{}
//build UI states -
//actionable states -