import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  List<String> drop1 = ['Type 1', 'Type 2', 'Type 3', 'Type 4', 'Type 5'];
  List<String> drop2 = ['Type 1', 'Type 2', 'Type 3', 'Type 4', 'Type 5'];
  List<String> drop3 = ['Type 1', 'Type 2', 'Type 3', 'Type 4', 'Type 5'];
  List<String> drop4 = ['Type 1', 'Type 2', 'Type 3', 'Type 4', 'Type 5'];
  List<String> drop5 = ['Type 1', 'Type 2', 'Type 3', 'Type 4', 'Type 5'];

  List<String> provinces = [];
  String dropdown_1;
  String dropdown_2;
  String dropdown_3;
  String dropdown_4;
  String dropdown_5;
  String input;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Page'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          DropdownButton<String>(
            hint: Text('Drop 1'),
            value: dropdown_1,
            isExpanded: true,
            items: drop1.map((String newvalue) {
              return DropdownMenuItem<String>(
                value: newvalue,
                child: Text(newvalue),
              );
            }).toList(),
            onChanged: (newvalue) {
              setState(() {
                dropdown_1 = newvalue;
              });
            },
          ),
          SizedBox(height: 10.0),
          DropdownButton<String>(
            hint: Text('Drop 2'),
            value: dropdown_2,
            isExpanded: true,
            items: drop1.map((String newvalue) {
              return DropdownMenuItem<String>(
                value: newvalue,
                child: Text(newvalue),
              );
            }).toList(),
            onChanged: (newvalue) {
              setState(() {
                dropdown_2 = newvalue;
              });
            },
          ),
          SizedBox(height: 10.0),
          DropdownButton<String>(
            hint: Text('Drop 3'),
            value: dropdown_3,
            isExpanded: true,
            items: drop1.map((String newvalue) {
              return DropdownMenuItem<String>(
                value: newvalue,
                child: Text(newvalue),
              );
            }).toList(),
            onChanged: (newvalue) {
              setState(() {
                dropdown_3 = newvalue;
              });
            },
          ),
          SizedBox(height: 10.0),
          DropdownButton<String>(
            hint: Text('Drop 4'),
            value: dropdown_4,
            isExpanded: true,
            items: drop1.map((String newvalue) {
              return DropdownMenuItem<String>(
                value: newvalue,
                child: Text(newvalue),
              );
            }).toList(),
            onChanged: (newvalue) {
              setState(() {
                dropdown_4 = newvalue;
              });
            },
          ),
          SizedBox(height: 10.0),
          DropdownButton<String>(
            hint: Text('Drop 5'),
            value: dropdown_5,
            isExpanded: true,
            items: drop1.map((String newvalue) {
              return DropdownMenuItem<String>(
                value: newvalue,
                child: Text(newvalue),
              );
            }).toList(),
            onChanged: (newvalue) {
              setState(() {
                dropdown_5 = newvalue;
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Input'),
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value.isEmpty) {
                return 'invalid';
              }
              return null;
            },
            onSaved: (value) {
              input = value;
            },
          ),
          SizedBox(
            height: 30,
          ),
          RaisedButton(
            child: Text('Submit'),
            onPressed: () =>
                {Fluttertoast.showToast(msg: "Posted Successfully!!!")},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            color: Colors.blue,
            textColor: Colors.white,
          )
        ],
      ),
    );
  }
}
