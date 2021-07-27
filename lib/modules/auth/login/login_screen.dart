import 'package:flutter/material.dart';

import 'package:conditional_builder/conditional_builder.dart';
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
  //Form Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //TextFormFieldControllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: Theme.of(context).textTheme.headline4.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      Text("Login now to browse our hot offers"),
                      SizedBox(height: 40),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: emailController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Email Shouldn't be Empty";
                          } else
                            return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        obscureText: LoginBloc.get(context).isPassword,
                        controller: passwordController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Password shouldn't be Empty";
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Password",
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
                      ),
                      SizedBox(height: 32),
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (context) {
                          return Container(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState.validate()) {
                                  LoginModel loginModel = LoginModel(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  );
                                  userLogin(context, loginModel);
                                }
                              },
                              child: Text("LOGIN"),
                            ),
                          );
                        },
                        fallback: (context) => buildLoadingState(),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          TextButton(
                              onPressed: () =>
                                  navigateToRegisterScreen(context),
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void changePasswordIconVisibility(BuildContext context) {
    LoginBloc.get(context).add(ChangePasswordVisibilityEvent());
  }

  void userLogin(BuildContext context, LoginModel loginModel) {
    LoginBloc.get(context).add(UserLoginEvent(loginModel));
  }

  void navigateToHomeScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  void buildSnackBar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$errorMessage"),
      ),
    );
  }

  void navigateToRegisterScreen(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return RegisterScreen();
    }));
  }

  Widget buildLoadingState() {
    return Center(
      child: CircularProgressIndicator(),
    );
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
