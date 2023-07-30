import 'package:flutter/material.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: Padding(padding: EdgeInsets.all(5),
      child: Column(
        children: [
          DrawerHeader(child: Column(
            children: [
              CircleAvatar(
                radius: 50,
              ),
              SizedBox(height: 10),
              Text("JarvisGPT")
            ],
          ),),
        ListTile(title: Text('Home'), leading: Icon(Icons.home),),
        ListTile(title: Text('Home'), leading: Icon(Icons.home),),
        ListTile(title: Text('Home'), leading: Icon(Icons.home),),
        ListTile(title: Text('Home'), leading: Icon(Icons.home),),
        
        ],
      ),
      ),
    );
  }
}
