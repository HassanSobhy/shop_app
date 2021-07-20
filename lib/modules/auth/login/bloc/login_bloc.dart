import 'package:bloc/bloc.dart';
import 'package:shop_app/network/repository/login_repository.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  final LoginRepository loginRepository;
  LoginBloc(this.loginRepository) : super(LoginInitialState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event)async* {
    if(event is UserLoginEvent){
      yield LoginLoadingState();
      yield await loginRepository.signInWithEmailAndPassword(event.loginModel);
    }
  }

}