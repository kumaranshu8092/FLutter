import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthForm extends StatefulWidget {

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();

// form entry variables form email and password
  var _email = '';
  var _password = '';
  String _username = '';
  bool isLoginPage = false;
  //===============================

  bool _passwordVisible = false;
  

  //============================================
  startauthentication() {
    final validity = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (validity) {
      _formkey.currentState!.save();
      submitform(_email, _password, _username);
    }
  }

  submitform(String email, String password, String username) async {
    final auth = FirebaseAuth.instance;
    UserCredential authResult;
    try {
      if (isLoginPage) {
        authResult = await auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
            String uid = authResult.user!.uid;
        await FirebaseFirestore.instance
            .collection('users').doc(uid).
            set({'username': username, 'email': email});
      }
    } catch (err) {
      // ignore: avoid_print
      print(err);
    }
  }

  //============================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [Container(
            height: 200,
            child: Image.asset('assets/todo.png'),

          ),
          const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
              ),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!isLoginPage)
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        key: const ValueKey('username'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Incorrect Username';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _username = value as String;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide()),
                            labelText: "Enter Username",
                            labelStyle: GoogleFonts.roboto()),
                      ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key: const ValueKey('email'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Incorrect Email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value as String;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide()),
                          labelText: "Enter Email",
                          labelStyle: GoogleFonts.roboto()),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      obscureText: _passwordVisible,
                      key: const ValueKey('password'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Incorrect Password';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value as String;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide()),
                        labelText: "Enter Password",
                        labelStyle: GoogleFonts.roboto(),
                        suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              },
                              );
                            },
                            ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 70,
                      child: RaisedButton(
                          child: isLoginPage
                              ? Text(
                                  'Login',
                                  style: GoogleFonts.roboto(fontSize: 16),
                                )
                              : Text(
                                  'SignUp',
                                  style: GoogleFonts.roboto(fontSize: 16),
                                ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            startauthentication();
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              isLoginPage = !isLoginPage;
                            });
                          },
                          child: isLoginPage
                              ?  Text('Not a member?',style: GoogleFonts.roboto(fontSize:16,color:Colors.white))
                              :  Text('Already a member?',style: GoogleFonts.roboto(fontSize:16,color:Colors.white))),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
