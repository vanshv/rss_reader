import 'package:flutter/material.dart';
import 'register.dart';
import 'dashboard.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String username;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login here"),
        centerTitle: true,
        elevation: 0,
        // backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter Username'
              ),
              onChanged: (value) {
                setState(() {
                  username = value;
                });
              }
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter Password'
              ),
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              }
            ),
            TextButton(
              onPressed: () async {

                },
              child: const Text('Login',
                style: TextStyle(
                  fontSize: 17,
                  // fontWeight: FontWeight.bold,
                  color: Colors.blue)))
          ],
        ),
      ),
    );
  }
}
