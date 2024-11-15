import 'package:flutter/material.dart';
import 'package:wheel_of_names/constant.dart';
import 'package:wheel_of_names/contact.dart';
import 'package:wheel_of_names/spinwheel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToPage(int index) {
    _pageController.jumpToPage(index);
    Navigator.pop(context); // Close the drawer after selection
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkColor,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                "assets/images/logo.png",
                height: 40,
                width: 40,
              ),
            ),
            const Text(
              'WHEEL OF NAMES',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.white,
        child: Container(
          color: AppColors.darkColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(),
              ListTile(
                leading: const Icon(Icons.home, color: Colors.white),
                title: const Text(
                  'HOME',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () => _navigateToPage(0),
              ),
              ListTile(
                leading: const Icon(Icons.contact_page, color: Colors.white),
                title: const Text(
                  'CONTACT',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () => _navigateToPage(1),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics:
            const NeverScrollableScrollPhysics(), // Disable swipe navigation
        children: const [
          SpinWheel(), // Replace with your Home page widget
          Contact(), // Contact page widget
        ],
      ),
    );
  }
}
