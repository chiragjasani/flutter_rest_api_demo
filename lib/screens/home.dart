import 'package:flutter/material.dart';

import '../model/user_model.dart';
import '../services/api_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<UserModel>? _userModel = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _userModel = (await ApiService().getUsers())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API Example'),
      ),
      body: _userModel == null || _userModel!.isEmpty
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _userModel!.length,
        // reverse: true,
        itemBuilder: (context, index) {
          return InkWell(
            child: Card(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(_userModel![index].id.toString(),
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold)),
                      Text(_userModel![index].username),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(_userModel![index].email),
                      Text(_userModel![index].website),
                    ],
                  ),
                ],
              ),
            ),
            onTap: () => Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(_userModel![index].username))),
          );
        },
      ),
    );
  }
}
