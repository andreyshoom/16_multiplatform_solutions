import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiplatform_solutions/task_4/widgets/list_view_widget.dart';
import 'package:multiplatform_solutions/task_4/users/user.dart';
import 'package:popover/popover.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.blue,
              child: const FittedBox(
                alignment: Alignment.topCenter,
                fit: BoxFit.scaleDown,
                child: Text(
                  'Adaptive App',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: FutureBuilder<List<User>>(
                future: parseJson(context),
                builder: (context, snanshot) {
                  final users = snanshot.data ?? [];
                  return GridView.builder(
                    itemCount: users.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 15.0,
                    ),
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return PopoverWidget(
                        name: user.name,
                        email: user.email,
                        imageUrl: user.imageUrl,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PopoverWidget extends StatelessWidget {
  final String name;
  final String email;
  final String imageUrl;
  const PopoverWidget({
    Key? key,
    required this.name,
    required this.email,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
            ),
          ]),
      child: GestureDetector(
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                foregroundImage: NetworkImage(imageUrl),
                radius: 50,
              ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                email,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          showPopover(
            context: context,
            transitionDuration: const Duration(
              milliseconds: 150,
            ),
            width: 250,
            height: 210,
            arrowHeight: 15,
            arrowWidth: 30,
            contentDyOffset: -40,
            radius: 15,
            bodyBuilder: (context) => ListView(
              children: [
                SizedBox(
                  height: 55,
                  child: CupertinoActionSheetAction(
                    child: const PopUpTextWidget(
                      text: 'VIEW PROFILE',
                      iconData: Icons.person,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 55,
                  child: CupertinoActionSheetAction(
                    child: const PopUpTextWidget(
                      text: 'FRIENDS',
                      iconData: Icons.people,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 55,
                  child: CupertinoActionSheetAction(
                    child: const PopUpTextWidget(
                      text: 'REPORT',
                      iconData: Icons.assignment_late,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
