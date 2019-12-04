import 'package:flutter/material.dart';

///
/// @author Liang Wei
/// date 2019-12-02

class My extends StatefulWidget {
  _MyState createState() => _MyState();
}

class _MyState extends State<My> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('我的'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
