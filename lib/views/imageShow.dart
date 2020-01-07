import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pc_cloud/model/globalDataModel.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

///
/// @author Liang Wei
/// date 2020-01-07

class GridPhoto extends StatefulWidget {
  List<AssetEntity> assetEntityList;

  GridPhoto({this.assetEntityList});

  @override
  _GridPhotoStatus createState() =>
      _GridPhotoStatus(assetEntityList: assetEntityList);
}

class _GridPhotoStatus extends State<GridPhoto> {
  _GridPhotoStatus({this.assetEntityList});

  List<AssetEntity> assetEntityList;

  test(List<AssetPathEntity> list) async {
    var aa = await list[list.length - 1].assetList;
    if(mounted){
      setState(() {
        assetEntityList = aa;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _globalData = Provider.of<GlobalDataModel>(context);
    var list = _globalData.getAssetPathEntityList;
    test(list);

    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: Column(
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
                childAspectRatio:
                    (orientation == Orientation.portrait) ? 1.0 : 1.3,
                children:  assetEntityList == null || assetEntityList.length == 0
                    ? [Text('Loading...')]
                    : assetEntityList.map<Widget>((AssetEntity assetEntity) {
                        return GridPhotoItem(assetEntity: assetEntity);
                      }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GridPhotoItem extends StatefulWidget {
  GridPhotoItem({this.assetEntity});

  AssetEntity assetEntity;

  @override
  _GridPhotoItemStatus createState() => _GridPhotoItemStatus(assetEntity);
}

class _GridPhotoItemStatus extends State<GridPhotoItem> {
  File file;
  AssetEntity assetEntity;

  _GridPhotoItemStatus(AssetEntity assetEntity) {
    this.assetEntity = assetEntity;
  }

  @override
  void initState() {
    super.initState();
    loadFile();
  }

  loadFile() async {
    var fileObj = await assetEntity.file;
    setState(() {
      this.file = fileObj;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget image = GestureDetector(
      child: file == null
          ? null
          : Image.file(
              file,
              fit: BoxFit.cover,
            ),
    );

    return GridTile(
      header: GestureDetector(
        onTap: () {},
        child: GridTileBar(),
      ),
      child: image,
    );
  }
}
