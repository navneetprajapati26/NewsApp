import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/services/NewsServices.dart';
import 'package:news_app/util/theem/colours.dart';
import 'package:provider/provider.dart';

import '../util/theem/text_style.dart';
import 'news_Screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(
          'News App',
          style: h2HeadingTextStyle,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                newsProvider.getTopHeadlines();
              },
              child: const Text("Load news"),
            ),
          )
        ],
        backgroundColor: background,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: newsProvider.articles.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      newsProvider.getIndex(index);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewsScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                      left: 4, bottom: 16, top: 4),
                                  child: Text(
                                    "By",
                                    style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        newsProvider.articles[index].author,
                                        style: h1HeadingTextStyle,
                                      ),
                                      Text(
                                        newsProvider
                                            .articles[index].publishedAt,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black38),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            //todo :Main image
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 8,
                                right: 4,
                                left: 4,
                              ),
                              child: Text(
                                newsProvider.articles[index].title,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 8,
                                bottom: 8,
                                right: 4,
                                left: 4,
                              ),
                              child: Text(
                                  newsProvider.articles[index].description),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      newsProvider.articles[index].urlToImage,
                                      //fit: BoxFit.fill,
                                    )),
                              ),
                            ),
                            //todo : content
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 8,
                                right: 4,
                                left: 4,
                              ),
                              child: Text(
                                newsProvider.articles[index].content,
                                style: const TextStyle(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
