import 'package:flutter_app_cinema/Salles-page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CinemaPage extends StatefulWidget {
  dynamic ville;

  CinemaPage(this.ville);

  @override
  _CinemaPageState createState() => _CinemaPageState();
}

class _CinemaPageState extends State<CinemaPage> {
  List<dynamic> listCinemas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cinémas de ${widget.ville['name']}'),),
      body: Center(
        child: (this.listCinemas==null) ? CircularProgressIndicator() :
        ListView.builder(
            itemCount: this.listCinemas == null ? 0 : this.listCinemas.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.redAccent,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: RaisedButton(
                    color: Colors.white,
                    child: Text(this.listCinemas[index]['name']),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                          builder: (context)=>new SallesPage(this.listCinemas[index])
                      ));
                    },
                  ),
                ),
              );
            })
        ,
      ),
    );
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCinema();
  }


  void loadCinema() {
    String url = this.widget.ville['_links']['cinemas']['href'];
    http.get(url).then((resp) {
      setState(() {
        this.listCinemas = json.decode(resp.body)['_embedded']['cinemas'];
      });
    }).catchError((err) {
      print(err);
    });
  }}
