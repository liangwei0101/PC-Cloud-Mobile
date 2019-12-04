import 'package:flutter/material.dart';

///
/// @author Liang Wei
/// date 2019-12-02

class FileAndFolder extends StatefulWidget {
  _FileAndFolderState createState() => _FileAndFolderState();
}

class _FileAndFolderState extends State<FileAndFolder>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('文件'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
