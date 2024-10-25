import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:splash/component/home_cell.dart';
import 'package:splash/component/loading_indicator.dart';
import 'package:splash/component/utils/colors_ext.dart';
import 'package:splash/component/utils/const_var.dart';
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

  final MainModuleTopicController mainCtl =
      Get.put(MainModuleTopicController());

  @override
  bool get wantKeepAlive => true; // 保持页面状态

  @override
  Widget build(BuildContext context) {
    super.build(context); // 这是必须调用的，以正确使用Mixin
    print("Main Page Build");
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          color: HexColor("111111"),
        ),
        child: Obx(() {
          if (mainCtl.isLoading.value) {
            print("Loading MainModule");
            return const LoadingIndicator();
          }

          if (mainCtl.topicList.value.isEmpty) {
            return const Center(child: Text("Empty Data"));
          }

          return Column(
            children: [
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
      ),
      SizedBox(
        height: MediaQuery.of(context).padding.top + MainPageTopGap,
        child: Container(
            alignment: Alignment.bottomLeft,
            height: MediaQuery.of(context).padding.top + MainPageTopGap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Text(
                    "Unsplash",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Obx(() {
                  if (mainCtl.selectedTopicIndex.value < 0) {
                    return const Center(
                      child: Text("No Data"),
                    );
                  }

                  pages = mainCtl.topicList.value
                      .map((topicModel) => MainTopicPage(topicM: topicModel))
                      .toList();

                  tabC = TabController(
                      length: pages.length,
                      vsync: this,
                      initialIndex: mainCtl.selectedTopicIndex.value);

                  return TabBar(
                      dividerColor: Colors.transparent,
                      dividerHeight: 0,
                      indicatorColor: Colors.white,
                      isScrollable: true,
                      controller: tabC,
                      tabAlignment: TabAlignment.start,
                      onTap: (index) {
                        pageC.jumpToPage(index);
                        mainCtl.onTabbarSelected(index);
                      },
                      tabs: List.generate(pages.length, (index) {
                        return Tab(
                          child: Text(
                            mainCtl.topicList.value[index].title,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }));
                }),
              ],
            )),
      )
    ]);
  }
}
