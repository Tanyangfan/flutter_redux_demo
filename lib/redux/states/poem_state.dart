import 'package:flutter_redux_demo/data/beans/poem.dart';
import 'package:meta/meta.dart';

@immutable
class PoemState {
  final Poem poem;
  final bool isLoading;

  PoemState({this.poem, this.isLoading});

  factory PoemState.init() => PoemState(
        poem: null,
        isLoading: false,
      );
}
