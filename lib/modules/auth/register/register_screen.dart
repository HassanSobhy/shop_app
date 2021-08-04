import 'package:flutter/material.dart';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shop_app/models/register_model.dart';
import 'package:shop_app/modules/auth/login/ui/screens/login_screen.dart';
import 'package:shop_app/modules/auth/register/cubit/register_states.dart';
import 'package:shop_app/modules/home/home_screen.dart';
import 'cubit/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  //Form Key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //TextFormFieldControllers
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
            if (state is RegisterSuccessState) {
              buildToastMessage(state.model.message, Colors.green);
              navigateToHomeScreen(context);
            } else if (state is RegisterErrorState) {
              buildToastMessage(state.message, Colors.red);
            }
          },
          builder: (context, state) {
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Register",
                          style: Theme.of(context).textTheme.headline4.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Text("Register now to browse our hot offers"),
                        SizedBox(height: 40),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: userNameController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Username Shouldn't be Empty";
                            } else
                              return null;
                          },
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "Username",
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
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
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          obscureText: RegisterCubit.get(context).isPassword,
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
                            suffixIcon: Icon(RegisterCubit.get(context).suffix),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: phoneController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Phone Shouldn't be Empty";
                            } else
                              return null;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: "Phone",
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        SizedBox(height: 32),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) {
                            return Container(
                              height: 45,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState.validate()) {
                                    RegisterModel registerModel = RegisterModel(
                                      username: userNameController.text.trim(),
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                      phone: phoneController.text.trim(),
                                    );
                                    RegisterCubit.get(context).userRegister(
                                        registerModel: registerModel);
                                  }
                                },
                                child: Text("REGISTER"),
                              ),
                            );
                          },
                          fallback: (context) => buildLoadingState(),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?"),
                            TextButton(
                                onPressed: () => navigateToLoginScreen(context),
                                child: Text(
                                  "Log in",
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
            );
          },
        ),
      ),
    );
  }

  Widget buildLoadingState() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void navigateToLoginScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void navigateToHomeScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomeScreen()));
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
