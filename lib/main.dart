import 'package:flutter/material.dart';
import 'package:learn_bloc/features/wishlist/presentation/pages/wishlist_page.dart';

import 'features/cart/presentation/pages/cart_page.dart';
import 'features/home/presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Home.id,
      routes: {
        Home.id: (context) =>Home(),
        Wishlist.id: (context)=>const Wishlist(),
        Cart.id:(context)=>const Cart(),
      },
      theme: ThemeData(
        primaryColor: Colors.teal,
        secondaryHeaderColor: Colors.black,
        appBarTheme: AppBarTheme(backgroundColor: Colors.teal),
      ),

      
    );
  }
}
