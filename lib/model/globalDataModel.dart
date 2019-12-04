
import 'package:flutter/material.dart';
import 'package:pc_cloud/model/uploadFile.dart';
import 'package:photo_manager/photo_manager.dart';

///
/// @author Liang Wei
/// date 2019-12-03

class GlobalDataModel with ChangeNotifier {
  List<AssetPathEntity> _assetPathEntityList;

  List<AssetPathEntity> get getAssetPathEntityList => _assetPathEntityList;

  List<UploadFile> _uploadingFileList;

  List<UploadFile> get getUploadingFileList => _uploadingFileList;

  int _count = 0;

  int get value => _count;

  void setAssetPathEntityList(List<AssetPathEntity> params) {
    this._assetPathEntityList = params;
    notifyListeners();
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