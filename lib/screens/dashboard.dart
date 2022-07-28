import 'package:flutter/material.dart';
import 'add_feed.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Dashboard extends StatefulWidget {
  late Map allfeeds;
  Dashboard({Key? key, required this.allfeeds}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  static const String placeholderImg = 'images/no_image.png';
  // late Map converted;

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
            ListView.builder(
              itemCount: widget.allfeeds.length,
              itemBuilder: (BuildContext context, int index) {
                final item = widget.allfeeds['entries'].elementAt(index);
                return ListTile(
                  title: Text(
                    item['title'],
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.w500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    item['subtitle'],
                    style: const TextStyle(
                        fontSize: 14.0, fontWeight: FontWeight.w100),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          Image.asset(placeholderImg),
                      imageUrl: item['enclosure']['url'],
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
