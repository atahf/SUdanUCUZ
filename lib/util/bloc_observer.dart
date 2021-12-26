
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBlocObserver extends BlocObserver{

  @override
  void onEvent(Bloc bloc,Object ? event){
    super.onEvent(bloc, event);
    print(event);
  }



  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // TODO: implement onError
    super.onError(bloc, error, stackTrace);
    print(error);
  }
}