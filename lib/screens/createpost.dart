//import 'dart:html';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//import 'usersposts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';
//import 'package:image_cropper/image_cropper.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
//import 'users.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:group_radio_button/group_radio_button.dart';

class createpost extends StatefulWidget {
  @override
  _createpostState createState() => _createpostState();
}

class _createpostState extends State<createpost> {
  TextEditingController _nameController;
  TextEditingController _phoneController;
  TextEditingController _streetController;
  TextEditingController _townController;
  TextEditingController _cityController;
  TextEditingController _districtController;
  TextEditingController _stateController;
  TextEditingController _pinController;
  TextEditingController _genderController;
  TextEditingController _aadharController;

  String _categoryVal;
  String _postType;
  String _url;

  String imageurl;
  File image;
  String filename;
  bool _isloading = false;
  double _progress;
  //final User user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: "");
    _phoneController = TextEditingController(text: "");
    _streetController = TextEditingController(text: "");
    _townController = TextEditingController(text: "");
    _cityController = TextEditingController(text: "");
    _districtController = TextEditingController(text: "");
    _stateController = TextEditingController(text: "");
    _pinController = TextEditingController(text: "");
    _genderController = TextEditingController(text: "");
    _aadharController = TextEditingController(text: "");
  }

  progress(loading) {
    if (loading) {
      return Column(
        children: <Widget>[
          LinearProgressIndicator(
            value: _progress,
            backgroundColor: Colors.red,
          ),
          Text('${(_progress * 100).toStringAsFixed(2)} %'),
        ],
      );
    } else {
      return Text('Nothing');
    }
  }

  Widget _Nametextfield() {
    return TextField(
      controller: _nameController,
      decoration: InputDecoration(
          labelText: "Name",
          hintText: "Your name",
          border: OutlineInputBorder()),
    );
  }

  Widget _Phonetextfield() {
    return TextField(
      controller: _phoneController,
      decoration: InputDecoration(
          labelText: "Phone",
          hintText: "Phone number",
          border: OutlineInputBorder()),
      //maxLines: 18,
    );
  }

  Widget _Streettextfield() {
    return TextField(
      controller: _streetController,
      decoration: InputDecoration(
          labelText: "Street",
          hintText: "Flat No./Street",
          border: OutlineInputBorder()),
    );
  }

  Widget _Towntextfield() {
    return TextField(
      controller: _townController,
      decoration: InputDecoration(
          labelText: "Town", hintText: "Town", border: OutlineInputBorder()),
    );
  }

  Widget _Citytextfield() {
    return TextField(
      controller: _cityController,
      decoration: InputDecoration(
          labelText: "City", hintText: "City", border: OutlineInputBorder()),
    );
  }

  Widget _Gendertextfield() {
    return TextField(
      controller: _genderController,
      decoration: InputDecoration(
          labelText: "Gender",
          hintText: "Gender",
          border: OutlineInputBorder()),
    );
  }

  Widget _Aadhartextfield() {
    return TextField(
      controller: _aadharController,
      decoration: InputDecoration(
          labelText: "AAdhar Number",
          hintText: "Aadhar Number",
          border: OutlineInputBorder()),
    );
  }

  Widget _Districttextfield() {
    return TextField(
      controller: _districtController,
      decoration: InputDecoration(
          labelText: "District",
          hintText: "District",
          border: OutlineInputBorder()),
    );
  }

  Widget _Statetextfield() {
    return TextField(
      controller: _stateController,
      decoration: InputDecoration(
          labelText: "State", hintText: "State", border: OutlineInputBorder()),
    );
  }

  Widget _Pintextfield() {
    return TextField(
      controller: _pinController,
      decoration: InputDecoration(
          labelText: "Pin",
          hintText: "Pin/Zip code",
          border: OutlineInputBorder()),
    );
  }

  String _singleValue = "Both";

  Widget _radiobuttonfield() {
    return Container(
      width: 150,
      child: Row(
        children: <Widget>[
          Container(
            child: Row(
              children: [
                RadioButton(
                    description: "Both",
                    value: "Both",
                    groupValue: _singleValue,
                    onChanged: (value) => {
                          setState(
                            () => _singleValue = value,
                          ),
                          print(_singleValue)
                        }),
                RadioButton(
                    description: "Experienced",
                    value: "Experienced",
                    groupValue: _singleValue,
                    onChanged: (value) => {
                          setState(
                            () => _singleValue = value,
                          ),
                          print(_singleValue)
                        }),
                RadioButton(
                    description: "Fresher",
                    value: "Fresher",
                    groupValue: _singleValue,
                    onChanged: (value) => {
                          setState(
                            () => _singleValue = value,
                          ),
                          print(_singleValue)
                        }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text(
            "Admin Panel",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          iconTheme: new IconThemeData(color: Colors.white),
        ),
        body: ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            SizedBox(height: 5.0),
            _Nametextfield(),
            SizedBox(height: 10.0),
            // DropdownButton(
            //   hint: _categoryVal == null
            //       ? Text('Post category')
            //       : Text(
            //           _categoryVal,
            //           style: TextStyle(color: Colors.black),
            //         ),
            //   isExpanded: true,
            //   iconSize: 30.0,
            //   style: TextStyle(color: Colors.orange),
            //   items: [
            //     "Government Job",
            //     "Internship",
            //     "Private Job",
            //     "Walkin",
            //     "Scholarship",
            //     "Events"
            //   ].map(
            //     (val) {
            //       return DropdownMenuItem<String>(
            //         value: val,
            //         child: Text(val),
            //       );
            //     },
            //   ).toList(),
            //   onChanged: (val) {
            //     setState(
            //       () {
            //         _categoryVal = val;
            //       },
            //     );
            //   },
            // ),
            SizedBox(height: 10.0),
            _Phonetextfield(),
            SizedBox(height: 10.0),
            _Phonetextfield(),
            SizedBox(height: 10.0),
            _Gendertextfield(),
            SizedBox(height: 10.0),
            _Aadhartextfield(),
            SizedBox(height: 10.0),
            _Towntextfield(),

            SizedBox(height: 10.0),
            _Citytextfield(),
            SizedBox(height: 10.0),
            _Statetextfield(),
            SizedBox(height: 10.0),
            _Pintextfield(),
            SizedBox(height: 10.0),
            Container(
              height: 50,
              child: Center(
                child: RaisedButton(
                  onPressed: () async {
                    if (_nameController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Please enter name!!");
                      return;
                    }

                    if (_phoneController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Please enter phone!!");
                      return;
                    }
                    if (_streetController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Please enter street!!");
                      return;
                    }
                    if (_townController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Please enter town!!");
                      return;
                    }
                    if (_cityController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Please enter city!!");
                      return;
                    }
                    if (_stateController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Please enter state!!");
                      return;
                    }
                    if (_pinController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Please enter pin!!");
                      return;
                    } else {
                      print(_nameController.text);

                      // ignore: deprecated_member_use
                      Firestore.instance
                          .collection('User Details')
                          // ignore: deprecated_member_use
                          .doc()
                          // ignore: deprecated_member_use
                          .set({
                        "name": _nameController.text,
                        "phone": _phoneController.text,
                        "gender": _genderController.text,
                        "aadhar": _aadharController.text,
                        "street": _streetController.text,
                        "town": _townController.text,
                        "city": _cityController.text,
                        "posted_on": "${DateTime.now()}",
                        //"posted_by": "${user.email}",
                        "state": _stateController.text,
                        "pin": _pinController.text,
                      }).then((value) => Fluttertoast.showToast(
                              msg: " Posted Successfully!!"));

                      //Fluttertoast.showToast(msg: " Posted Failure!!");
                      //Navigator.pop(context);
                      return;
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: const EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue[500],
                          Colors.blue[200],
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(80.0)),
                    ),
                    child: Container(
                      constraints: const BoxConstraints(
                          minWidth: 88.0,
                          minHeight: 36.0), // min sizes for Material buttons
                      alignment: Alignment.center,
                      child: Text("SUBMIT",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
