import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rss_reader/services/request_api.dart';
import 'dart:convert';
import 'add_feed.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Map allfeeds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display all feeds here'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddFeed()));
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
                onPressed: () async {
                  allfeeds = await RequestAPI.getallfeeds(context);
                },
                child: const Text('Get Feeds',
                    style: TextStyle(
                        fontSize: 17,
                        // fontWeight: FontWeight.bold,
                        color: Colors.blue))),
            ListView.builder(
              itemCount: allfeeds['itemcount'],
              itemBuilder: (BuildContext context, int index) {
                final item = allfeeds.entries.elementAt(index);
                return ListTile(
                  title: Text(
                    item["title"],
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    item.subtitle,
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.w100),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: CachedNetworkImage(
                      placeholder: (context, url) => Image.asset(placeholderImg),
                      imageUrl: item.enclosure.url,
                      height: 50,
                      width: 70,
                      alignment: Alignment.center,
                      fit: BoxFit.fill,         
                    ),
                  ),
                  trailing: const Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                    size: 30.0,
                  ),
                  contentPadding: const EdgeInsets.all(5.0),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
