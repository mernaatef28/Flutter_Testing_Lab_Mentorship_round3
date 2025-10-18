import 'package:flutter/material.dart';
import 'package:flutter_testing_lab/home_page.dart';
import 'package:flutter_testing_lab/services/cart_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const FlutterTestingLabApp());
}

class FlutterTestingLabApp extends StatelessWidget {
  const FlutterTestingLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
        create: (_) => CartService(),
        child:MaterialApp(
      title: 'Flutter Testing Lab',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    ));
  }
}
