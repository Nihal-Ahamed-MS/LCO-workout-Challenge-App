import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../homeScreen/home.dart';
import 'package:firebase_database/firebase_database.dart';


class Login extends StatefulWidget {
  @override
   _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login> {
    final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();
  DataSnapshot snapshot;

  String _email, _pass,_name;
  

  checkAuth(){
    _auth.onAuthStateChanged.listen((user) async {
      if(user != null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
      }
    });
  }

  signUp()async{
      if(_form.currentState.validate()){
        _form.currentState.save();

        try{
          FirebaseUser user = (await _auth.createUserWithEmailAndPassword(email: _email, password: _pass)).user;
          if(user!=null){
            UserUpdateInfo userUpdateInfo = UserUpdateInfo();
            userUpdateInfo.displayName = _name;
            user.updateProfile(userUpdateInfo);
          }
           
        }catch(e){
          showError(e.message);
        }
      }
    }

  showError(String error){
    showDialog(context: context,
      builder: (BuildContext){
        return AlertDialog(
          title: Text("Error"),
          content: Text(error),
          actions: <Widget>[
            FlatButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text("OK"))
          ],
        );
      }
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAuth();
  }
   @override
   Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
          padding: EdgeInsets.only(left: 25.0,right: 25.0),
         child: Form(
           key: _form,
           child: SingleChildScrollView(
             child: Center(
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
                    SizedBox(height: 20.0),
                    Container(

                           child: TextFormField(
                             decoration: InputDecoration(
                               labelText: 'Name',
                               border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(20.0),
                                
                               )
                             ),
                             onSaved: (input) => _name = input,
                           ),
                         ),
                    Container(
                           padding: EdgeInsets.only(top:20.0),
                           child: TextFormField(
                             validator: (input){
                               if(input.isEmpty)
                               {
                                 return "Provide an email";
                               }
                             },
                             decoration: InputDecoration(
                               labelText: 'Email',
                               border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(20.0),
                                
                               )
                             ),
                             onSaved: (input) => _email = input,
                           ),
                         ),
                         SizedBox(height: 20.0),
                         Container(
                         child: TextFormField(
                           validator: (input){
                             if(input.length < 6)
                             {
                               return "6 character is must";
                             }
                           },
                           decoration: InputDecoration(
                             labelText: 'Password',
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(20.0),
                              
                             )
                           ),
                           onSaved: (input) => _pass = input,
                           obscureText: true,
                         ),
                       ),
                                                
                         SizedBox(height:20.0),
                          Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 40),
                        child: RaisedButton(
                          
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)
                          )                          ,
                          onPressed: signUp,
                          child: Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 20.0, color: Colors.white)
                          ),
                        ),
                       ),
                  ],
                )
             ),
           )
         ),
       ),
    );
  }
} 