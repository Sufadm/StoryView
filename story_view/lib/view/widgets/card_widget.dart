import 'package:flutter/material.dart';

Card cardWidget() {
  return const Card(
    color: Colors.white,
    child: ListTile(
      trailing: Icon(Icons.notifications),
      title: Text(
        "Hi,Student two",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "Good Morning",
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
            "https://i.pinimg.com/736x/5b/d8/e1/5bd8e1d873cb70e952795476a7000d14.jpg"),
      ),
    ),
  );
}
