import 'package:flutter/material.dart';
import 'package:news_project/src/pages/pages.dart';
import 'package:news_project/src/services/news_service.dart';
import 'package:news_project/src/theme/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsService()),
      ],
      child: MaterialApp(
        title: 'Material App',
        theme: themeData,
        debugShowCheckedModeBanner: false,
        home: TabsPage(),
      ),
    );
  }
}