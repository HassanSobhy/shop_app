import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shop_app/models/login/login_model.dart';
import 'package:shop_app/modules/auth/login/bloc/login_bloc.dart';
import 'package:shop_app/modules/auth/login/bloc/login_repository.dart';

import 'package:shop_app/modules/auth/register/register_screen.dart';
import 'package:shop_app/modules/home/home_screen.dart';
import '../../bloc/login_event.dart';
import '../../bloc/login_state.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String emailValidateText;
  String passwordValidateText;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(LoginRepository()),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              buildToastMessage(state.model.message, Colors.green);
              navigateToHomeScreen(context);
            } else if (state is LoginErrorState) {
              buildToastMessage(state.message, Colors.red);
            } else if (state is LoginNavigationToRegisterScreenState) {
              navigateToRegisterScreen(context);
            }
          },
          builder: (context, state) {
            if (state is LoginInitialState) {
              return loginFormWidget(context);
            } else if (state is LoginLoadingState) {
              return loadingWidget();
            } else if (state is LoginEmailEmptyFormatState) {
              return loginFormWidget(context,
                  emailValidateText: state.emailValidationText);
            } else if (state is LoginEmailInvalidFormatState) {
              return loginFormWidget(context,
                  emailValidateText: state.emailValidationText);
            } else if (state is LoginEmailFormatCorrectState) {
              return loginFormWidget(context);
            } else if (state is LoginPasswordEmptyFormatState) {
              return loginFormWidget(context,
                  passwordValidateText: state.passwordValidationText);
            } else if (state is LoginPasswordInvalidFormatState) {
              return loginFormWidget(context,
                  passwordValidateText: state.passwordValidationText);
            } else if (state is LoginPasswordFormatCorrectState) {
              return loginFormWidget(context);
            } else {
              return loginFormWidget(context);
            }
          },
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  Widget loginFormWidget(BuildContext context,
      {String emailValidateText, String passwordValidateText}) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Login",
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Text("Login now to browse our hot offers"),
            SizedBox(height: 40),
            emailTextFieldWidget(emailValidateText),
            sizedBoxSeparatorWidget(),
            passwordTextFieldWidget(context, passwordValidateText),
            sizedBoxSeparatorWidget(),
            signInButtonWidget(context),
            sizedBoxSeparatorWidget(),
            doNotHaveAnAccountButtonWidget(context)
          ],
        ),
      ),
    );
  }

  Widget loadingWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget sizedBoxSeparatorWidget() => SizedBox(height: 16);

  Widget emailTextFieldWidget(String emailValidateText) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        errorText: emailValidateText,
        prefixIcon: Icon(Icons.email_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget passwordTextFieldWidget(
      BuildContext context, String passwordValidateText) {
    return TextFormField(
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      obscureText: LoginBloc.get(context).isPassword,
      controller: passwordController,
      decoration: InputDecoration(
        labelText: "Password",
        errorText: passwordValidateText,
        prefixIcon: Icon(Icons.lock_outline_rounded),
        suffixIcon: IconButton(
          icon: Icon(LoginBloc.get(context).suffix),
          onPressed: () {
            changePasswordIconVisibility(context);
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget signInButtonWidget(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          signIn(context);
        },
        child: Text("LOGIN"),
      ),
    );
  }

  Widget doNotHaveAnAccountButtonWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account?"),
        TextButton(
            onPressed: () =>
                LoginBloc.get(context).add(NavigationToRegisterScreenEvent()),
            child: Text(
              "Register",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            )),
      ],
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper methods ////////////////////////
  ///////////////////////////////////////////////////////////

  void signIn(BuildContext context) {
    LoginModel loginModel = LoginModel(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    userLogin(context, loginModel);
  }

  void changePasswordIconVisibility(BuildContext context) {
    LoginBloc.get(context).add(ChangePasswordVisibilityEvent());
  }

  void userLogin(BuildContext context, LoginModel loginModel) {
    LoginBloc.get(context).add(UserLoginEvent(loginModel));
  }

  Future<void> navigateToHomeScreen(BuildContext context) async {
    await Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  void buildSnackBar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$errorMessage"),
      ),
    );
  }

  Future<void> navigateToRegisterScreen(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return RegisterScreen();
    }));
  }

  void buildToastMessage(String message, Color color) {
    Fluttertoast.showToast(
        msg: "$message",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
