import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewPage extends StatelessWidget {
  final String url;

  const WebViewPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Web Page'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (selected) {
              switch (selected) {
                case 'Copy url':
                  Clipboard.setData(ClipboardData(text: url));
                  Fluttertoast.showToast(msg: "Copied url!");
                  break;
                case 'Open In Browser/Related App':
                  launchUrl(
                    Uri.parse(url),
                  );
                  break;
                default:
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Copy url', 'Open In Browser/Related App'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(url),
        ),
      ),
    );
  }
}
