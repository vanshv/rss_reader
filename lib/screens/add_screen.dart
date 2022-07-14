import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddScreen extends StatelessWidget {
  String name = "null string";
  final _formKey = GlobalKey<FormState>();


  OutlineInputBorder _inputformdeco() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide:
          BorderSide(width: 1.0, color: Colors.blue, style: BorderStyle.solid),
    );
  }

  Future<void> _savingData() async {
    final form = _formKey.currentState;
    if (form != null && !form.validate()) {
      return;
    }
    form?.save();

    //     final validation = _formKey.currentState.validate();
    // if (!validation) {
    //   return;
    // }

    // _formKey.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Send POST requests here"),
        centerTitle: true,
        elevation: 0,
        // backgroundColor: Colors.transparent,
      ),

      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 0),
            Container(
              width: 350,
              child: Form(
                key: _formKey,
                child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter Post Request',
                      enabledBorder: _inputformdeco(),
                      focusedBorder: _inputformdeco(),
                    ),
                    onSaved: (value) {
                      name = value ?? "";
                    }),
              ),
            ),
            TextButton(
                onPressed: () async {
                  _savingData();
                  final url = "http://10.0.2.2:5000/name";

                  final response = http.post(Uri.parse(url),
                      body: json.encode({'name': name}));
                },
                //  style: const ButtonStyle(
                //    TextStyle(fontSize: 16, color: Colors.blue),
                //  ),
                child: const Text('Send POST Request',
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