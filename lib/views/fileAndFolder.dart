import 'package:flutter/material.dart';
import 'package:pc_cloud/model/checkFolder.dart';
import 'package:pc_cloud/model/globalDataModel.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

/// 文件选择器
/// @author Liang Wei
/// date 2019-12-02

class FileAndFolder extends StatefulWidget {
  _FileAndFolderState createState() => _FileAndFolderState();
}

class _FileAndFolderState extends State<FileAndFolder>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();
    final _globalData = Provider.of<GlobalDataModel>(context);

    Widget _buildFolderItem(CheckFolder checkFolder, BuildContext context) {
      return InkWell(
          child: Container(
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 0.5, color: Color(0xffe5e5e5))),
              ),
              child: CheckboxListTile(
                secondary: Image.asset('assets/images/folder.png'),
                title: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      checkFolder.assetPathEntity.name,
                      style: TextStyle(fontSize: 14),
                    )),
                    Text(
                      '${checkFolder.assetPathEntity.assetCount}项',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
                value: checkFolder.isCheck ?? false,
                onChanged: (bool newValue) {
                  setState(() {
                    checkFolder.isCheck = newValue;
                  });
                },
              )));
    }
    return Scaffold(
        body: _globalData.getAssetPathEntityList.length == 0
            ? Center(child: Text('文件夹是空的'))
            : Scrollbar(
                child: ListView.builder(
                physics: BouncingScrollPhysics(),
                controller: controller,
                itemCount: _globalData.getAssetPathEntityList.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildFolderItem(
                      _globalData.getCheckFolderList[index], context);
                },
              )));
  }

  @override
  bool get wantKeepAlive => true;
}
