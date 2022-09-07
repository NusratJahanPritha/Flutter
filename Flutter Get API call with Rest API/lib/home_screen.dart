import 'package:api/Models/PostsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<PostsModel> postlist =[];
  Future<List<PostsModel>> getPostApi ()async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        postlist.add(PostsModel.fromJson(i));
      }
      return postlist;
    } else {
      return postlist;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API course'),
      ),
      body: Column(
        children: [
          Expanded(child:FutureBuilder(
            future: getPostApi(),
            builder: (context , snapshot){
              if (!snapshot.hasData){
                postlist.clear();
                return Text('loading');
              }else{
                return ListView.builder(
                    itemCount: postlist.length,
                    itemBuilder: (context, index){

                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Title', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                              Text(postlist[index].title.toString()),
                              SizedBox(height: 5),
                              Text('Description', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                              Text('Description\n'+postlist[index].body.toString())

                            ],
                          ),
                        )
                      );
                    });
              }
            },
          ),)
        ],
      ),
    );
  }
}

