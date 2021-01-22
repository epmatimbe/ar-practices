import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'home_page.dart';

void main() {
  runApp(new MaterialApp(
        title: 'AR Experimental',
    debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 14,
      navigateAfterSeconds: new MyHomePage(
        title: 'AR Experimental',
      ),
      title: new Text(
        'AR Experimental',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.deepPurple,),
      ),
      // image: new Image.network(
      //     'https://flutter.io/images/catalog-widget-placeholder.png'),
      backgroundColor: Colors.white,
      loaderColor: Colors.deepPurple,
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Welcome In SplashScreen Package"),
        automaticallyImplyLeading: false,
      ),
      body: new Center(
        child: new Text(
          "Succeeded!",
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
        ),
      ),
    );
  }
}

