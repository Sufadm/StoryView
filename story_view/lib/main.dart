import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_view_task/controller/controller.dart';
import 'package:story_view_task/view/story_view_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (_) => CategoryProvider(),
        child: const StoryViewPage(),
      ),
    );
  }
}
