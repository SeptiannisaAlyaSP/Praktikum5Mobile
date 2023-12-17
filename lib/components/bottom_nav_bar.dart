import 'package:flutter/material.dart';

class MyBottomNavBar extends StatelessWidget {
  final void Function(int)? onTabChange;

  MyBottomNavBar({Key? key, required this.onTabChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: BottomNavigationBar(
        backgroundColor: Colors.grey.shade100,
        selectedItemColor: Colors.grey.shade700,
        unselectedItemColor: Colors.grey[400],
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_rounded),
            label: 'Cart',
          ),
        ],
        currentIndex: 0,
        onTap: onTabChange,
      ),
    );
  }
}
