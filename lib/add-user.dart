import 'package:bljr_api_flutter/repository.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  Repository repository = Repository();
  final _nameController = TextEditingController();
  final _genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<String>;
    if (args[1].isNotEmpty) {
      _nameController.text = args[1];
    }
    if (args[2].isNotEmpty) {
      _genderController.text = args[2];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'User'),
            ),
            TextField(
              controller: _genderController,
              decoration: InputDecoration(hintText: 'Gender'),
            ),
            ElevatedButton(
                onPressed: () async {
                  bool response = await repository.postData(
                      _nameController.text, _genderController.text);

                  if (response) {
                    Navigator.of(context).popAndPushNamed('/home');
                  } else {
                    print('Post Data Gagal');
                  }
                },
                child: Text('Submit')),
            ElevatedButton(
                onPressed: () async {
                  bool response = await repository.putData(int.parse(args[0]),
                      _nameController.text, _genderController.text);

                  if (response) {
                    Navigator.of(context).popAndPushNamed('/home');
                  } else {
                    print('Update Data Gagal');
                  }
                },
                child: Text('Update'))
          ],
        ),
      ),
    );
  }
}
