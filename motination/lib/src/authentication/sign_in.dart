import 'package:flutter/material.dart';
import 'package:motination/services/auth.dart';
import 'package:motination/shared/constants.dart';
import 'package:motination/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field State
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text('Login MotiNation'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.white,
              ),
            label: Text(
              'Registrieren',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              widget.toggleView();
            }
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'E-Mail Adresse'),
                validator: (val) => val.isEmpty ? 'E-Mail Adresse' : null,
                onChanged: (val) {
                  setState(() => email = val);
                }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'gültiges Passwort'),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'falsches Passwort' : null,
                onChanged: (val) {
                  setState(() => password = val);
                }
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.blue,
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                 if(_formKey.currentState.validate()){
                   setState(() => loading = true);
                    dynamic result = await _auth.signInrWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() { 
                        error = 'Bitte geben Sie eine gülitig E-Mail Adresse/Passwort ein';
                        loading = false;
                      });
                    } 
                  }
                }
                ),
                SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                   ),
            ],
          ),
          ),
      ),
    );
  }
}