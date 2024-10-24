import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:splash/component/home_cell.dart';
import 'package:splash/component/loading_indicator.dart';
import 'package:splash/component/utils/colors_ext.dart';
import 'package:splash/model/unsplash_image_model.dart';
import 'package:splash/module/main_module/View/main_topic_page.dart';

import '../Controller/main_module_controller.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  PageController pageC = PageController(initialPage: 0);

  TabController? tabC;

  List<MainTopicPage> pages = [];

  @override
  bool get wantKeepAlive => true; // 保持页面状态

  @override
  Widget build(BuildContext context) {
    super.build(context); // 这是必须调用的，以正确使用Mixin
    print("Main Page Build");
    return SafeArea(
        child: Container(
      decoration: BoxDecoration(
        color: HexColor("111111"),
      ),
      child: GetBuilder<MainModuleTopicController>(builder: (mainTopicCtr) {
        if (mainTopicCtr.isLoading.value) {
          print("Loading MainModule");
          return const LoadingIndicator();
        }

        if (mainTopicCtr.topicList.isEmpty) {
          return const Center(child: Text("Empty Data"));
        }

        pages = mainTopicCtr.topicList
            .map((topicModel) => MainTopicPage(topic: topicModel))
            .toList();

        tabC = TabController(length: pages.length, vsync: this);

        return Column(
          children: [
            TabBar(
                dividerColor: Colors.transparent,
                dividerHeight: 0,
                indicatorColor: Colors.white,
                isScrollable: true,
                controller: tabC,
                tabAlignment: TabAlignment.start,
                onTap: (index) {
                  pageC.jumpToPage(index);
                },
                tabs: List.generate(pages.length, (index) {
                  return Tab(
                    child: Text(
                      mainTopicCtr.topicList[index].title,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                })),
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) {
                  return pages[index];
                },
                controller: pageC,
                onPageChanged: (index) {
                  tabC!.animateTo(index);
                },
              ),
            )
          ],
        );
      }),
    ));
  }
}
