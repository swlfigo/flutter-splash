import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "User",
        style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
      ),
      actions: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/settings_page");
                },
                icon: Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.inversePrimary,
                )),
            SizedBox(width: 10),
          ],
        )
      ],
    );
  }
}
