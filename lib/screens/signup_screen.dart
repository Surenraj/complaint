import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/authentication.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'auth_helper.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    _nameController = TextEditingController(text: "");
  }

  Map<String, String> _authData = {'email': '', 'password': ''};

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An Error Occured'),
              content: Text(msg),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    try {
      await Provider.of<Authentication>(context, listen: false)
          .signUp(_authData['email'], _authData['password']);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (error) {
      var errorMessage = 'Authentication Failed. Please try again later.';
      _showErrorDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
        actions: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[Text('Login'), Icon(Icons.person)],
            ),
            textColor: Colors.white,
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.white,
              Colors.white,
            ])),
          ),
          Center(
            // child: Card(
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(10.0),
            //   ),
            child: Container(
              height: 700,
              width: 300,
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 150,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Username'),
                        obscureText: false,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Username cannot be empty';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _nameController.text = value;
                        },
                      ),

                      //email
                      // TextField(
                      //   decoration: InputDecoration(labelText: 'Email'),
                      //   keyboardType: TextInputType.emailAddress,
                      //   controller: _emailController,
                      //   // validator: (value) {
                      //   //   if (value.isEmpty || !value.contains('@')) {
                      //   //     return 'invalid email';
                      //   //   }
                      //   //   return null;
                      //   // },
                      //   // onSaved: (value) {
                      //   //   _emailController.text = value;
                      //   // },
                      // ),

                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            labelText: "Email",
                            // prefixIcon: Icon(
                            //   Icons.email,
                            //   color: Colors.grey,
                            // ),
                            hintText: "",
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),

                      //password
                      TextField(
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        controller: _passwordController,
                        // validator: (value) {
                        //   if (value.isEmpty || value.length <= 5) {
                        //     return 'invalid password';
                        //   }
                        //   return null;
                        // },
                        // onSaved: (value) {
                        //   //_passwordController.text = value;
                        // },
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      RaisedButton(
                        child: Text('Submit'),
                        onPressed: () async {
                          try {
                            print("User Details " +
                                _emailController.text +
                                " " +
                                _nameController.text +
                                " " +
                                _passwordController.text);
                            final user = await AuthHelper.signUpWithEmail(
                                name: _nameController.text,
                                email: _emailController.text,
                                password: _passwordController.text);
                            if (user != null) {
                              Fluttertoast.showToast(msg: "Signup successful");
                              print("Signup successful");
                              Navigator.pop(context);
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                            } else if (user == null) {
                              Fluttertoast.showToast(
                                  msg: "User with this Email already exists");
                            }
                          } catch (e) {
                            print(e.code);
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        color: Colors.blue,
                        textColor: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
