
import 'package:firepost/Models/model.dart';
import 'package:firepost/Pages/Detail_Page.dart';
import 'package:firepost/Pages/image.dart';
import 'package:firepost/Services/auth_service.dart';
import 'package:firepost/Services/hive_db.dart';
import 'package:firepost/Services/rtdb_servise.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware{
  bool isLoading = false;
  List<Post> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiGetPosts();
  }

  Future _openDetail() async {
    Map results = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return DetailPage();
    }));
    if (results.containsKey("data")) {
      _apiGetPosts();
    }
  }

  Future _openDetailforEdit(Post post) async {
    Map results = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return DetailPage(
        post: post,
      );
    }));
    if (results.containsKey("data")) {
      _apiGetPosts();
    }
  }

  _apiGetPosts() async {
    setState(() {
      isLoading = true;
    });
    var id = HiveDB.loadUid();
    RTDBService.getPosts(id!).then((posts) => {
      _respPosts(posts),
    });
  }

  _respPosts(List<Post> posts) {
    setState(() {
      items = posts;
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
              onPressed: () {
                AuthService.signOutUser(context);
              },
              icon: const Icon(Icons.replay)),
          const SizedBox(width: 10),
          IconButton(onPressed: () {
            AuthService.signOutUser(context);
          }, icon: Icon(Icons.logout)),
        ],
      ),
      // body: Center(child: Text("Hello its empty",style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold,fontSize: 35),),),
      body: ListView.builder(
          itemCount:3,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: (){
                  Navigator.pushNamed(context, DetailPage.id);
                },
                textColor: Colors.white,
                leading: CircleAvatar(
                    // backgroundImage: NetworkImage("https://unsplash.com/photos/DbsfpALaEhM"),
                ),
                title:(list[index].title != null) ?Text(list[index].title!+"dffdd",style: TextStyle(color: Colors.black),):Text("dd saxax"),
                subtitle:(list[index].content != null)? Text(list[index].content!,style: TextStyle(color: Colors.black),):Text("ad"),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          Navigator.pushNamed(context, DetailPage.id);
        },
       child: Icon(Icons.add_circle_rounded,size: 40,),
      ),
      persistentFooterButtons: [
        IconButton(onPressed: (){
// Navigator.pushNamed(context, MyHomePage.id);
        }, icon:Icon(Icons.photo)),
        IconButton(onPressed: (){
// Navigator.pushNamed(context, MyHomePage.id);
        }, icon:Icon(Icons.photo)),
      ],
    );
  }
}