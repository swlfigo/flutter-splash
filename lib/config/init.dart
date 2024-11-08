import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:splash/config/storage/local_storage.dart';

Future preInit() async {
  print("Pre Init");
  await dotenv.load();
  await LocalStorage.initSP();
  WidgetsFlutterBinding.ensureInitialized();
}
