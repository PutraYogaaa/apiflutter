import 'dart:ffi';

import 'package:bljr_api_flutter/model.dart';
import 'package:bljr_api_flutter/repository.dart';
import 'package:flutter/material.dart';
import 'package:bljr_api_flutter/add-user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Belajar API FLutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/home': (context) => MyHomePage(title: 'Flutter'),
        '/add-user': (context) => AddUser()
      },
      home: const MyHomePage(title: 'Flutter'),
      debugShowCheckedModeBanner: false,
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
  List<Blog> listBlog = [];
  Repository repository = Repository();

  getData() async {
    listBlog = await repository.getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context).popAndPushNamed('/add-user'),
          )
        ],
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .popAndPushNamed('/add-user', arguments: [
                    listBlog[index].id,
                    listBlog[index].name,
                    listBlog[index].gender
                  ]),
                  child: Container(
                    margin: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(listBlog[index].name),
                        Text(listBlog[index].gender),
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      bool response =
                          await repository.deleteData(listBlog[index].id);

                      if (response) {
                        print('data sukses');
                      } else {
                        print('Delete Data Gagal');
                      }

                      getData();
                    },
                    icon: Icon(Icons.delete))
              ],
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: listBlog.length),
    );
  }
}
