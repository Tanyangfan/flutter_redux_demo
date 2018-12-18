import 'package:flutter_redux_demo/redux/reducers/poem_state_reducer.dart';
import 'package:flutter_redux_demo/redux/states/app_state.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    poemState: poemStateReducer(state.poemState, action),
  );
}
