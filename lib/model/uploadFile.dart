import 'dart:io';

/// 上传文件model
/// @author Liang Wei
/// date 2019-12-02
class UploadFile {
  File file;

  String fileName;

  String filePath;

  double progress;

  UploadFile({this.progress, this.fileName, this.file, this.filePath});
}
