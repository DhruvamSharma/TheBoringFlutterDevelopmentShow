import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:the_boring_flutter_dev_show/src/article.dart';
import 'package:the_boring_flutter_dev_show/src/news_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  final hnBloc = HackerNewsBloc();
  runApp(MyApp(hnBloc: hnBloc));
}

class MyApp extends StatelessWidget {
  final HackerNewsBloc hnBloc;
  MyApp({this.hnBloc});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Hacker News', hnBloc: hnBloc),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.hnBloc}) : super(key: key);
  final String title;
  final HackerNewsBloc hnBloc;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<UnmodifiableListView<Article>> (
          initialData: UnmodifiableListView<Article>([]),
          stream: widget.hnBloc.article,
          builder: (context, snapshot) => ListView(
            children: snapshot.data.map(_buildItem).toList(),
          ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.domain),
              title: Text('Top Stories'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.new_releases),
              title: Text('New Stories'),
            ),
          ],
        onTap: (index) {
            if (index == 0) {
              widget.hnBloc.storyTypeSink.add(StoryType.topStories);
            } else {
              widget.hnBloc.storyTypeSink.add(StoryType.newStories);
            }
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildItem(Article e) {
    return Padding(
      key: Key(e.title?? 'null'),
      padding: const EdgeInsets.all(16.0),
      child: ExpansionTile(
        title: Text(
          e.title?? 'null',
          style: TextStyle(fontSize: 16),
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('${e.by?? ''}'),
              IconButton(
                icon: Icon(Icons.launch),
                onPressed: () async {
                  if (await canLaunch(e.url?? '')) {
                    launch(e.url?? '');
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
