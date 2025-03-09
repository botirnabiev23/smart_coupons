import 'package:bloc/bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('Create: ${bloc.runtimeType}');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('Close: ${bloc.runtimeType}');
  }
}
