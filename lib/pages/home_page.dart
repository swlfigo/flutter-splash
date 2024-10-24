import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:splash/module/main_module/View/main_page.dart';
import 'package:splash/module/search_module/View/search_page.dart';
import 'package:splash/pages/user/user_page.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController controller = PageController(initialPage: 0);

  int _selectedPage = 0;
  List<Widget> pages = [const MainPage(), const SearchPage(), const UserPage()];
  List<BottomNavigationBarItem> barItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "User")
  ];

  void _pageChange(int index) {
    if (index != _selectedPage) {
      setState(() {
        _selectedPage = index;
      });
    }
  }

  void onTap(int index) {
    controller.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (context, index) {
          return pages[index];
        },
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        itemCount: pages.length,
        onPageChanged: (int index) {
          if (index != _selectedPage) {
            setState(() {
              _selectedPage = index;
            });
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.inversePrimary,
        currentIndex: _selectedPage,
        items: barItems,
        onTap: onTap,
      ),
    );
  }
}
