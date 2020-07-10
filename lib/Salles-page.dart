
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'GlobalVariables.dart';

class SallesPage extends StatefulWidget {
  dynamic cinema;

  SallesPage(this.cinema);

  @override
  _SallesPageState createState() => _SallesPageState();
}

class _SallesPageState extends State<SallesPage> {
  List<dynamic> listSalles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Salles du cinéma ${widget.cinema['name']}'),),
      body: Center(
        child: (this.listSalles == null) ? CircularProgressIndicator() :
        ListView.builder(
            itemCount: this.listSalles == null ? 0 : this.listSalles.length,
            itemBuilder: (context, index) {
              return Card(
                  color: Colors.white10,
                  child: Column(
                    children: <Widget>[
                  Container(
                  width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        color: Colors.redAccent,
                        child: Text(this.listSalles[index]['name']),
                        onPressed: () {
                          loadProjections(this.listSalles[index]);
                        },
                      ),
                    ),

                  ),
                  if(this.listSalles[index]['projections']!=null)

              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: <Widget>[
                    Image.network(GlobalData.host + "/ImageFilm/${this
                        .listSalles[index]['currentProjection']['film']['id']}",
                      width: 150,),
                    Column(
                        children: <Widget>[
                    ...(this.listSalles[index]['projections'] as List<dynamic>).map((projection) {
                      return RaisedButton(
                        color: (this
                            .listSalles[index]['currentProjection']['id'] ==
                            projection['id']) ? Colors.red : Colors
                            .deepOrangeAccent,
                        child: Text("${projection['seance']['heureDebut']}"
                            "(${projection['film']['duree']} H,Prix=${projection['prix']}DH)",
                            style: TextStyle(color: Colors.white, fontSize: 6)),
                        onPressed: () {
                          loadTickets(projection, this.listSalles[index]);
                        },
                      );
                    })
                  ],

                )
                ],
              ),
              ),
              if(this.listSalles[index]['currentProjection']!=null &&
              this.listSalles[index]['currentProjection']['listTickets']!=null &&
              this.listSalles[index]['currentProjection']['listTickets'].length >0 )
              Column(
              children: <Widget>[
              Row(
              children: <Widget>[
              Text("nombre de places Dispo: ${this.listSalles[index]['currentProjection']['nombrePlaceDisponibles']}")
              ],
              ),
              Container(
              padding:EdgeInsets.fromLTRB(6,2,6,3),
              child: TextField(
              decoration: InputDecoration(hintText:'Your Name' ),
              ),
              ),
              Container(
              padding:EdgeInsets.fromLTRB(6,2,6,3),
              child: TextField(
              decoration: InputDecoration(hintText:'Code Payement' ),
              ),
              ),
              Container(
              padding:EdgeInsets.fromLTRB(6,2,6,3),
              child: TextField(
              decoration: InputDecoration(hintText:'Nombre de Tickets' ),
              ),
              ),
              Container(
              width: double.infinity,
              child: RaisedButton(
              color: Colors.white,
              child: Text(" Réserver les places",style: TextStyle(color: Colors.black),
              ),
              onPressed: (){

              },
              ),
              ),

              Wrap(
              children: <Widget>[
              ...(this.listSalles[index]['currentProjection']['listTickets']).map((ticket){
              if(ticket['reservee']==false)
              return Container(
              width: 55,
              padding: EdgeInsets.all(3),
              child: RaisedButton(
              color: Colors.deepOrange,
              child: Text("${ticket['place']['numero']}",
              style:TextStyle(color: Colors.white,fontSize: 12) ,),
              onPressed: (){

              },
              ),
              );
              else return Container();
              })

              ],
              )
              ],
              )
              ],
              )
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
    loadSalles();
  }


  void loadSalles() {
    String url = this.widget.cinema['_links']['salles']['href'];
    http.get(url).then((resp) {
      setState(() {
        this.listSalles = json.decode(resp.body)['_embedded']['salles'];
      });
    }).catchError((err) {
      print(err);
    });
  }

  void loadProjections(salle) {
    String url=salle['_links']['projections']['href'].toString().replaceAll("{?projection}","?projection=p1");
    //print(url1);
    print(url);
    http.get(url).then((resp){
      setState(() {
        salle['projections']=json.decode(resp.body)['_embedded']['projections'];
        salle['currentProjection']= salle['projections'][0];
        //salle['currentProjection']['listTickets']=[];
        print(salle['projections']);
      });

    }).catchError((err){
      print(err);

    });

  }
  void loadTickets(projection,salle) {
    //String url="http://192.168.1.102:8080/projections/1/tickets?projection=ticketProj";
   String url=projection['_links']['tickets']['href'].toString().replaceAll("{?projection}","?projection=ticketProj");
    print(url);
    http.get(url).then((resp){

      setState((){
        projection['listTickets']=json.decode(resp.body)['_embedded']['tickets'];
        salle['currentProjection']=projection;
        projection['nombrePlaceDisponibles']=nombrePlaceDisponibles(projection);

      });
    }).catchError((err){
      print(err);
    });


  }
  nombrePlaceDisponibles(projection){
    int nombre=0;
    for(int i=0;i<projection['tickets'].length;i++){
      if(projection['tickets'][i]['reservee']==false) ++nombre;
    }
    return nombre;
  }

}




