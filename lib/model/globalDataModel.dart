
import 'package:flutter/material.dart';
import 'package:pc_cloud/model/uploadFile.dart';
import 'package:photo_manager/photo_manager.dart';

import 'checkFolder.dart';

///
/// @author Liang Wei
/// date 2019-12-03

class GlobalDataModel with ChangeNotifier {
  List<AssetPathEntity> _assetPathEntityList = new List();

  List<AssetPathEntity> get getAssetPathEntityList => _assetPathEntityList;

  List<UploadFile> _uploadingFileList = new List();

  List<UploadFile> get getUploadingFileList => _uploadingFileList;

  List<CheckFolder> _checkFolderList = new List();

  List<CheckFolder> get getCheckFolderList => _checkFolderList;

  int _count = 0;

  int get value => _count;

  void setAssetPathEntityList(List<AssetPathEntity> params) {
    this._assetPathEntityList = params;
    notifyListeners();
    for(var item in params){
      CheckFolder checkFolder = new CheckFolder();
      checkFolder.isCheck = false;
      checkFolder.assetPathEntity = item;
      _checkFolderList.add(checkFolder);
    }
  }

  void setUploadingFileList(List<UploadFile> params) {
    this._uploadingFileList = params;
    notifyListeners();
  }

  void increment() {
    _count++;
    notifyListeners();
  }
}