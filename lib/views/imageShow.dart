import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pc_cloud/model/globalDataModel.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

import 'component/videoCard.dart';

/// 照片展示
/// @author Liang Wei
/// date 2020-01-07

class GridPhoto extends StatefulWidget {
  AssetPathEntity assetPathEntity;

  GridPhoto({this.assetPathEntity});

  @override
  _GridPhotoStatus createState() =>
      _GridPhotoStatus(assetPathEntity: assetPathEntity);
}

class _GridPhotoStatus extends State<GridPhoto> {
  _GridPhotoStatus({this.assetPathEntity});

  AssetPathEntity assetPathEntity;
  List<AssetEntity> assetEntityList;

  @override
  void initState() {
    super.initState();
    loadAssetEntity();
  }

  loadAssetEntity() async {
    var assetEntityTempList = await assetPathEntity.assetList;
    if (mounted) {
      setState(() {
        assetEntityList = assetEntityTempList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                children: assetEntityList == null || assetEntityList.length == 0
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

  Widget switchImageOrVideo(File file) {
    Widget widget;
    if(file!=null && file.path != null) {
      int index = file.path.lastIndexOf('.');
      if (index > -1) {
        String fileTypeName = file.path.substring(index, file.path.length);
        switch (fileTypeName) {
          case '.jpg':
          case '.jpeg':
          case '.png':
            widget = Image.file(
              file,
              fit: BoxFit.cover,
            );
            break;
          case '.mp4':
            widget = VideoComponent(file: file);
            break;
          default:
            widget = null;
            break;
        }
      }
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(
      header: GestureDetector(
        onTap: () {},
        child: GridTileBar(),
      ),
      child: file == null? Text('loading...'): switchImageOrVideo(file),
    );
  }
}
