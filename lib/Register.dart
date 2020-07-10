import 'package:flutter/material.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}
class _RegisterState extends State<Register> {
  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: Text('Register CINEMA'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Image.asset('assets/image/cinema.png'),
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
                  ' Sign UP ',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: (){
                  if(_formKey.currentState.validate()){
                    print('OK!!!!!!');
                    print(email);
                    print(password);
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