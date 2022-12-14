import 'package:flutter/material.dart';
import 'package:multiplatform_solutions/task_4/widgets/adaptive_widget.dart';
import 'package:multiplatform_solutions/task_4/widgets/grid_view_widget.dart';
import 'package:multiplatform_solutions/task_4/widgets/list_view_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      //for tasks 1,2,3
      // body: LoadPage(),
      // for tasks 4
      body: AdaptiveWidget(
        wide: GridViewWidget(),
        narrow: ListViewWidget(),
      ),
    );
  }
}
