import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';
/* REFERENCES

https://github.com/fluttercommunity/flutter_webview_plugin/issues/484
https://webrtc.github.io/samples/src/content/getusermedia/gum/

https://github.com/kevinbayes/flutter_webview_plugin/blob/master/android/src/main/java/com/flutter_webview_plugin/WebviewManager.java
*/
// String selectedUrl =
//     'https://webrtc.github.io/samples/src/content/getusermedia/gum/'; //'https://flutter.io';
String selectedUrl = "file:///android_asset/flutter_assets/assets/index.html";
// ignore: prefer_collection_literals
final Set<JavascriptChannel> jsChannels = [
  JavascriptChannel(
      name: 'Print',
      onMessageReceived: (JavascriptMessage message) {
        print(message.message);
      }),
].toSet();

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MyApp());
// }

class MalnourishmentPage extends StatelessWidget {
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: selectedUrl,
      permissions:
          "*", //android.permission.CAMERA,android.permission.RECORD_AUDIO,android.permission.VIDEO_CAPTURE,android.permission.AUDIO_CAPTURE,android.permission.MODIFY_AUDIO_SETTINGS
      allowFileURLs: true,
      javascriptChannels: jsChannels,
      mediaPlaybackRequiresUserGesture: false,
      appBar: AppBar(
        title: const Text('Malnourishment App'),
        backgroundColor: Colors.transparent,
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      initialChild: Container(
        color: Colors.white70,
        child: const Center(
          child: Text('Waiting.....'),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF7f9e9f),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                flutterWebViewPlugin.goBack();
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                flutterWebViewPlugin.goForward();
              },
            ),
            IconButton(
              icon: const Icon(Icons.autorenew),
              onPressed: () {
                flutterWebViewPlugin.reload();
              },
            ),
          ],
        ),
      ),
    );
  }
}
