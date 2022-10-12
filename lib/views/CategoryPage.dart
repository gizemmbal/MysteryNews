import 'package:flutter/material.dart';
import 'package:news_app_api/helper/AppBar.dart';
import 'package:news_app_api/helper/NewsForCategory.dart';
import 'package:news_app_api/helper/NewsTile.dart';

class CategoryPage extends StatefulWidget {
  final String category_page;

  CategoryPage({this.category_page});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  var newslist;
  bool _loading = true;

  @override
  void initState() {
    print('111111');
    getNews();
    // TODO: implement initState
    super.initState();
  }

  void getNews() async {
    NewsForCategory news = NewsForCategory();
    await news.getNewsForCategory(widget.category_page);

    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 243, 93, 33),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                //color: Color.fromARGB(255, 139, 139, 139),
                child: Container(
                  margin: EdgeInsets.only(top: 16),
                  child: ListView.builder(
                      itemCount: newslist.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return NewsTile(
                          imgUrl: newslist[index].urlToImage ?? "",
                          title: newslist[index].title ?? "",
                          desc: newslist[index].description ?? "",
                          content: newslist[index].content ?? "",
                          posturl: newslist[index].articleUrl ?? "",
                        );
                      }),
                ),
              ),
            ),
    );
  }
}
