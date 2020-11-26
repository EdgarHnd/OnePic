import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onepic/screens/home.dart';
import 'package:onepic/screens/user_profile.dart';
import '../services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onepic/shared/shared.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text("Welcome",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(createRoute(_RegisterEmailSection()));
              },
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)),
              child: const Text(
                'Register',
                style: TextStyle(color: Colors.white),
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).push(createRoute(_EmailPasswordForm()));
              },
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)),
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _RegisterEmailSection extends StatefulWidget {
  final String title = 'Registration';
  @override
  State<StatefulWidget> createState() => _RegisterEmailSectionState();
}

class _RegisterEmailSectionState extends State<_RegisterEmailSection> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  String username;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text(widget.title,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  autocorrect: false,
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Choose your username';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    username = val;
                  },
                ),
                TextFormField(
                  autocorrect: false,
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Enter your email';
                    }
                    if (!value.contains("@")) {
                      return 'Email not valid';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    email = val;
                  },
                ),
                TextFormField(
                  autocorrect: false,
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password too short';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    password = val;
                  },
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  alignment: Alignment.center,
                  child: Column(children: [
                    RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _createAccount();
                        }
                      },
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      child: const Text(
                        'Back',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _createAccount() async {
    final status = await FirebaseAuthHelper()
        .createAccount(username: username, email: email, pass: password);
    if (status == AuthResultStatus.successful) {
      Navigator.of(context).push(createRoute(HomePage()));
    } else {
      final errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
      _showAlertDialog(errorMsg);
    }
  }

  _showAlertDialog(errorMsg) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Registration Failed',
              style: TextStyle(color: Colors.black),
            ),
            content: Text(errorMsg),
          );
        });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class _EmailPasswordForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmailPasswordFormState();
}

class _EmailPasswordFormState extends State<_EmailPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text("Login",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                autocorrect: false,
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Enter your email';
                  }
                  return null;
                },
                onChanged: (val) {
                  email = val;
                },
              ),
              TextFormField(
                autocorrect: false,
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Enter your password';
                  }
                  return null;
                },
                onChanged: (val) {
                  password = val;
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _login();
                        }
                      },
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      child: const Text('Submit',
                          style: TextStyle(color: Colors.white)),
                    ),
                    RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        child: const Text(
                          'Back',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _login() async {
    final status =
        await FirebaseAuthHelper().login(email: email, pass: password);
    if (status == AuthResultStatus.successful) {
      Navigator.of(context).push(createRoute(HomePage()));
    } else {
      final errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
      _showAlertDialog(errorMsg);
    }
  }

  _showAlertDialog(errorMsg) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Login Failed',
              style: TextStyle(color: Colors.black),
            ),
            content: Text(errorMsg),
          );
        });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
