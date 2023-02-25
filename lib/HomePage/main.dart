import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/HomePage/search_bar.dart';
import 'package:hackathon/HomePage/user_info_bar.dart';
import 'package:hackathon/HomePage/map.dart';
import 'package:hackathon/HomePage/theme.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool isInfoScreenVisible = true;
  String address = "Please wait...";
  String searchValue = '';
  final List<String> _suggestions = [
    'LT',
    'G-Block',
    'Jaggi',
    'Main Gate',
    'Cos',
    'Hostel H',
    'Dispensary'
  ];

  Future<List<String>> _fetchSuggestions(String searchValue) async {
    await Future.delayed(const Duration(milliseconds: 750));

    return _suggestions.where((element) {
      return element.toLowerCase().contains(searchValue.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    callback(String address) {
      setState(() {
        this.address = address;
      });
    }

    return Scaffold(
      appBar: EasySearchBar(
          backgroundColor: Color(0xFF0C9869),
          title: const Text('Velo'),
          onSearch: (value) => setState(() => searchValue = value),
          asyncSuggestions: (value) async => await _fetchSuggestions(value)),
      drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Color(0xFF0C9869),
          ),
          child: Text(
            'Velo',
            style: TextStyle(fontSize: 40),
            textAlign: TextAlign.center,
          ),
        ),
        ListTile(
            title: const Text('History'), onTap: () => Navigator.pop(context)),
        ListTile(
            title: const Text('Pay now'), onTap: () => Navigator.pop(context))
      ])),
      body: SafeArea(
          child: Stack(
        children: [
          MyMap(callback),
          Column(
            children: [
              Spacer(),
              Visibility(child: UserInfoBar(), visible: isInfoScreenVisible)
            ],
          )
        ],
      )),
    );
  }
}
