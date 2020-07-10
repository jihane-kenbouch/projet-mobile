import 'package:flutter/material.dart';

import "package:http/http.dart" as http;
import 'dart:convert';

import 'GlobalVariables.dart';
import 'cinemas-page.dart';


class VillePage extends StatefulWidget {
  @override
  _VillePageState createState() => _VillePageState();
}
class _VillePageState extends State<VillePage> {
  List<dynamic> listVilles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Villes'),),
      body: Center(
          child:this.listVilles==null?CircularProgressIndicator():
    ListView.builder(
        itemCount: (this.listVilles==null)?0:this.listVilles.length,
        itemBuilder: (context,index) {
          return Card(
              color:Colors.red ,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: RaisedButton(
                color: Colors.white,
                child: Text(this.listVilles[index]['name']
                  ,style: TextStyle(color: Colors.black),),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context)=>new CinemaPage(listVilles[index])
                      ));

                },
              ),
            ),
                );
        }
          )
    ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadVilles();
  }

  void loadVilles() {
 // String url="http://192.168.43.181:6060/villes";
  String url=GlobalData.host+"/villes";
  http.get(url)
      .then((resp){
    setState(() {
      this.listVilles=json.decode(resp.body)['_embedded']['villes'];
    });

  }).catchError((err) {
    print(err);
  });
  }
}