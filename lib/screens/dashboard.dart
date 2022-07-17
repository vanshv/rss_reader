import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'add_feed.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String name = "";
  String finalResponse = "null string";
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display GET Posts here'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddFeed()));
        },
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: () async {
                final url = "http://10.0.2.2:5000/name";
                final response = await http.get(Uri.parse(url));
                final decoded =
                    json.decode(response.body) as Map<String, dynamic>;

                setState(() {
                  finalResponse = decoded['name'];
                });
              },
              child: Text('GET'),
              color: Colors.lightBlue,
            ),

            //displays the data on the screen
            Text(
              finalResponse,
              style: TextStyle(fontSize: 24),
            )
          ],
        ),
      ),
    );
  }
}
