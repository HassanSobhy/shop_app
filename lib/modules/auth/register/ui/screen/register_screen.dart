import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/register/register_model.dart';
import 'package:shop_app/modules/auth/login/ui/screen/login_screen.dart';
import 'package:shop_app/modules/auth/register/bloc/register_bloc.dart';
import 'package:shop_app/modules/auth/register/bloc/register_repository.dart';
import 'package:shop_app/modules/home/home_screen.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => RegisterBloc(RegisterRepository()),
        child: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccessState) {
              buildToastMessage(state.model.message, Colors.green);
              navigateToHomeScreen(context);
            } else if (state is RegisterErrorState) {
              buildToastMessage(state.message, Colors.red);
            } else if (state is RegisterNavigationToLoginScreenState) {
              navigateToLoginScreen(context);
            }
          },
          builder: (context, state) {
            if (state is RegisterInitialState) {
              return registerFormWidget(context);
            } else if (state is RegisterLoadingState) {
              return loadingWidget();
            } else if (state is RegisterUsernameEmptyFormatState) {
              return registerFormWidget(context,
                  userNameValidationText: state.message);
            } else if (state is RegisterUsernameInvalidFormatState) {
              return registerFormWidget(context,
                  userNameValidationText: state.message);
            } else if (state is RegisterUsernameFormatCorrectState) {
              return registerFormWidget(context);
            } else if (state is RegisterEmailEmptyFormatState) {
              return registerFormWidget(context,
                  emailValidationText: state.message);
            } else if (state is RegisterEmailInvalidFormatState) {
              return registerFormWidget(context,
                  emailValidationText: state.message);
            } else if (state is RegisterEmailFormatCorrectState) {
              return registerFormWidget(context);
            } else if (state is RegisterPasswordEmptyFormatState) {
              return registerFormWidget(context,
                  passwordValidationText: state.message);
            } else if (state is RegisterPasswordInvalidFormatState) {
              return registerFormWidget(context,
                  passwordValidationText: state.message);
            } else if (state is RegisterPasswordFormatCorrectState) {
              return registerFormWidget(context);
            } else if (state is RegisterPhoneEmptyFormatState) {
              return registerFormWidget(context,
                  phoneValidationText: state.message);
            } else if (state is RegisterPhoneInvalidFormatState) {
              return registerFormWidget(context,
                  phoneValidationText: state.message);
            } else if (state is RegisterPhoneFormatCorrectState) {
              return registerFormWidget(context);
            } else {
              return registerFormWidget(context);
            }
          },
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////
  Widget registerFormWidget(
    BuildContext context, {
    String userNameValidationText,
    String emailValidationText,
    String passwordValidationText,
    String phoneValidationText,
  }) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headLineTextWidget(context),
              const SizedBox(height: 40),
              userNameTextFieldWidget(userNameValidationText),
              sizedBoxDividerWidget(),
              emailTextFieldWidget(emailValidationText),
              sizedBoxDividerWidget(),
              passwordTextFieldWidget(context, passwordValidationText),
              sizedBoxDividerWidget(),
              phoneTextFieldWidget(phoneValidationText),
              const SizedBox(height: 32),
              registerButtonWidget(context),
              sizedBoxDividerWidget(),
              alreadyHaveAnAccButtonWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget userNameTextFieldWidget(String userNameValidationText) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: userNameController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: "Username",
        errorText: userNameValidationText,
        prefixIcon: const Icon(Icons.person),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget headLineTextWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Register",
          style: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const Text("Register now to browse our hot offers")
      ],
    );
  }

  Widget alreadyHaveAnAccButtonWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?"),
        TextButton(
            onPressed: () => addNavigationToLoginScreenEvent(context),
            child: const Text(
              "Log in",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            )),
      ],
    );
  }

  Widget registerButtonWidget(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          userRegister(context);
        },
        child: const Text("REGISTER"),
      ),
    );
  }

  Widget phoneTextFieldWidget(String phoneValidationText) {
    return TextFormField(
      textInputAction: TextInputAction.done,
      controller: phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        errorText: phoneValidationText,
        labelText: "Phone",
        prefixIcon: const Icon(Icons.phone),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget passwordTextFieldWidget(
      BuildContext context, String passwordValidationText) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      obscureText: RegisterBloc.get(context).isPassword,
      controller: passwordController,
      decoration: InputDecoration(
        errorText: passwordValidationText,
        labelText: "Password",
        prefixIcon: const Icon(Icons.lock_outline_rounded),
        suffixIcon: Icon(RegisterBloc.get(context).suffix),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget emailTextFieldWidget(String emailValidationText) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        errorText: emailValidationText,
        labelText: "Email",
        prefixIcon: const Icon(Icons.email_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget sizedBoxDividerWidget() => const SizedBox(height: 16);

  Widget loadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  ///////////////////////////////////////////////////////////
  /////////////////// Helper methods ////////////////////////
  ///////////////////////////////////////////////////////////
  void userRegister(BuildContext context) {
    final RegisterModel registerModel = RegisterModel(
      username: userNameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      phone: phoneController.text.trim(),
    );
    RegisterBloc.get(context).add(UserRegisterEvent(registerModel));
  }

  void addNavigationToLoginScreenEvent(BuildContext context) {
    RegisterBloc.get(context).add(const NavigationToLoginScreenEvent());
  }

  Future<void> navigateToLoginScreen(BuildContext context) async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void navigateToHomeScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
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

///////////////////////////////////////////////////////////
/////////////////// Helper methods ////////////////////////
///////////////////////////////////////////////////////////

}
