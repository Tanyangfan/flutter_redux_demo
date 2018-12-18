import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_demo/redux/actions/poem_actions.dart';
import 'package:flutter_redux_demo/redux/middlewares/poem_middleware.dart';
import 'package:flutter_redux_demo/redux/reducers/app_state_reducer.dart';
import 'package:flutter_redux_demo/redux/states/app_state.dart';
import 'package:flutter_redux_demo/ui/poem/poem_viewmodel.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final store = new Store<AppState>(
    appStateReducer,
    initialState: AppState.init(),
    middleware: []
      ..addAll(createPoemMiddleware())
      ..add(LoggingMiddleware.printer()),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
          // counter didn't reset back to zero; the application is not restarted.
          primaryColor: const Color(0xFF4254BC),
          primaryColorDark: const Color(0xFF4254BC),
          buttonColor: Theme.of(context).primaryColor,
          scaffoldBackgroundColor: Colors.white,

          buttonTheme: const ButtonThemeData(
            buttonColor: const Color(0xFF4254BC),
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        home: new StoreBuilder<AppState>(
          onInit: (store) => store.dispatch(FetchPoemAction()),
          builder: (context, store) {
            return new PoemViewModel();
          },
        ),
      ),
    );
  }
}
