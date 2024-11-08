import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'package:splash/component/utils/const_var.dart';
import 'package:splash/module/user/Model/user_access.dart';
import 'package:splash/module/user/Service/user_service.dart';
import 'package:splash/net/api.dart';
import 'package:splash/net/interceptors/header_interceptor.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SelfUserLoginPage extends StatefulWidget {
  const SelfUserLoginPage({super.key});
  @override
  State<SelfUserLoginPage> createState() => _SelfUserLoginPageState();
}

class _SelfUserLoginPageState extends State<SelfUserLoginPage> {
  late WebViewController webCtrl;

  @override
  void initState() {
    log("WebCtrl Init");
    webCtrl = WebViewController()
      ..clearCache()
      ..clearLocalStorage()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {
          print("Loading Progress:$progress");
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {
          print("OnPageFinished:$url");
        },
        onHttpError: (HttpResponseError error) {
          print("OnHttpError");
        },
        onWebResourceError: (WebResourceError error) {
          print("WebView Request Error:${error.description}");
        },
        onNavigationRequest: _handleNavigationRequest,
      ));
    clearCahche();
    webCtrl.setBackgroundColor(getGlobalBackGroundColor());
    webCtrl.loadRequest(generateURI());
    super.initState();
  }

  void clearCahche() async {
    await _clearCache();
  }

  Future<void> _clearCache() async {
    // 清除所有类型的缓存
    await webCtrl.clearCache();
    await webCtrl.clearLocalStorage();

    await WebViewCookieManager().clearCookies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("Self Login Page Dispose");
    webCtrl.loadRequest(Uri.parse('about:blank'));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: getGlobalBackGroundColor(),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top + MainPageTopGap,
            width: double.infinity,
            child: Container(
              alignment: Alignment.bottomLeft,
              color: getGlobalBackGroundColor(),
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(child: WebViewWidget(controller: webCtrl))
        ],
      ),
    );
  }

  Future<NavigationDecision> _handleNavigationRequest(
      NavigationRequest request) async {
    print("onNavigationRequest:${request.url}");
    if (request.url.startsWith(dotenv.env["AuthRedirectURI"] as String)) {
      var code = Uri.parse(request.url).queryParameters["code"];
      print("Get Code:$code");
      //Post Code Get Access Code
      if (code != null) {
        webCtrl.loadRequest(Uri.parse('about:blank'));
        getAccessToken(code);
      }

      return NavigationDecision.prevent;
    }
    return NavigationDecision.navigate;
  }

  Uri generateURI() {
    final uri = Uri.parse(Uri(
        scheme: 'https',
        host: 'unsplash.com',
        path: 'oauth/authorize',
        queryParameters: {
          'client_id': dotenv.env["ClientID"],
          'scope': 'public+read_user+write_user',
          'response_type': 'code',
          'redirect_uri': 'fluttersplash://authed'
        }).toString().replaceAll("%2B", "+"));
    log("OAuth URI:$uri");
    return uri;
  }

  Future getAccessToken(String code) async {
    try {
      var res = await httpManager.netFetch(
          'https://unsplash.com/oauth/token',
          {
            'client_id': dotenv.env["ClientID"],
            'redirect_uri': dotenv.env["AuthRedirectURI"],
            'client_secret': dotenv.env["ClientSecret"],
            'code': code,
            'grant_type': 'authorization_code',
          },
          null,
          null);
      if (res != null && res.data != null) {
        var userService = Get.find<UserService>();
        var userAuthInfo =
            UserAccessModel.fromJson(res.data as Map<String, dynamic>);
        userService.onSetUserAuthInfo(userAuthInfo);
      }
    } catch (e) {
      print("AccessKey Fetch Error:$e");
    } finally {}
  }
}
