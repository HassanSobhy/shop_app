import 'package:bloc/bloc.dart';

/*
* [BlocObserver] for the counter application which
* observes all state changes.
*/

class ShopObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType}, $change');
  }
}