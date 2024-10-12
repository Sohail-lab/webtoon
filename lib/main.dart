import 'package:flutter/material.dart';
import 'package:webtoon_explorer_app/item.dart';
import 'package:webtoon_explorer_app/pages/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('ratings');
  Hive.registerAdapter(ItemAdapter());
  await Hive.openBox<Item>('favorites');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}