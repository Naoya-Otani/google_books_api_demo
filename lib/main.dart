import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Books App',
      home: MyHomePage(title: 'Books App Top'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List items = [];
  final TextEditingController _todoController = TextEditingController();

  Future<void> getData(String keyword) async {
    // 現状はAPIキーをハードコーディングしている
    var response =
        await http.get(Uri.https('www.googleapis.com', '/books/v1/volumes', {
      'q': '{${keyword}}',
      'maxResults': '40',
      'langRestrict': 'ja',
      'key': 'AIzaSyBlWk_MJ73tQYkJMlDK8rixl9AgebBl3O0'
    }));

    var jsonResponse = jsonDecode(response.body);

    setState(() {
      items = jsonResponse['items'];
    });
  }

  @override
  void initState() {
    super.initState();

    getData("TypeScript");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Books API'),
        ),
        body: Column(
          children: [
            TextField(
              controller: _todoController,
              decoration: const InputDecoration(
                hintText: '本を検索...',
                contentPadding: EdgeInsets.all(20),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                print("pressed");
              },
              child: Container(
                  alignment: Alignment.center, child: const Text('検索')),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Image.network(
                            items[index]['volumeInfo']['imageLinks']
                                ['thumbnail'],
                          ),
                          title: Text(items[index]['volumeInfo']['title']),
                          subtitle:
                              Text(items[index]['volumeInfo']['publishedDate']),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}
