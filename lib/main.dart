import 'package:flutter/material.dart';
import './app/modules/home/views/pending_tasks_screen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Todo App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PendingTasksScreen(),
    );
  }
}
