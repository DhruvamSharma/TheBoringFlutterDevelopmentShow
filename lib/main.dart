import 'package:flutter/material.dart';
import 'package:the_boring_flutter_dev_show/json_parsing.dart';
import 'package:the_boring_flutter_dev_show/src/data_provider.dart';
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
  List<int> _ids = [];
  DataProvider _provider = DataProvider();

  @override
  void initState() {
    _provider.getNewsIds().then((List<int> value) {
      _ids = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: _ids.map((i) =>
          FutureBuilder<Article> (
            future: _provider.getNewsArticle(i),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _buildItem(snapshot.data);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        )
        ).toList(),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildItem(Article e) {
    return Padding(
      key: Key(e.title),
      padding: const EdgeInsets.all(16.0),
      child: ExpansionTile(
        title: Text(
          e.title,
          style: TextStyle(fontSize: 24),
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('${e.by}'),
              IconButton(
                icon: Icon(Icons.launch),
                onPressed: () async {
                  if (await canLaunch(e.url)) {
                    launch(e.url);
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
