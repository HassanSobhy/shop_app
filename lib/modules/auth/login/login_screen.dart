import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/home.dart';
import 'package:shop_app/models/login_models.dart';
import 'package:shop_app/modules/auth/login/cubit/login_cubit.dart';
import 'package:shop_app/modules/auth/login/cubit/login_states.dart';
import 'package:shop_app/modules/auth/register/register_screen.dart';
import 'package:shop_app/modules/home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  //Form Key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //TextFormFieldControllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            //Show success message
            buildToastMessage(state.model.message, Colors.green);
            // navigate to home screen.
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
          } else if (state is LoginErrorState) {
            //buildSnackBar(context, state.message);
            //Show error message
            buildToastMessage(state.message, Colors.red);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
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
                          textInputAction:TextInputAction.next,
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
                          textInputAction:TextInputAction.done,
                          keyboardType: TextInputType.text,
                          obscureText: LoginCubit.get(context).isPassword,
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
                            suffixIcon: Icon(LoginCubit.get(context).suffix),
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
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                                    LoginCubit.get(context).userLogin(
                                      loginModel: loginModel,
                                    );
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
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

/*Container buildLoginButton() {
    return Container(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: Text("LOGIN"),
      ),
    );
  }*/

/*Widget buildEmailTextFormField() {
    return TextFormField(
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
    );
  }*/

/*
  Widget buildPasswordTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
*/
