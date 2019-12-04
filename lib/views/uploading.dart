import 'package:flutter/material.dart';
import 'package:pc_cloud/model/globalDataModel.dart';
import 'package:pc_cloud/utils/httpUtil.dart';
import 'package:provider/provider.dart';

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
    final _globalData = Provider.of<GlobalDataModel>(context);

    void uploadFile() async {
      var assetPathEntityList = _globalData.getAssetPathEntityList[1];
      var imageList = await assetPathEntityList.assetList;
      for (var i = 0; i < imageList.length; i++) {
        var aa = await imageList[i].file;
        var aa1 = await HttpUtil.uploadFiles(aa);
      }
    }

    return Scaffold(
      body: Center(
        child: Text('上传'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          uploadFile();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
