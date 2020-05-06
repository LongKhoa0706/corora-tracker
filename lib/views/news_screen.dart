import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statisticalcorona/provider/news_provider.dart';
import 'package:statisticalcorona/views/detail_news_screen.dart';
import 'package:statisticalcorona/widget/news/card_news.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<NewsProvider>(context,listen: false).getAllNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "News",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 30,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Ger latest global updates on Covid19",
                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<NewsProvider>(
                builder: (BuildContext context, NewsProvider value,
                    Widget child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: value.arrNews.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) =>
                                DetailNewsScreen(
                                  urlNews: value.arrNews[index].url,),),);
                        },
                        child: CardNews(
                          urlImage: value.arrNews[index].urlToImage,
                          title: value.arrNews[index].title,
                          dateTime: value.arrNews[index].publishedAt,
                          author: value.arrNews[index].author,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
