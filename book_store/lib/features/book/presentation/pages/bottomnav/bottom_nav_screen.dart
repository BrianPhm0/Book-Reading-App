import 'package:book_store/features/book/presentation/pages/bottomnav/cart/cart_screen.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/categories/categories_screen.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/userAccount/home/home_screen.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/library/library_screen.dart';
import 'package:book_store/features/book/presentation/pages/search_screen.dart';
import 'package:book_store/features/book/presentation/widgets/navigation_menu.dart';
import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  final int initialIndex;

  const BottomNavScreen({super.key, this.initialIndex = 0});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  late int _selectedIndex; // Use late initialization

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    LibraryScreen(),
    CategoriesScreen(),
    CartScreen(),
    SearchScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; // Initialize here
  }

  @override
  void didUpdateWidget(covariant BottomNavScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialIndex != _selectedIndex) {
      setState(() {
        _selectedIndex = widget.initialIndex;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedLabelStyle: TextStyle(fontFamily: 'Schyler'),
          unselectedLabelStyle: TextStyle(fontFamily: 'Schyler'),
        ),
      ),
      home: Scaffold(
        body: _widgetOptions[_selectedIndex],
        bottomNavigationBar: NavigationMenu(
          backgroudColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.book_online), label: 'Library'),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: 'Categories'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          ],
        ),
      ),
    );
  }
}
