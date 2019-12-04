import 'package:flutter/material.dart';
import 'package:pc_cloud/views/app.dart';
import 'package:provider/provider.dart';
import 'model/globalDataModel.dart';

void main() {
  final globalDataModel = GlobalDataModel();
  runApp(ChangeNotifierProvider.value(value: globalDataModel, child: App()));
}