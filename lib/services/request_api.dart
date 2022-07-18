import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:http/http.dart' as http;
import 'package:rss_reader/screens/dashboard.dart';
import 'package:rss_reader/screens/login.dart';

class RequestAPI{
  static final _client = http.Client();
  static final _loginUrl = Uri.parse("http://10.0.2.2:5000/login");
  static final _registerUrl = Uri.parse("http://10.0.2.2:5000/register");

  static login(username, password, context) async{
    http.Response respo = await _client.post(_loginUrl, body:{
      "username": username,
      "password": password,
    });

    if(respo.statusCode == 200){
      var jsoned = jsonDecode(respo.body);

      if(jsoned[0] == 'success'){
        EasyLoading.showSuccess(jsoned[0]);
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Dashboard()));
      }
      else{
        EasyLoading.showError(jsoned[0]);
      }
    }
    else{
      EasyLoading.showError(
        "Error Code : ${respo.statusCode.toString()}");
    }
  }

  static register(username, password, context) async{
    http.Response respo = await _client.post(_registerUrl, body:{
      "username": username,
      "password": password,
    });

    if(respo.statusCode == 200){
      var jsoned = jsonDecode(respo.body);

      if(jsoned[0] == 'Register success'){
        EasyLoading.showSuccess(jsoned[0]);
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
      }
      else{
        EasyLoading.showError(jsoned[0]);
      }
    }
    else{
      EasyLoading.showError(
        "Error Code : ${respo.statusCode.toString()}");
    }
  }


}
