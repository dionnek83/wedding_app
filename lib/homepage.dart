import 'package:flutter/material.dart';
import 'package:wedding_app/guests.dart';
import 'package:wedding_app/home.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:wedding_app/tables.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  int selected = 0;
  bool heart = false;
  final controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,

      bottomNavigationBar: StylishBottomBar(
        option: DotBarOptions(
          dotStyle: DotStyle.circle,
          gradient: const LinearGradient(
            colors: [
              Colors.deepPurple,
              Colors.pink,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        items: [
          BottomBarItem(
            icon: const Icon(
              Icons.house_outlined,
            ),
            selectedIcon: const Icon(Icons.house_rounded),
            selectedColor: Colors.teal,
            unSelectedColor: Colors.grey,
            title: const Text('Home'),
            showBadge: false,
            badgeColor: Colors.purple,
            badgePadding: const EdgeInsets.only(left: 4, right: 4),
          ),
          BottomBarItem(
            icon: const Icon(
              Icons.person_outline,
            ),
            selectedIcon: const Icon(
              Icons.person_outline,
            ),
            selectedColor: Colors.red,
            title: const Text('Guests'),
          ),
          BottomBarItem(
              icon: const Icon(
                Icons.style_outlined,
              ),
              selectedIcon: const Icon(
                Icons.style,
              ),
              selectedColor: Colors.deepOrangeAccent,
              title: const Text('Tables')),
          BottomBarItem(
              icon: const Icon(
                Icons.photo_library_outlined,
              ),
              selectedIcon: const Icon(
                Icons.photo_library_outlined,
              ),
              selectedColor: Colors.deepPurple,
              title: const Text('Images')),
        ],
        hasNotch: true,
        fabLocation: StylishBarFabLocation.center,
        currentIndex: selected,
        notchStyle: NotchStyle.square,
        onTap: (index) {
          if (index == selected) return;
          controller.jumpToPage(index);
          setState(() {
            selected = index;
          });
        },
      ),

      body: SafeArea(
        child: PageView(
          controller: controller,
          children: const [
            Home(),
            Guests(),
            Tables(),
            Tables(),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
