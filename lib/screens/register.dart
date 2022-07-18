import 'package:flutter/material.dart';
import '../services/request_api.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late String username;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register here"),
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
                decoration: const InputDecoration(hintText: 'Enter Username'),
                onChanged: (value) {
                  //try removing setstate, it might not be needed
                  setState(() {
                    username = value;
                  });
                }),
            TextField(
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Enter Password'),
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                }),
            TextButton(
                onPressed: () async {
                  await RequestAPI.register(username, password, context);
                },
                child: const Text('Register',
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
