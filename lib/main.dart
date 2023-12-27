import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lmg_todo_app/database/todo.dart';
import 'package:lmg_todo_app/screens/home_page.dart';
import 'package:lmg_todo_app/utils/colors_const.dart';

Box? box;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(1)){
    Hive.registerAdapter(TodosAdapter());
  }
  box = await Hive.openBox<Todos>("todos");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
