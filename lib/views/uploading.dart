import 'package:flutter/material.dart';

///
/// @author Liang Wei
/// date 2019-12-02

class Uploading extends StatefulWidget {
  _UploadingState createState() => _UploadingState();
}

class _UploadingState extends State<Uploading>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('上传'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
