import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:splash/module/main_module/View/main_page.dart';
import 'package:splash/module/search_module/View/search_page.dart';
import 'package:splash/module/user/Service/user_service.dart';
import 'package:splash/module/user/View/user_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController controller = PageController(initialPage: 0);
  final UserService _userService = Get.find<UserService>();
  int _selectedPage = 0;
  late List<Widget> pages;
  List<BottomNavigationBarItem> barItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "User")
  ];

  @override
  void initState() {
    pages = generatePages();
    super.initState();
  }

  List<Widget> generatePages() {
    List<Widget> ws = [];
    ws.add(const MainPage());
    ws.add(const SearchPage());
    ws.add(UserPage(
      userName: _userService.userAuthInfo.value?.userName,
      userID: _userService.userAuthInfo.value?.userID,
      isMainPageUserModule: true,
    ));
    return ws;
  }

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
        physics: const NeverScrollableScrollPhysics(),
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
