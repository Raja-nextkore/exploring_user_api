import 'dart:convert';

import '../model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExploringUserApi extends StatefulWidget {
  const ExploringUserApi({
    Key? key,
  }) : super(key: key);

  @override
  State<ExploringUserApi> createState() => _ExploringUserApiState();
}

class _ExploringUserApiState extends State<ExploringUserApi> {
  final List<User> _user = [];

  Future<List<User>> _fetchUser() async {
    final http.Response response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );
    if (response.statusCode == 200) {
      var parsedJson = jsonDecode(response.body);
      for (Map<String, dynamic> json in parsedJson) {
        setState(() {
          _user.add(User.fromJson(json));
        });
      }
    } else {
      throw Exception('Unable to get user Data...');
    }
    return _user;
  }

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exploring User Api'),
      ),
      body: ListView.builder(
          itemCount: _user.length,
          itemBuilder: (_, index) {
            return Card(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40.0,
                      backgroundColor: Colors.grey,
                      child: Text(_user[index].id!.toString()),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      _user[index].name!,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      'UserName : ${_user[index].username}',
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      'email : ${_user[index].email}',
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      'phone : ${_user[index].phone}',
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      'website : ${_user[index].website}',
                      textAlign: TextAlign.start,
                    ),
                    Text('company_name : ${_user[index].company!.name!}'),
                    Text(
                        'company_catchPhrase : ${_user[index].company!.catchPhrase!}'),
                    Text('company_bs : ${_user[index].company!.bs!}'),
                    Text('address_street : ${_user[index].address!.street!}'),
                    Text('address_suite : ${_user[index].address!.suite!}'),
                    Text('address_city : ${_user[index].address!.city!}'),
                    Text('address_zipcode : ${_user[index].address!.zipcode!}'),
                    Text('Geo_lat : ${_user[index].address!.geo!.lat!}'),
                    Text('Geo_lng : ${_user[index].address!.geo!.lng!}'),
                  ],
                ),
              ),
            ));
          }),
    );
  }
}
