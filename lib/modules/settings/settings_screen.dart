import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shop_app/models/login/login_response_model.dart';
import 'package:shop_app/modules/auth/login/ui/screen/login_screen.dart';
import 'package:shop_app/modules/home/cubit/home_cubit.dart';
import 'package:shop_app/modules/home/cubit/home_states.dart';
import 'package:shop_app/network/local/preference_utils.dart';
import '../../constant.dart';

class SettingsScreen extends StatelessWidget {

  //Form Key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        if(state is HomeLoadingProfileState){
          return buildLoadingState();
        } else {
          nameController.text = HomeCubit.get(context).userDataModel.loginResponseDataModel.name;
          emailController.text = HomeCubit.get(context).userDataModel.loginResponseDataModel.email;
          phoneController.text = HomeCubit.get(context).userDataModel.loginResponseDataModel.phone;
          return buildLoadedState(context);
        }
      },
    );
  }

  Widget buildLoadedState(BuildContext context) {

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.name,
                controller: nameController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Name must not be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: "Name",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Email must not be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: phoneController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Phone must not be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: "Phone",
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if(formKey.currentState.validate()){
                      HomeCubit.get(context).updateProfileData(
                        name: nameController.text.trim(),
                        email: emailController.text.trim(),
                        phone: phoneController.text.trim(),

                      );
                    }
                  },
                  child: Text("UPDATE"),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    signOut(context);
                  },
                  child: Text("LOGOUT"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildLoadingState() {
  return Center(
    child: CircularProgressIndicator(),
  );
}


void signOut(BuildContext context) async {
  try{
    bool signOut = await PreferenceUtils.removeData(userTokenKey);
    if(signOut == true){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
    }
  } catch(e){
    //Error Handling.
  }
}
