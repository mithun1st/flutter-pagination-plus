import 'package:flutter/material.dart';
import 'package:flutter_pagination_plus/flutter_pagination_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Pagination Plus',
      theme: ThemeData(useMaterial3: false),
      home: MyHomePage(title: 'Flutter Pagination Plus'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> _userList = [];

  Future<List<User>> _generateList() async {
    List<User> list = [];
    for (int i = 0; i < 20; i++) {
      list.add(User());
    }
    await Future.delayed(Duration(seconds: 2));
    return list;
  }

  @override
  void initState() {
    super.initState();
    () async {
      _userList = (await _generateList());
      setState(() {});
    }.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: FlutterPaginationPlus<User>(
        list: _userList,
        onChangeNextPage: () async {
          _userList.addAll(await _generateList());
        },
        padding: EdgeInsets.symmetric(horizontal: 12),
        paginationType: PaginationType.infiniteScroll,
        itemBuilder: (ctx, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              tileColor: Colors.teal,
              title: Text("${_userList[index]} $index/${_userList.length}"),
              trailing: CloseButton(
                onPressed: () {
                  setState(() => _userList.removeAt(index));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class User {
  final String? name;
  final int? roll;
  User({this.name, this.roll});
}
