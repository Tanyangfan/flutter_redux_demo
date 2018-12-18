import 'package:flutter_redux_demo/data/beans/poem.dart';

class FetchPoemAction {}

class FetchPoemSuccessAction {
  final Poem poem;

  FetchPoemSuccessAction(this.poem);
}

class FetchPoemFailAction {}
