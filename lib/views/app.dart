import 'package:flutter/material.dart';
import 'package:pc_cloud/component/customerIcon24.dart';
import 'package:pc_cloud/model/globalDataModel.dart';
import 'package:pc_cloud/views/uploading.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'fileAndFolder.dart';
import 'folder.dart';
import 'home.dart';
import 'imageShow.dart';
import 'my.dart';

///
/// @author Liang Wei
/// date 2019-12-02

class App extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<App> with SingleTickerProviderStateMixin {
  TabController _controller;
  int _currentIndex = 0;

  var bottomTabs = [
    BottomNavigationBarItem(
        title: Text('首页'), icon: CustomerIcon24(Icons.home)),
    BottomNavigationBarItem(
        title: Text('文件'), icon: CustomerIcon24(Icons.sd_storage)),
    BottomNavigationBarItem(
        title: Text('浏览'), icon: CustomerIcon24(Icons.ac_unit)),
    BottomNavigationBarItem(
        title: Text('上传'), icon: CustomerIcon24(Icons.backup)),
    BottomNavigationBarItem(
        title: Text('我的'), icon: CustomerIcon24(Icons.account_circle)),
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: bottomTabs.length, vsync: this);
    getPhotoManager();
  }

  // 获取相册权限
  void getPhotoManager() async {
    var result = await PhotoManager.requestPermission();
    if (result) {
      List<AssetPathEntity> list = await PhotoManager.getAssetPathList();
      setAssetPathEntity(list);
    }
  }

  void setAssetPathEntity(List<AssetPathEntity> list) {
    final _globalData = Provider.of<GlobalDataModel>(context);
    _globalData.setAssetPathEntityList(list);
  }

  _bottomNavBarClick(index) {
    setState(() {
      _currentIndex = index;
    });
    _controller.animateTo(_currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('PC Cloud'),
        ),
        body: TabBarView(
            physics: NeverScrollableScrollPhysics(), //禁止滚动
            controller: _controller,
            children: [
              Home(),
              Folder(),
              GridPhoto(),
              Uploading(),
              My(),
            ]),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: _bottomNavBarClick,
            items: bottomTabs),
      ),
    );
  }
}
