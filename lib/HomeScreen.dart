import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ModelData> photosData = [];
  Future<List<ModelData>> getPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (var item in data) {
        ModelData modelData =
            ModelData(title: item['title'], url: item['url'], id: item['id']);
        photosData.add(modelData);
      }
      return photosData;
    } else {
      return photosData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api with a bit Complex data'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotos(),
                builder: (context, snapshot) {
                  return ListView.builder(itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(snapshot.data![index].url.toString()),
                      ),
                      subtitle: Text(snapshot.data![index].id.toString()),
                      title: Text(snapshot.data![index].title.toString()),
                    );
                  });
                }),
          )
        ],
      ),
    );
  }
}

//Class Model To Parse Api Data

class ModelData {
  String title, url;

  int id;

  ModelData({required this.title, required this.url, required this.id});
}
