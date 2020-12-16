import 'package:flutter/material.dart';
import 'package:onepic/services/auth.dart';

class RegisterPage extends StatefulWidget {
  final String title = 'Registration';
  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
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
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
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
                        ),
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
      Navigator.of(context).pushNamed('/');
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
