// ignore_for_file: prefer_const_constructors


import 'package:community_app/screens/login.dart';
import 'package:community_app/services/user_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      // ignore: prefer_const_constructors
      body: Center(child: GestureDetector(
        onTap: (){
          logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(context)=>Login() ), (route) => false)
          });
        },
        
        child: Text('Home: press to log out')),),

      
    );
  }
}