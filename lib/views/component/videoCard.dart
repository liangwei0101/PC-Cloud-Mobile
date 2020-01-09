import 'dart:async';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:pc_cloud/views/component/video.dart';
import 'package:video_player/video_player.dart';

/// video封装
/// @author Liang Wei
/// date 2020-01-08

File _file;

class VideoComponent extends StatefulWidget {
  VideoComponent(File file){
    _file = file;
  }

  File file;
  static const String routeName = '/video';

  @override
  _VideoDemoState createState() => _VideoDemoState();
}

final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

Future<bool> isIOSSimulator() async {
  return Platform.isIOS && !(await deviceInfoPlugin.iosInfo).isPhysicalDevice;
}

class _VideoDemoState extends State<VideoComponent> with SingleTickerProviderStateMixin {

  final VideoPlayerController butterflyController = VideoPlayerController.file(_file);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Completer<void> connectedCompleter = Completer<void>();
  bool isSupported = true;
  bool isDisposed = false;

  @override
  void initState() {
    super.initState();

    Future<void> initController(VideoPlayerController controller, String name) async {
      print('> VideoDemo initController "$name" ${isDisposed ? "DISPOSED" : ""}');
      controller.setLooping(true);
      controller.setVolume(0.0);
      controller.play();
      await connectedCompleter.future;
      await controller.initialize();
      if (mounted) {
        print('< VideoDemo initController "$name" done ${isDisposed ? "DISPOSED" : ""}');
        setState(() { });
      }
    }

    initController(butterflyController, 'butterfly');
    isIOSSimulator().then<void>((bool result) {
      isSupported = !result;
    });
  }

  @override
  void dispose() {
    print('> VideoDemo dispose');
    isDisposed  = true;
    butterflyController.dispose();
    print('< VideoDemo dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: isSupported
          ? ConnectivityOverlay(
        child: Scrollbar(
          child: ListView(
            children: <Widget>[
              VideoCard(
                title: 'Butterfly',
                subtitle: '… flutters by',
                controller: butterflyController,
              ),
            ],
          ),
        ),
        connectedCompleter: connectedCompleter,
        scaffoldKey: scaffoldKey,
      )
          : const Center(
        child: Text(
          'Video playback not supported on the iOS Simulator.',
        ),
      ),
    );
  }
}