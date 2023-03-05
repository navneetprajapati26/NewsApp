import 'package:flutter/material.dart';
import 'package:news_app/util/theem/colours.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../services/NewsServices.dart';
import '../util/theem/text_style.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late WebViewController controller;
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.keyboard_arrow_left_rounded,
            color: Colors.black,
          ),
        ),
        backgroundColor: background,
        title: Text(
          newsProvider.articles[newsProvider.index].title,
          style: h2HeadingTextStyle,
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: newsProvider.articles[newsProvider.index].url,
                  onWebViewCreated: (controller) {
                    this.controller = controller;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
