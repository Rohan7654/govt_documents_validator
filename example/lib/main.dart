import 'package:flutter/material.dart';
import 'package:govt_documents_validator/govt_documents_validator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        brightness: Brightness.light,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  AadharValidator av = new AadharValidator();
  void _submit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form-Validation In Flutter"),
        elevation: 2.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        //form
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                cursorColor: Colors.green,
                decoration: InputDecoration(labelText: 'Aadhar Number'),
                onFieldSubmitted: (value) {},
                validator: (value) {
                  if (av.validate(value) == true) {
                    return null;
                  }
                  return "Incorrect";
                },
              ),
              //box styling
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              //text input
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                padding: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 10.0,
                ),
                child: Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () => _submit(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
