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
    final _maxUploadAmount = 10;
    final _globalData = Provider.of<GlobalDataModel>(context);

    void uploadFile() async {
      var assetPathEntityList = _globalData.getAssetPathEntityList[1];
      var imageList = await assetPathEntityList.assetList;

      for (var i = 0; i < imageList.length; i++) {
        // 如果文件数 > 最大上次文件数
        if (i + _maxUploadAmount < imageList.length) {
          var futureTaskList = new List<Future>();
          // 开启最大上传数------------代码开始
          for(var j=0;j<_maxUploadAmount;j++){
            var fileTemp = await imageList[i].file;
            Future<dynamic> task = HttpUtil.uploadFiles(fileTemp);
            i++;
            futureTaskList.add(task);
          }
          Future.wait(futureTaskList);
          // 开启最大上传数------------代码结束
        } else {
          var file = await imageList[i].file;
          HttpUtil.uploadFiles(file);
        }
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
