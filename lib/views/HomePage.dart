import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:news_app_api/helper/Categories.dart';
import 'package:news_app_api/helper/AppBarHome.dart';
import 'package:news_app_api/helper/NewsTile.dart';
import 'package:news_app_api/helper/themes/theme_provider.dart';
import 'package:news_app_api/helper/weather/currentWeather.dart';
import 'package:news_app_api/models/CategoryModel.dart';
import 'package:news_app_api/views/CategoryPage.dart';
import 'package:news_app_api/views/SnakeGame.dart';
import 'package:news_app_api/views/categories_page.dart';
import 'package:news_app_api/views/Settings.dart';
import 'package:news_app_api/views/xoxGame.dart/TicTacToe.dart';
import '../helper/News.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    // final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
    //     ? 'DarkTheme'
    //     : 'LightTheme';

    return Scaffold(
      appBar: MyAppBarHome(),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Color.fromARGB(255, 243, 93, 33),
        overlayOpacity: 0.8,
        foregroundColor: Colors.white,
        spacing: 12,
        spaceBetweenChildren: 12,
        //onOpen: (() => showToast('message...')),
        //closeManually: true,
        children: [
          SpeedDialChild(
            child: Icon(Icons.settings),
            label: 'Settings',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Settings_page()),
            ),
          ),
          SpeedDialChild(
            child: Icon(Icons.category_outlined),
            label: 'Categories',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Categories_page()),
            ),
          ),
          SpeedDialChild(
            child: Icon(Icons.cloud_outlined),
            label: 'Weather',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CurrentWeatherPage()),
            ),
          ),
          SpeedDialChild(
            child: Icon(Icons.gamepad),
            label: 'Snake Game',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SnakeGame()),
            ),
          ),
          SpeedDialChild(
            child: Icon(Icons.gamepad),
            label: 'TicTacToe Game',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TicTacToe()),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: _loading
            ? Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 243, 93, 33),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  //color: my_colors().light_grey,
                  child: Column(
                    children: <Widget>[
                      /*
                      Container(
                        child: DayNightSwitcherIcon(
                          isDarkModeEnabled: isDarkModeEnabled,
                          onStateChanged: (isDarkModeEnabled) {
                            setState(() {
                              this.isDarkModeEnabled = isDarkModeEnabled;
                            });
                          },
                        ),
                      ),
                      */
                      // Container(
                      //   child: Text(
                      //     'hiiiii $text!',
                      //     style: TextStyle(fontSize: 32),
                      //   ),
                      // ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          /*children: [
                            ElevatedButton.icon(
                              //style: ButtonStyle(backgroundColor: Colors.black),

                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CurrentWeatherPage()),
                                );
                              },
                              icon: Icon(
                                //Icons.brush,
                                Icons.cloud,
                                //color: Colors.black,
                              ),
                              label: Text(
                                'Weather',
                                // style: TextStyle(
                                //   color: Colors.black,
                                // ),
                              ),

                              style: ElevatedButton.styleFrom(
                                //backgroundColor: my_colors().dark_grey,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                          ],*/
                        ),
                      ),
/*
                      /// Categories
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 70,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return CategoryCard(
                                imageAssetUrl: categories[index].imageAssetUrl,
                                categoryName: categories[index].categoryName,
                              );
                            }),
                      ),
*/
                      /// News Article
                      Container(
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
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  // Future showToast(String message) async {
  //   await Fluttertoast.cancel();
  //   Fluttertoast.showToast(msg: message, fontSize: 18);
  // }
}

class CategoryCard extends StatelessWidget {
  final String imageAssetUrl, categoryName;

  CategoryCard({this.imageAssetUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryPage(
                      category_page: categoryName.toLowerCase(),
                    )));
      },
      child: Container(
        //color: my_colors().light_grey,
        margin: EdgeInsets.only(right: 14),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: imageAssetUrl,
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black26),
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
