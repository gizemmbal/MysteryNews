import 'package:flutter/material.dart';

Widget MyAppBarHome() {
  //BuildContext context;
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          // child: Icon(
          //   Icons.share,
          //   color: Colors.transparent,
          //   //color: Theme.of(context).primaryColor,
          //   //color: context.dependOnInheritedWidgetOfExactType<ThemeProvider>(),
          // )
        ),
        Text(
          "Mystery",
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic),
        ),
        Text(
          "News",
          style: TextStyle(
              color: Color.fromARGB(255, 243, 93, 33),
              fontWeight: FontWeight.w600),
        ),
        Container(
            child: Icon(
          Icons.share,
          color: Colors.transparent,
          //color: Theme.of(context).primaryColor,
          //color: context.dependOnInheritedWidgetOfExactType<ThemeProvider>(),
        )),
      ],
    ),

    actions: [
      //ChangeThemeButtonWidget(),

      /*Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: PopupMenuButton(
          onSelected: (value) => CurrentWeatherPage(),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          //color: my_colors().dark_grey,
          itemBuilder: (context) => [
            PopupMenuItem(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CurrentWeatherPage()));
              },
              child: Row(
                children: [Text('Weather')],
              ),
            ),
            PopupMenuItem(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryPage(
                              category_page:
                                  getCategories().elementAt(0).categoryName,
                            )));
              },
              child: Row(
                children: [Text(getCategories().elementAt(0).categoryName)],
              ),
            ),
            PopupMenuItem(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Try()));
                },
                child: Row(
                  children: [Text(getCategories().elementAt(1).categoryName)],
                )),
            PopupMenuItem(
              child: Row(
                children: [
                  Text(getCategories().elementAt(2).categoryName),
                  Icon(Icons.add_circle_outlined)
                ],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryPage(
                              category_page: 'general',
                            )));
              },
            ),
            PopupMenuItem(
                /*
              onTap: (){
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return HomePage();
                          },
                        ),
                      );
                    });
                  },
                  */
                child: Row(
              children: [Text(getCategories().elementAt(3).categoryName)],
            )),
            PopupMenuItem(
                child: Row(
              children: [Text(getCategories().elementAt(4).categoryName)],
            )),
            PopupMenuItem(
                child: Row(
              children: [Text(getCategories().elementAt(5).categoryName)],
            )),
            PopupMenuItem(
                child: Row(
              children: [Text(getCategories().elementAt(6).categoryName)],
            )),
          ],
        ),
      )*/
    ],
    /*
    //widget is for allining the title
    actions: <Widget>[
      Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Icon(
            Icons.share,
          ))
         
    ],
    */
    //backgroundColor: my_colors().dark_grey,
    elevation: 0.0,
  );
}
