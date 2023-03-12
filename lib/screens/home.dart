import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/NewsProvider.dart';
import '../provider/ThemeProvider.dart';
import '../util/loding.dart';
import 'news_Screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    setState(() {
      newsProvider.getTopHeadlines();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final newsProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'News App',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<ThemeProvider>(
                builder: (context, newsProvider, child) => IconButton(
                      onPressed: () {
                        newsProvider.changeTheme();
                      },
                      icon: (newsProvider.themeMode == ThemeMode.dark)
                          ? Icon(
                              Icons.sunny,
                              color: Colors.yellow,
                            )
                          : Icon(
                              Icons.nights_stay_rounded,
                              color: Colors.blueAccent,
                            ),
                    )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<NewsProvider>(
                builder: (context, newsProvider, child) => TextButton(
                      onPressed: () {
                        newsProvider.getTopHeadlines();
                      },
                      child: const Text("Load news"),
                    )),
          )
        ],
        // backgroundColor: background,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<NewsProvider>(
              builder: (context, newsProvider, child) => newsProvider
                      .articles.isEmpty
                  ? const Loading()
                  : Expanded(
                      child: ListView.builder(
                        itemCount: newsProvider.articles.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              newsProvider.getIndex(index);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NewsScreen()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 4, bottom: 16, top: 4),
                                          child: Text(
                                            "By",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayLarge,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                newsProvider
                                                    .articles[index].author,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              ),
                                              Text(
                                                newsProvider.articles[index]
                                                    .publishedAt,
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black38),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 8,
                                        bottom: 8,
                                        right: 4,
                                        left: 4,
                                      ),
                                      child: Text(
                                        newsProvider.articles[index].title,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 8,
                                        bottom: 8,
                                        right: 4,
                                        left: 4,
                                      ),
                                      child: Text(newsProvider
                                          .articles[index].description),
                                    ),
                                    //todo :Main image
                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.network(
                                              newsProvider
                                                  .articles[index].urlToImage,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return const Center(
                                                    child: SizedBox(
                                                        height: 400,
                                                        width: 400,
                                                        child: Loading()));
                                              },
                                              fit: BoxFit.fill,
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
            ),
          ],
        ),
      ),
    );
  }
}
