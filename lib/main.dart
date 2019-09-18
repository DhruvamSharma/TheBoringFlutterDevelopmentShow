import 'package:flutter/material.dart';
import 'package:boring_app/src/Article.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Article> _articles = articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _articles.removeAt(0);
          });
          print(_articles.length);
        },
        child: ListView(
          children: _articles.map(_buildItem).toList(),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildItem(Article e) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: Text(
          e.text,
          style: TextStyle(fontSize: 18),
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('${e.commentCount} comments'),
              IconButton(icon: Icon(Icons.launch), onPressed: loadUrl,)
            ],
          ),
        ],
//        onTap: () async {

//        },
      ),
    );
  }

  void loadUrl () async {
    if (await canLaunch('https://gamezop.com')) {
            launch('https://gamezop.com');
    }
  }
}
