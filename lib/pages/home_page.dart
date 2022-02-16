import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:network_demo_3/models/user_model.dart';
import 'package:network_demo_3/pages/detail_page.dart';
import 'package:network_demo_3/services/http_service.dart';
import 'package:network_demo_3/services/util_service.dart';

class HomePage extends StatefulWidget {
  static const String id = "/home_page";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserList? userList;
  String data = "no data";
  List colorList = Colors.primaries;
  
  @override
  void initState() {
    super.initState();
    apiGetUserList();
  }
  
  void apiGetUserList() async {
    HttpService.GET(HttpService.API_USER_LIST, HttpService.paramEmpty()).then((response) {
      if(response != null) {
        print(response);
        parseResponse(response);
      }
    });
  }

  void parseResponse(String response) {
    setState(() {
      userList = HttpService.parseUserList(response);
    });
  }


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Users"),
      ),
      body: userList != null ? ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: userList!.userList.length,
        itemBuilder: (context, index) {
          return userItem(userList!.userList[index]);
        },
      ) : Center(
        child: Text(data, style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(type: CRUD.TYPE_CREATE,)));
        },
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget userItem(User user) {
    return Slidable(
      child: Card(
        child: ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(userId: user.id, type: CRUD.TYPE_READ,)));
          },
          leading: CircleAvatar(
            backgroundColor: colorList[user.id % colorList.length],
            child: Text(
              user.name[0],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          title: Text(user.username, style: TextStyle(fontSize: 18),),
          subtitle: Text(user.email, style: TextStyle(fontSize: 16),),
        ),
      ),
      startActionPane: ActionPane(
        extentRatio: 0.2,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(userId: user.id, type: CRUD.TYPE_UPDATE,)));
            },
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
    );
  }
}
