import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_demo/data/beans/poem.dart';
import 'package:flutter_redux_demo/redux/actions/poem_actions.dart';
import 'package:flutter_redux_demo/redux/states/app_state.dart';
import 'package:flutter_redux_demo/ui/poem/peom_page.dart';
import 'package:redux/redux.dart';

class PoemViewModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return new PoemPage(
          poem: vm.poem,
          isLoading: vm.isLoading,
          onRefresh: vm.onRefresh,
        );
      },
    );
  }
}

class _ViewModel {
  final Poem poem;
  final bool isLoading;
  final Function() onRefresh;

  _ViewModel({this.poem, this.isLoading, this.onRefresh});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
        poem: store.state.poemState.poem,
        isLoading: store.state.poemState.isLoading,
        onRefresh: () {
          store.dispatch(FetchPoemAction());
        });
  }
}
