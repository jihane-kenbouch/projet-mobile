import 'package:flutter/material.dart';
import 'package:flutter_app_cinema/Register.dart';
import 'package:flutter_app_cinema/main.dart';


class login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<login> {
  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: Text('Login CINEMA'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                print('register');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Register()));
              },
              icon: Icon(Icons.person),
              label: Text('Register'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Image.asset('image/cinema1.png'),
             SizedBox(
                height: 50.0,
             ),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'email'
                ),
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars' : null,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'password'
                ),
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
                obscureText: true,
              ),
              SizedBox(
                height: 50.0,
              ),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: (){
                  if(_formKey.currentState.validate()){
                    print('OK!!!!!!');
                    print(email);
                    print(password);
                    //FireBase Auth

                    Navigator.push(context,
                        MaterialPageRoute(
                        builder: (context)=>MyApp()));
                  }

                },
              )
            ],
          ),
        ),
      ),
    );
  }
}