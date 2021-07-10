import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:inventory_app/Controllers/FYearController.dart';
import 'package:inventory_app/Controllers/LoginLocationController.dart';
import 'package:inventory_app/core/datamodels/FyearModels.dart';
import 'package:inventory_app/core/datamodels/LocationModels.dart';
import 'package:inventory_app/utils/app_color.dart';
import 'package:inventory_app/utils/app_constant.dart';
import 'package:inventory_app/utils/app_sizes.dart';
import 'package:inventory_app/views/widgets/MyTextFormField.dart';
import 'package:inventory_app/views/widgets/app_buttons.dart';
import 'package:inventory_app/views/widgets/app_text_styles.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../core/datamodels/LocationModels.dart';
import '../base_view.dart';
import 'package:http/http.dart' as http;

/*List<dynamic> subjectDuplicateItems = [];
List<dynamic> gradeDuplicateItems = [];*/
List<dynamic> subjectItems;
//var gradeItems = [];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = new TextEditingController();
  List<UserDetails> _searchResult = [];

  List<UserDetails> _userDetails = [];

  //final String url = 'https://jsonplaceholder.typicode.com/users';
  var url = Uri.parse("http://cserp.southeastasia.cloudapp.azure.com:55080/api/Locations");


  // Get json result and convert it to model. Then add
  Future<Null> getUserDetails() async {
    final response = await http.get(url);
    final responseJson = json.decode(response.body);

    setState(() {
      for (Map user in responseJson) {
        _userDetails.add(UserDetails.fromJson(user));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Home'),
        elevation: 0.0,
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            color: Theme.of(context).primaryColor,
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Card(
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                    controller: controller,
                    decoration: new InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                    controller.clear();
                    onSearchTextChanged('');
                  },),
                ),
              ),
            ),
          ),
          new Expanded(
            child: _searchResult.length != 0 || controller.text.isNotEmpty
                ? new ListView.builder(
              itemCount: _searchResult.length,
              itemBuilder: (context, i) {
                return new Card(
                  child: new ListTile(
                 //   leading: new CircleAvatar(backgroundImage: new NetworkImage(_searchResult[i].profileUrl,),),
                    title: new Text(_searchResult[i].firstName + ' ' + _searchResult[i].lastName),
                  ),
                  margin: const EdgeInsets.all(0.0),
                );
              },
            )
                : new ListView.builder(
              itemCount: _userDetails.length,
              itemBuilder: (context, index) {
                return new Card(
                  child: new ListTile(
                   // leading: new CircleAvatar(backgroundImage: new NetworkImage(_userDetails[index].profileUrl,),),
                    title: new Text(_userDetails[index].firstName + ' ' + _userDetails[index].lastName),
                  ),
                  margin: const EdgeInsets.all(0.0),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _userDetails.forEach((userDetail) {
      if (userDetail.firstName.contains(text) || userDetail.lastName.contains(text))
        _searchResult.add(userDetail);
    });
  }
}


class UserDetails {
  final String firstName, lastName;

  UserDetails({this.firstName, this.lastName});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return new UserDetails(
      firstName: json['Code'],
      lastName: json['Name'],
    );
  }
}


