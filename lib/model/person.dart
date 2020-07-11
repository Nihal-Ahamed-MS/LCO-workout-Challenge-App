import 'package:firebase_database/firebase_database.dart';

class Person{

  String _id, _name, _email, _mode;

// This constructor for storing the values

  Person(this._name,this._email,this._mode);

// This constuctor is for editing the values (id)

  Person.withId(this._id,this._name,this._email,this._mode);

// This is getter to take the values from outside the class

String get id => this._id;
String get name => this._name;
String get email => this._email;
String get mode => this._mode;

// This is setter to store the values to the variable

set name (String name){
  this._name = name;
}
set email (String email){
  this._email = email;
}
set mode (String mode){
  this._mode = mode;
}


// This dataSnapshot is used to get values from the json object and to assigned it the variables

Person.fromSnapShot(DataSnapshot snapshot){
  this._id = snapshot.key;
  this._name = snapshot.value['name'];
  this._email = snapshot.value['email'];
  this._mode = snapshot.value['mode'];
}

// This Map<String, dynamic> is used to return the values in json fomrat to database.

Map<String, dynamic> toJson(){
  return{
    "name" : _name,
    "email" : _email,
    "mode" : _mode,
  };
}

}