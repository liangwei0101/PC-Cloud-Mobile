import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pc_cloud/model/globalDataModel.dart';
import 'package:pc_cloud/model/checkFolder.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
///
/// @author Liang Wei
/// date 2020-01-05

class Folder extends StatefulWidget {
  _FolderState createState() => _FolderState();
}

class _FolderState extends State<Folder> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FolderList(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class FolderList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _globalData = Provider.of<GlobalDataModel>(context);
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Column(
      children: <Widget>[
        Expanded(
          child: SafeArea(
            top: false,
            bottom: false,
            child: GridView.count(
              crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              padding: const EdgeInsets.all(4.0),
              childAspectRatio: (orientation == Orientation.portrait) ? 1.0 : 1.3,
              children: _globalData.getAssetPathEntityList.map<Widget>((AssetPathEntity assetPathEntity) {
                return GridPhotoItem(assetPathEntity);
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class GridPhotoItem extends StatelessWidget {

  GridPhotoItem(AssetPathEntity assetPathEntity){
    this.assetPathEntity = assetPathEntity;
  }

  AssetPathEntity assetPathEntity;

  File file;

  // 获取相册权限
  void getFile() async {
    List<AssetEntity> assetEntityList = await assetPathEntity.assetList;
    if(assetEntityList.length > 0) {
      file = await assetEntityList[0].file;
    }
  }

  @override
  Widget build(BuildContext context) {
    getFile();
    final IconData icon =  Icons.star_border;
//    final IconData icon = loveFolder.isFavorite ? Icons.star : Icons.star_border;

    final Widget image = GestureDetector(
      onTap: () { },
      child: Hero(
        key: Key(assetPathEntity.name),
        tag: assetPathEntity.name,
        child:  file == null
            ? Center(child: Text('请等待'))
            :Image.file(file),
      ),
    );

      return GridTile(
          footer: GestureDetector(
            child: GridTileBar(
              backgroundColor: Colors.black45,
              title: Text('我是标题'),
              subtitle: _GridTitleText('我是子标题'),
              trailing: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
        child: image,
      );
  }
}

class _GridTitleText extends StatelessWidget {
  const _GridTitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Text(text),
    );
  }
}