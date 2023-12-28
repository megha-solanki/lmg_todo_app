import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lmg_todo_app/database/todo.dart';
import 'package:lmg_todo_app/screens/home_page/home_page.dart';
import 'package:lmg_todo_app/utils/colors_const.dart';

import 'controller/initialize_controllers.dart';

late Box<Todos> todoBox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(TodosAdapter());
  }
  todoBox = await Hive.openBox<Todos>("todos");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitializeControllers(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: white,
          fontFamily: "Zoho Puvi",
          appBarTheme: const AppBarTheme(backgroundColor: white),
          useMaterial3: true),
      home: const HomePage(),
    );
  }
}
