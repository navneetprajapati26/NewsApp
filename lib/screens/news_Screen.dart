import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../provider/NewsProvider.dart';
import '../util/loding.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late WebViewController controller;
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.keyboard_arrow_left_rounded,
            color: Colors.black,
          ),
        ),
        //backgroundColor: background,
        title: Text(
          newsProvider.articles[newsProvider.index].title,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: (kIsWeb)
              ? const Text("Sorry this Screen only can rendered in Android and iOS")
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          WebView(
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            javascriptMode: JavascriptMode.unrestricted,
                            initialUrl:
                                newsProvider.articles[newsProvider.index].url,
                            onWebViewCreated: (controller) {
                              this.controller = controller;
                            },
                            onPageStarted: (started) {
                              setState(() {
                                isLoading = false;
                              });
                            },
                          ),
                          isLoading
                              ? const Center(
                                  child: Loading(),
                                )
                              : Stack(),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
