import 'package:flutter/material.dart';
import 'package:pc_cloud/model/globalDataModel.dart';
import 'package:provider/provider.dart';

///
/// @author Liang Wei
/// date 2019-12-02

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {



  @override
  Widget build(BuildContext context) {

    final _globalData = Provider.of<GlobalDataModel>(context);

    return Scaffold(
      body: Center(
        child: Text(_globalData.getAssetPathEntityList.length.toString()),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
