import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var accounts = [
    {'email' : 'email@email.com',
      'password': '123'},

    {'email' : 'email1@email.com',
      'password': '123'},

    {'email' : 'email2@email.com',
      'password': '123'},
  ];
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.black, Colors.blue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: _isLoading ? const Center(child: CircularProgressIndicator()) : ListView(
          children: <Widget>[
            headerSection(),
            textSection(),
            buttonSection(),
          ],
        ),
      ),
    );
  }

  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> data = {
      'email': email,
      'password': pass
    };
    if(accounts.any((element) => element.values.toString() == data.values.toString())){
      setState(() {
        _isLoading = false;
      });
      sharedPreferences.setString("token", email);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainPage()), (Route<dynamic> route) => false);

    }
    // var jsonResponse;
    // //TODO add URI
    // var response = await http.post(Uri(), body: data);
    // if(response.statusCode == 200) {
    //   jsonResponse = json.decode(response.body);
    //   if(jsonResponse != null) {
    //     setState(() {
    //       _isLoading = false;
    //     });
    //     sharedPreferences.setString("token", jsonResponse['token']);
    //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainPage()), (Route<dynamic> route) => false);
    //   }
    // }
    // else {
    //   setState(() {
    //     _isLoading = false;
    //   });
    //   print(response.body);
    // }
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      margin: const EdgeInsets.only(top: 15.0),
      child: ElevatedButton(
        onPressed: /*emailController.text == "" || passwordController.text == "" ? null : */() {
          setState(() {
            _isLoading = true;
          });
          signIn(emailController.text, passwordController.text);
        },
        // elevation: 0.0,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: const Text("Sign In", style: TextStyle(color: Colors.white70)),
      ),
    );
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Container textSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,

            style: const TextStyle(color: Colors.white70),
            decoration: const InputDecoration(
              icon: Icon(Icons.email, color: Colors.white70),
              hintText: "Email",
              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
            obscureText: true,
            style: const TextStyle(color: Colors.white70),
            decoration: const InputDecoration(
              icon: Icon(Icons.lock, color: Colors.white70),
              hintText: "Password",
              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  Container headerSection() {
    return Container(
      margin: const EdgeInsets.only(top: 50.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: const Text("191102",
          style: TextStyle(
              color: Colors.white70,
              fontSize: 40.0,
              fontWeight: FontWeight.bold)),
    );
  }
}