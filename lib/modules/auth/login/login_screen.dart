import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shop_app/models/login/login_model.dart';
import 'package:shop_app/modules/auth/login/bloc/login_bloc.dart';
import 'package:shop_app/modules/auth/login/bloc/login_repository.dart';
import 'package:shop_app/modules/auth/register/register_screen.dart';
import 'package:shop_app/modules/home/home_screen.dart';
import 'bloc/login_event.dart';
import 'bloc/login_state.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String emailErrorMessage;
  String passwordErrorMessage;

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
              } else {
                return loginFormWidget(context);
              }
            },
          ),
        ));
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  Widget loginFormWidget(BuildContext context) {
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
            const Text("Login now to browse our hot offers"),
            const SizedBox(height: 40),
            emailTextFieldWidget(),
            sizedBoxSeparatorWidget(),
            passwordTextFieldWidget(context),
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
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget sizedBoxSeparatorWidget() => const SizedBox(height: 16);

  Widget emailTextFieldWidget() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        errorText: emailErrorMessage,
        prefixIcon: const Icon(Icons.email_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget passwordTextFieldWidget(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      obscureText: LoginBloc.get(context).isPassword,
      controller: passwordController,
      decoration: InputDecoration(
        labelText: "Password",
        errorText: passwordErrorMessage,
        prefixIcon: const Icon(Icons.lock_outline_rounded),
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
        onPressed: () => signIn(context),
        child: const Text("LOGIN"),
      ),
    );
  }

  Widget doNotHaveAnAccountButtonWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?"),
        TextButton(
            onPressed: () => LoginBloc.get(context)
                .add(const NavigationToRegisterScreenEvent()),
            child: const Text(
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
    final LoginModel loginModel = LoginModel(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    userLogin(context, loginModel);
  }

  void changePasswordIconVisibility(BuildContext context) {
    LoginBloc.get(context).add(const ChangePasswordVisibilityEvent());
  }

  void userLogin(BuildContext context, LoginModel loginModel) {
    LoginBloc.get(context).add(UserLoginEvent(loginModel));
  }

  Future<void> navigateToHomeScreen(BuildContext context) async {
    await Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  void buildSnackBar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
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
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
