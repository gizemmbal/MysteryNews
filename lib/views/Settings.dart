//ChangeThemeButtonWidget(),

import 'package:news_app_api/helper/themes/change_theme_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:news_app_api/helper/AppBar.dart';
import 'package:news_app_api/helper/Categories.dart';
import 'package:news_app_api/models/CategoryModel.dart';
import '../helper/News.dart';

class Settings_page extends StatefulWidget {
  @override
  _Settings_pageState createState() => _Settings_pageState();
}

class _Settings_pageState extends State<Settings_page> {
  bool _loading;
  var newslist;

  List<CategoryModel> categories = List<CategoryModel>();

  void getNews() async {
    News news = News();
    await news.getNews();
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;
    super.initState();

    categories = getCategories();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ChangeThemeButtonWidget(),
          ],
        ),
      ),
    );
  }
}
