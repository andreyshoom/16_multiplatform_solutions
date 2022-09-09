import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiplatform_solutions/task_4/users/user.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adaptive App'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<User>>(
        future: parseJson(context),
        builder: (context, snapshot) {
          final users = snapshot.data ?? [];
          return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // height: 100,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                          ),
                        ]),
                    child: InkWell(
                      child: Row(children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: CircleAvatar(
                            radius: 50,
                            foregroundImage: NetworkImage(user.imageUrl),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                user.email,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                      onTap: () {
                        Navigator.of(context).restorablePush(_modalBuilder);
                      },
                    ),
                  ),
                );
              });
        },
      ),
    );
  }

  static Route<void> _modalBuilder(BuildContext context, Object? arguments) {
    return CupertinoModalPopupRoute<void>(
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              child: const PopUpTextWidget(
                text: 'VIEW PROFILE',
                iconData: Icons.person,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              child: const PopUpTextWidget(
                text: 'FRIENDS',
                iconData: Icons.people,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              child: const PopUpTextWidget(
                text: 'REPORT',
                iconData: Icons.assignment_late,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}

class PopUpTextWidget extends StatelessWidget {
  final String text;
  final IconData iconData;
  const PopUpTextWidget({
    Key? key,
    required this.text,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(
        iconData,
        size: 30,
        color: Colors.black,
      ),
      Container(
        width: 10,
      ),
      Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    ]);
  }
}
