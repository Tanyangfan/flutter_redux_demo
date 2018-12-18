import 'package:flutter/material.dart';
import 'package:flutter_redux_demo/data/beans/poem.dart';

class PoemPage extends StatelessWidget {
  final Poem poem;
  final bool isLoading;
  final Function() onRefresh;

  const PoemPage({Key key, this.poem, this.isLoading, this.onRefresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.only(left: 50.0, top: 50.0, right: 50.0),
        child: isLoading
            ? new CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
              )
            : new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text(poem.title),
                  new Text(poem.author),
                  new Text(poem.text),
                  const SizedBox(height: 45.0),
                  new RaisedButton(
                    onPressed: onRefresh,
                    child: new Text('下一首'),
                  ),
                ],
              ),
      ),
      appBar: new AppBar(
        centerTitle: true,
        title: new Text('诗歌'),
      ),
    );
  }
}
