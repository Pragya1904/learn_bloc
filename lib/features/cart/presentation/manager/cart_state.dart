part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartActionableState extends CartState{}
///here we can have 2 kinds of states.. 1) buildUI states and 2) actionable states
///as the name suggest action can be to route somewhere
///and buildUI can be in some loading state or error state or succesfully data is being displayed state
//todo 3: add all the relevant states possible
///go to cart_bloc now
class CartLoadingState extends CartState{}

class CartSuccessfullyLoadedState extends CartState{
  //todo 9: get the list of items in cart in this state
  final List<ProductDataModel> cartItemsList;

  CartSuccessfullyLoadedState({required this.cartItemsList});
}

class CartErrorState extends CartState{}

class CartNavigateToHomePageActionState extends CartActionableState{}

class CartNavigateToWishlistPageActionState extends CartActionableState{}

class CartRemovedItemActionState extends CartActionableState{}
