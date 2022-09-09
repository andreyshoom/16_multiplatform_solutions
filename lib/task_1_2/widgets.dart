import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multiplatform_solutions/task_3/webview.dart'
    if (dart.library.io) 'package:multiplatform_solutions/task_3/non_web_platform_webview.dart'
    if (dart.library.html) 'package:multiplatform_solutions/task_3/web_platform_webview.dart';

class FutureWidget extends StatelessWidget {
  final Future loadingPage;
  final String title;
  final String htmlText;
  final String link;
  bool isLoading;
  FutureWidget({
    Key? key,
    required this.loadingPage,
    required this.isLoading,
    required this.title,
    required this.htmlText,
    required this.link,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: FutureBuilder(
        future: isLoading ? loadingPage : null,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // return SingleChildScrollView(
            //   // for tasks 1,2
            //   child: ViewWidget(
            //       loadingPage: loadingPage,
            //       isLoading: isLoading,
            //       title: title,
            //       link: link,
            //       htmlText: htmlText),
            // );
            return ViewWidget(
              // for task 3
              loadingPage: loadingPage,
              isLoading: isLoading,
              title: title,
              link: link,
              htmlText: htmlText,
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('File not found!'),
                  Text('${snapshot.error}'),
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class ViewWidget extends StatelessWidget {
  final Future loadingPage;
  final String title;
  final String link;
  final String htmlText;
  bool isLoading;
  ViewWidget({
    Key? key,
    required this.loadingPage,
    required this.isLoading,
    required this.title,
    required this.link,
    required this.htmlText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            kIsWeb
                ? 'CORS Header: None'
                : 'CORS Header: No need for ${Platform.operatingSystem}',
            style: kIsWeb
                ? const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )
                : const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
          ),
        ),
        Expanded(
          flex: 5,
          child: webView(link), //for task 3
        ),
        // Text(htmlText), //for tasks 1,2
      ],
    );
  }
}
