import 'package:flutter_redux_demo/redux/states/poem_state.dart';

class AppState {
  final PoemState poemState;

  AppState({this.poemState});

  factory AppState.init() => AppState(
        poemState: PoemState.init(),
      );
}
