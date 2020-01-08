import 'package:flutter/material.dart';
import 'package:pc_cloud/model/globalDataModel.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

import 'imageShow.dart';

class Folder extends StatefulWidget {
  _FolderState createState() => _FolderState();
}

class _FolderState extends State<Folder> with AutomaticKeepAliveClientMixin {

  List<AssetEntity> assetEntityList;

  @override
  Widget build(BuildContext context) {

    ScrollController controller = ScrollController();
    final _globalData = Provider.of<GlobalDataModel>(context);

    Widget _buildFolderItem(
        AssetPathEntity assetPathEntity, BuildContext context) {
      return InkWell(
        child: Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.5, color: Color(0xffe5e5e5))),
            ),
            child: ListTile(
              leading: Image.asset('assets/images/folder.png'),
              title: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    assetPathEntity.name,
                    style: TextStyle(fontSize: 14),
                  )),
                  Text(
                    '${assetPathEntity.assetCount}项',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
              trailing: Icon(Icons.chevron_right),
            )),
        onTap: () {
          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
            return GridPhoto(assetPathEntity: assetPathEntity);
          }));
        },
      );
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
                      _globalData.getAssetPathEntityList[index], context);
                },
              )));
  }

  @override
  bool get wantKeepAlive => true;
}
