import 'package:flutter_redux_demo/data/beans/poem.dart';
import 'package:flutter_redux_demo/data/demo_repository.dart';
import 'package:flutter_redux_demo/redux/actions/poem_actions.dart';
import 'package:flutter_redux_demo/redux/states/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createPoemMiddleware() {
  return [
    TypedMiddleware<AppState, FetchPoemAction>(_fetchPoem()),
  ];
}

Middleware<AppState> _fetchPoem() {
  return (Store<AppState> store, action, NextDispatcher next) {
    DemoRepository().fetchPoem().then((response) {
      var poem = Poem.fromJson(response.data);
      store.dispatch(FetchPoemSuccessAction(poem));
    });

    next(action);
  };
}
