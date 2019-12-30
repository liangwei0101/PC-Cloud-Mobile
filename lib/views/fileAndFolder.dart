import 'package:flutter/material.dart';
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

    @override
    void initState() {
      super.initState();
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

loadFolder(
    AssetPathEntity assetPathEntity, List<AssetEntity> assetEntityList) async {
  var list = await assetPathEntity.assetList;
  for (var item in list) {
    assetEntityList.add(item);
  }
}

Widget _buildFolderItem(AssetPathEntity assetPathEntity, BuildContext context) {
  return InkWell(
      child: Container(
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 0.5, color: Color(0xffe5e5e5))),
          ),
          child:
//          CheckboxListTile(
//            secondary: Image.asset('assets/images/folder.png'),
//            title: Row(
//              children: <Widget>[
//                Expanded(
//                    child: Text(
//                  assetPathEntity.name,
//                  style: TextStyle(fontSize: 14),
//                )),
//                Text(
//                  '${assetPathEntity.assetCount}项',
//                  style: TextStyle(color: Colors.grey, fontSize: 13),
//                ),
//
//              ],
//            ),
//            value: true,
//
//          )
      ListTile(
        leading: Image.asset('assets/images/folder.png'),
        title: Row(
          children: <Widget>[
            Expanded(child: Text(assetPathEntity.name, style: TextStyle(fontSize: 14),)),
            Text(
              '${assetPathEntity.assetCount}项',
              style: TextStyle(color: Colors.grey,fontSize: 13),
            )
          ],
        ),
        trailing: Icon(Icons.check,size: 12,color: Colors.green,),
        onLongPress: (){
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) => const _DemoDrawer(),
          );
        },
//        trailing: Icon(Icons.check,size: 12,color: Colors.green,),
      ),
          ));
}

class _DemoDrawer extends StatelessWidget {
  const _DemoDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: const <Widget>[
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search'),
          ),
          ListTile(
            leading: Icon(Icons.threed_rotation),
            title: Text('3D'),
          ),
        ],
      ),
    );
  }
}