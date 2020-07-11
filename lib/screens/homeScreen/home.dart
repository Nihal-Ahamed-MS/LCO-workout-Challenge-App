import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../model/person.dart';
import '../select.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  
 
  @override
   _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {


  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseUser user;

  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();
  DataSnapshot snapshot;
  Person person;
  String _uid;

    
  bool ran = false, man= false;
  var _modes = ['Random','Manual'];
  var currentItem='Random';

  Future checkCurrentSCreen() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool _isSeen = (preferences.getBool('seen')??false);

    if(_isSeen){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Select(text:_uid)));
    }
    else{
      await (preferences.setBool('seen', true));
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Select(text:_uid)));
    }
    
  }


  bool isSigned = false;

    checkAuthState(){
    firebaseAuth.onAuthStateChanged.listen((user) async {
      if(user == null){
        Navigator.pushReplacementNamed(context, "/signin");
      }

    });
  }

  getUser() async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    await firebaseUser?.reload();
    firebaseUser = await firebaseAuth.currentUser();

    if(firebaseUser!=null){
      setState(() {
        this.user = firebaseUser;
        this._uid = firebaseUser.uid;
        this.isSigned = true;
      });
    }
  }

  store()async{
    await _databaseReference.child("datas").child(_uid).child("mode").set(currentItem);
  }

  signOut() async {
    firebaseAuth.signOut();
  }

  @override
  void initState() {

    super.initState();
    this.checkAuthState();
    this.getUser();
    //this.checkCurrentSCreen();
  }


   @override
   Widget build(BuildContext context) {
     
     return Scaffold(
       backgroundColor: Colors.white,
       body: Center(
         child: Column(
           children: <Widget>[
              Container(
                      margin: EdgeInsets.only(top: 0.0),
                      child: Image(
                        image: AssetImage("assets/images/lco.png"),
                        height: 400,
                        width: 300,
                      )
                    ),

              Container(
                padding: EdgeInsets.only(top:10.0,left:25.0),
                alignment: Alignment.centerLeft,
                child: Text("Select a Mode",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30
                )
                ),
              ),
              SizedBox(height: 20.0,),
               Container(
                 width: 355.0,
                 decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.white,
                      boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                    ),
                 padding: EdgeInsets.only(right:30.0,left:30.0),
                 child: DropdownButton<String> (
                               items: _modes.map((String dropDownStringItem){
                                 return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Text(dropDownStringItem),
                                 );
                               }).toList(),
                               onChanged: (String newValue){
                                 setState(() {
                                   if(newValue == 'Random'){
                                     ran = true;
                                   }else{
                                     man = true;
                                   }
                                   this.currentItem = newValue;
                                   print(currentItem);
                                 });
                               },
                               hint: Text('Select a Mode'),
                               value: currentItem,
                               elevation: 24,
                               isExpanded: true,
                               itemHeight: 55,
                         ),
               ),
                       SizedBox(height: 20.0,),
             Container(
               padding: EdgeInsets.only(top: 35.0,right:25.0),
               alignment: Alignment.centerRight,
               child: RaisedButton(
                 child: Text("Next",style: TextStyle(color: Colors.white),),
                 color: Colors.blue,
                 onPressed: (){
                   store();
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Select(text:_uid)));
                 },
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(10.0)
                 ),
                 elevation: 8,
               )
             )
           ],
         ),
       ),
     );
  }

} 