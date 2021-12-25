import 'package:community_app/constant.dart';
import 'package:community_app/models/api_response.dart';
import 'package:community_app/models/user.dart';
import 'package:community_app/screens/home.dart';
import 'package:community_app/screens/login.dart';
import 'package:community_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}


class _RegisterState extends State<Register> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool loading = false;
  TextEditingController
  nameController = TextEditingController(),
  emailController = TextEditingController(),
  passwordController = TextEditingController(),
  passwordConfirmController = TextEditingController();

  void _registerUser() async {
    ApiResponse response = await register(nameController.text, emailController.text, passwordController.text);
    if(response.error==null){
      _saveAndRedirectToHome(response.data as User);
    }
    else{
      setState(() {
        loading = !loading;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }
//----save and redirect to home
  void _saveAndRedirectToHome(User user) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    // ignore: prefer_const_constructors
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home()), (route) => false);
  }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text('Register'),
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        child: ListView(
          // ignore: prefer_const_constructors
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          children: [
            TextFormField(
              controller: nameController,
              validator: (val) => val!.isEmpty ? 'Invalid Name':null,
              decoration: kInputDecoration('Name')
            ),
            SizedBox(height: 20,),

             TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              validator: (val) => val!.isEmpty ? 'Invalid email Address':null,
              decoration: kInputDecoration('Email')
            ),
            SizedBox(height: 20,),

              TextFormField(
              controller: passwordController,
              obscureText: true,
              validator: (val) => val!.length< 6 ? 'Required atleast 6 characters':null,
              decoration: kInputDecoration('password')
              ),
              SizedBox(height: 20,),

               TextFormField(
              controller: passwordConfirmController,
              obscureText: true,
              validator: (val) => val!= passwordController.text ? 'Confirm password do not match':null,
              decoration: kInputDecoration('password')
              ),

              SizedBox(height: 20,),
              loading? Center(child: CircularProgressIndicator(),)
              :
              kTextButton('Register',(){
                 if (formkey.currentState!.validate()){
                      setState(() {
                        loading = !loading;
                        _registerUser();
                      });

                    }
              }),
             
                SizedBox(height: 20,),
              kLoginRegisterHint('Already have an account?',' login',(){
               Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(context)=>Login() ), (route) => false);
              })
          ], 
        ),
      ),
    );
  }
}