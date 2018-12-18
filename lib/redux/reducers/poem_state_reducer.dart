import 'package:flutter_redux_demo/data/beans/poem.dart';
import 'package:flutter_redux_demo/redux/actions/poem_actions.dart';
import 'package:flutter_redux_demo/redux/states/poem_state.dart';
import 'package:redux/redux.dart';

PoemState poemStateReducer(PoemState state, action) {
  return PoemState(
    poem: poemReducer(state.poem, action),
    isLoading: isLoadingReducer(state.isLoading, action),
  );
}

final poemReducer = combineReducers<Poem>([
  TypedReducer<Poem, FetchPoemSuccessAction>(_fetchPoemSuccess),
]);

Poem _fetchPoemSuccess(Poem poem, FetchPoemSuccessAction action) {
  return action.poem;
}

final isLoadingReducer = combineReducers<bool>([
  TypedReducer<bool, FetchPoemAction>((_, __) {
    return true;
  }),
  TypedReducer<bool, FetchPoemSuccessAction>((_, __) {
    return false;
  }),
  TypedReducer<bool, FetchPoemFailAction>((_, __) {
    return false;
  }),
]);