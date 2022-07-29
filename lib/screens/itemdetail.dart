import 'package:flutter/material.dart';


class ItemDetail extends StatefulWidget {
  dynamic item;
  ItemDetail({Key? key, this.item}) : super(key: key);

  @override
  State<ItemDetail> createState() => _DashboardState();
}

class _DashboardState extends State<ItemDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item['title']),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[  
              FadeInImage.assetNetwork(  
                placeholder: 'assets/images/no_image.png',  
                image: (widget.item["enclosures"] == null) ? 'https://static.javatpoint.com/tutorial/flutter/images/flutter-creating-android-platform-specific-code3.png' : widget.item["enclosures"].href[0],  
                  height: 400,  
                  width: 250  
              ),  
              Text(  
                widget.item['summary'],  
                style: const TextStyle(fontSize: 20.0),  
              )  
            ],  
      
        ),
      ),
    );
  }
}
