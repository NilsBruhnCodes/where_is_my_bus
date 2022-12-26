import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:where_is_my_bus/models/input_data.dart';
import 'package:where_is_my_bus/screens/home/home_screen.dart';
import 'package:where_is_my_bus/screens/home/widgets/settings_view.dart';
import 'package:where_is_my_bus/screens/loading_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String TextInputs = 'moin';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => InputData(),
        child: MaterialApp(
          home: LoadingScreen(),
        ));
  }
}
