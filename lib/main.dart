import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/constants/database_constants.dart';
import 'package:todo/pages/Home_page.dart';

void main() async {
  // 1. PRIMEIRO inicializa o Hive
  await Hive.initFlutter();

  // 2. DEPOIS abre o box
  await Hive.openBox(BOXNAME);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.yellow),
    );
  }
}
