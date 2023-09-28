import 'dart:convert';

import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import 'package:url_launcher/url_launcher.dart';

import 'news_model.dart';

//import 'models/model.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

//late Map<String, dynamic> data;
Future<News> fetchData() async {
  final response = await http.get(Uri.parse(
      'https://newsapi.org/v2/everything?q=apple&from=2023-08-28&to=2023-08-28&sortBy=popularity&apiKey=0ab8ec21c0e24b119d2241aea0ba4173'));

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON.
    // data = json.decode(response.body);
    // print(data.toString() + " lol");

    return News.fromJson(json.decode(response.body));

    // return data;
  } else {
    print("good");
    // If the server did not return a 200 OK response, throw an exception.
    throw Exception('Failed to load data');
  }
}

class _NewsPageState extends State<NewsPage> {
  List<News> news = [];
  late News samachar;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: Icon(
        //   Icons.menu,
        //   color: Colors.black,
        // ),
        title: Text(
          'News updates',
          style: TextStyle(color: Colors.black),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.search_outlined,
        //       color: Colors.black,
        //     ),
        //   ),
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.bookmark_border_outlined,
        //       color: Colors.black,
        //     ),
        //   ),
        // ],
      ),
      body: FutureBuilder<News>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var news = snapshot.data;
            return ListView.builder(
                shrinkWrap: true,
                itemCount: news!.articles!.length,
                itemBuilder: (context, index) {
                  //Get.put(Pjcontroller()).length = news.length;
                  //print(data["articles"][index]['title']);
                  ///////////////////---------------------------------------------------------
                  return SlideInUp(
                    delay: Duration(milliseconds: 1500),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: InkWell(
                            onTap: () {
                              launchUrl(
                                Uri.parse(
                                  news.articles![index].url.toString(),
                                ),
                                mode: LaunchMode.inAppWebView,
                              );
                            },
                            child: Container(
                              decoration:
                                  BoxDecoration(color: Colors.green[50]),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      child: Container(
                                        height: height * 0.18,
                                        width: width * 0.35,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            news.articles![index].urlToImage
                                                .toString(),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.02,
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          width: width * 0.55,
                                          child: Text(
                                            //  'Apple Will Finally Pay for Throttling iPhones  With ‘Batterygate’ Settlement',
                                            //  " ${news[0].articles[index].title}",
                                            // data["articles"][index]['title'],
                                            news.articles![index].title
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        // SizedBox(
                                        //   width: width * 0.55,
                                        //   child: Text(
                                        //     samachar.articles[index].description,
                                        //     style: TextStyle(color: Colors.black45),
                                        //   ),
                                        // ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        SizedBox(
                                          width: width * 0.55,
                                          child: Text(
                                            news.articles![index].description
                                                .toString(),
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        SizedBox(
                                          width: width * 0.55,
                                          child: Text(
                                            news.articles![index].publishedAt
                                                .toString(),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            );
          }
        },
      ),
    );
  }

  // Future<List<News>> getdata() async {
  //   final Response = await http.get(
  //     Uri.parse(
  //         'https://newsapi.org/v2/everything?q=apple&from=2023-08-28&to=2023-08-28&sortBy=popularity&apiKey=0ab8ec21c0e24b119d2241aea0ba4173'),
  //   );

  //   var data = jsonDecode(Response.body.toString());

  //   if (Response.statusCode == 200) {
  //     // for (Map<String, dynamic> index in data) {

  //     // }

  //     samachar = (newsFromJson(Response.body));
  //     //print(nudes.articles[0].author);

  //     return news;
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }
}
