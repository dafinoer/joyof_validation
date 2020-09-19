import 'package:flutter/material.dart';
import 'package:validation_ektp/screen/home/home_page.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('eKtp'),
          actions: [IconButton(icon: Icon(Icons.more_vert), onPressed: () {})],
        ),
        body: SafeArea(child: HomePage()));
  }
}
