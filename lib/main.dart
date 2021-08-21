import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
@override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: FutureBuilder<List<User>>(
            future: fetchUser(),
            builder: (context,item)
            {
              if(item.hasData)
              {
                return UserList(users: item.data!);
              }
              else return Text("error");


            },
          )
        ),
      ),
    );
  }
}
class UserList extends StatelessWidget {
  const UserList({Key? key,required this.users}) : super(key: key);
  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context,item)
    {
      return Column(
        children: [
          Text(users[item].id.toString()) ,
          SizedBox(height:20),
          Text(users[item].userId.toString()) ,
          SizedBox(height:20),
          Text(users[item].title)
        ],

      );
    },
    itemCount: users.length,);
  }
}



Future <List<User>>fetchUser()async
{
  final response= await http.get(Uri.parse("https://jsonplaceholder.typicode.com/albums"));
  if(response.statusCode==200)
  {

    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();

        return parsed.map<User>((json) => User.from(json)).toList();  }
  else
    {
      throw Exception("error");
    }
}

class User{
int id;
int userId;
String title;

User({required this.id,required this.userId,required this.title});

factory User.from(Map<String,dynamic>json)
{
  return User(
    id:json["id"],
    userId:json["userId"] ,
      title:json["title"]
  );
}
}
