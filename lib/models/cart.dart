import 'package:flutter/material.dart';

import 'shoe.dart';

class Cart extends ChangeNotifier {
  // list of ice cream for sale
  List<Shoe> shoeShop = [
    Shoe(
      name: 'chocolate',
      price: '220',
      imagePath: 'lib/images/chocolate.png',
      description: 'the sweet one is the chocolate one',
    ),
    Shoe(
      name: 'coffe',
      price: '230',
      imagePath: 'lib/images/coffe.png',
      description: 'sweet mixture and distinctive coffee aroma',
    ),
    Shoe(
      name: 'matcha',
      price: '250',
      imagePath: 'lib/images/matcha.png',
      description: 'bittersweet mixed gently in one bite',
    ),
    Shoe(
      name: 'oreo',
      price: '230',
      imagePath: 'lib/images/oreo.png',
      description: 'Oreo crumbles mixed with sweet ice cream',
    ),
    Shoe(
      name: 'rainbow',
      price: '280',
      imagePath: 'lib/images/rainbow.png',
      description: 'Bright colors are ready to color your day',
    ),
    Shoe(
      name: 'vanila',
      price: '220',
      imagePath: 'lib/images/vanila.png',
      description: 'sweet white as sweet as you',
    ),
  ];

  // list of items in user cart
  List<Shoe> userCart = [];

  // get list of ice cream for sale
  List<Shoe> getShoeList() {
    return shoeShop;
  }

  // get cart
  List<Shoe> getUserCart() {
    return userCart;
  }

  // add items to cart
  void addItemToCart(Shoe shoe) {
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(Shoe shoe) {
    notifyListeners();
  }
}
