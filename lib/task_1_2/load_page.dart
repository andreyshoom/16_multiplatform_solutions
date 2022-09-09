import 'dart:io';
import 'package:html/parser.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multiplatform_solutions/task_1_2/widgets.dart';

class LoadPage extends StatefulWidget {
  const LoadPage({Key? key}) : super(key: key);

  @override
  State<LoadPage> createState() => _LoadPageState();
}

class _LoadPageState extends State<LoadPage> {
  String _htmlText = '';
  String _title = '';
  String _link = '';
  final TextEditingController _editingController =
      TextEditingController(text: 'https://flutter.dev/');
  bool _isLoading = false;

  Future _loadingPage() async {
    try {
      final response = await http.get(
        Uri.parse(
          _editingController.text.toString(),
        ),
      );

      setState(() {
        _htmlText = response.body;
        _link = _editingController.text.toString();
        var doc = parse(_htmlText);
        _title = doc.querySelector('title')!.text;
        _title = _title.replaceAll(RegExp(r"\s+"), " ");
      });
      return _htmlText;
    } catch (error) {
      return Future.error(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          FutureWidget(
            loadingPage: _loadingPage(),
            isLoading: _isLoading,
            title: _title,
            htmlText: _htmlText,
            link: _link,
          ),
          // WebViewWidget(
          //   loadingPage: _loadingPage(),
          //   isLoading: _isLoading,
          //   title: _title,
          //   link: _link,
          // ),
          Container(
            height: 0.5,
            color: Colors.black,
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 50,
                          child: TextFormField(
                            controller: _editingController,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.resolveWith<
                                  OutlinedBorder>(
                                (states) {
                                  return RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      0.0,
                                    ),
                                  );
                                },
                              ),
                            ),
                            onPressed: () {
                              _loadingPage();
                              setState(() {
                                _isLoading = true;
                              });
                            },
                            child: const Text(
                              'LOAD',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      kIsWeb
                          ? 'APPLICATION RUNNING ON WEB'
                          : 'APPLICATION RUNNING ON ${Platform.operatingSystem.toUpperCase()}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
