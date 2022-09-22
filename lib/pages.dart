import 'package:flutter/material.dart';

abstract class MyPage {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyPage && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class HomePage extends MyPage {}

class AboutPage extends MyPage {}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Home'),
          TextField(),
        ],
      ),
    );
  }
}

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('About'),
          TextField(),
        ],
      ),
    );
  }
}
