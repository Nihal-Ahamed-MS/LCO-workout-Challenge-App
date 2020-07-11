import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'details.dart';
import '../model/excercise.dart';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';

class Select extends StatefulWidget {
  String text;
  Select({Key key, @required this.text}) : super (key: key);

  @override
   _SelectState createState() => _SelectState(key: key,text: text);
}
class _SelectState extends State<Select> {

  String text,_mode;
  bool isMode=true;
  _SelectState({Key key,@required this.text});

  static String _sett = "Settings";
  static String _abt = "About us";
  static String _signout = "Log Out";
  String ranPath,ranName,ranDes,ranSong;
  String ranTime;

  static List<String> choices= <String>[_sett,_abt,_signout];

  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

   getData(){
    _databaseReference = FirebaseDatabase.instance.reference().child("datas").child(text);
    _databaseReference.once().then((DataSnapshot snapshot){
      var data = snapshot.value;

      setState(() {
        _mode = data['mode'];
        if (_mode =='Random') {
          isMode = true;
        } else {
          isMode = false;
        }
      });
    });
  }

    signOut() async {
    firebaseAuth.signOut();
    
  }

    void popUpSelectedNavigate(String choice){
    if(choice == _sett){
      
    }
    else if(choice == _abt){

    }
    else if(choice == _signout){
      signOut();
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    random();
  }

  getcards(double value, String photoUrl1, String name1,String time1, String descp1, String songUrl1, String photoUrl2, String name2,String time2, String descp2, String songUrl2,){
    return Positioned(
                top: value,
                left: (MediaQuery.of(context).size.width /2) - 168.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FittedBox(
                      child: Container(
                        height: 160.0,
                        width: 160.0,
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
                        child: Column(
                          children: <Widget>[
                            InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Details(heroTag: photoUrl1,exName:name1,exTime:time1,exDesc:descp1,exMusic:songUrl1)));
                              },
                              child: Hero(
                                  tag: photoUrl1,
                                  child: Image(
                                  image: AssetImage(photoUrl1),
                              height: 130.0,
                              width: 130.0,
                            ),
                          ),
                        ),
                        Text(name1,style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                  )
                ),
                SizedBox(width: 20.0),
                FittedBox(
                  child: Container(
                    height: 160.0,
                    width: 160.0,
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
                    child: Column(
                          children: <Widget>[
                            InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Details(heroTag: photoUrl2,exName:name2,exTime:time2,exDesc:descp2,exMusic: songUrl2,)));
                              },
                              child: Hero(
                                  tag: photoUrl2,
                                  child: Image(
                                  image: (photoUrl2==ranPath)?AssetImage(Ran.PATH):AssetImage(photoUrl2),
                              height: 130.0,
                              width: 130.0,
                            ),
                          ),
                        ),
                       (photoUrl2==ranPath)?Text(Ran.NAME,style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                        ),) : Text(name2,style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                  )
                ),
              ],
            )
          );
  }

  Widget _randomMode(BuildContext context){
        return Scaffold(
          backgroundColor: Colors.purple,
          body: Stack(
            children: <Widget>[
              Positioned(
                child: AppBar(
                  leading: IconButton(icon: Icon(Icons.home), onPressed: _launchURL),
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  title: Text("LCO WORKOUT", style: TextStyle(fontSize: 20.0, fontFamily: 'Montserrat')),
                  actions: <Widget>[
                  PopupMenuButton<String>(
                     icon: Icon(Icons.more_horiz),
                     onSelected: popUpSelectedNavigate,
                     itemBuilder: (BuildContext context){
                         return choices.map((String choice){
                            return PopupMenuItem<String>(
                                value: choice,
                                 child: Text(choice),
                      );
                  }).toList();
                },
              )
            ],
          ),
              ),
              // Container(
              //   height: MediaQuery.of(context).size.height - 82.0,
              //   width:  MediaQuery.of(context).size.width,
              //   color: Colors.transparent, 
              // ),
              // SizedBox(height: 50),
              Positioned(
                top: 200.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45.0),
                      topRight: Radius.circular(45.0),
                    ),
                    color: Colors.white
                  ),
                  height: MediaQuery.of(context).size.height - 100.0,
                  width: MediaQuery.of(context).size.width,
                )
              ),
              getcards(140.0,PushUps.PATH,PushUps.NAME,PushUps.DURATION,PushUps.DESCRIPTION,PushUps.SONGPATH,Crunches.PATH,Crunches.NAME,Crunches.DURATION,Crunches.DESCRIPTION,Crunches.SONGPATH),
              getcards(340.0,InCrunches.PATH,InCrunches.NAME,InCrunches.DURATION,InCrunches.DESCRIPTION,InCrunches.SONGPATH,Curl.PATH,Curl.NAME,Curl.DURATION,Curl.DESCRIPTION,Curl.SONGPATH),
              getcards(540,LegRaise.PATH,LegRaise.NAME,LegRaise.DURATION,LegRaise.DESCRIPTION,LegRaise.SONGPATH,ranPath,ranName,ranTime,ranDes,ranSong),

        ],
      ),
     
    );
  }

  Widget _manualMode(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("LCO WORKOUT", style: TextStyle(fontSize: 24)),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(Icons.more_horiz),
            onSelected: popUpSelectedNavigate,
            itemBuilder: (BuildContext context){
              return choices.map((String choice){
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
              }).toList();
            },
          )
        ],
      ),
    );
  }
  random(){
  var _classNames = ['FlatCrunches','Yoga','BenchPress','PullDowns','InclinedBenchPress'];
  var ran = Random().nextInt(_classNames.length);
  for (var i = 0; i < _classNames.length; i++) {
    if(_classNames[ran]=='FlatCrunches'){
      this.ranSong = FlatCrunches.SONGPATH;
      this.ranPath = FlatCrunches.PATH;
      this.ranName = FlatCrunches.NAME;
      this.ranTime = FlatCrunches.DURATION;
      this.ranDes = FlatCrunches.DESCRIPTION;
      print(_classNames[ran]);
    }
    else if(_classNames[ran]=='Yoga'){
      this.ranSong = Yoga.SONGPATH;
      this.ranPath = Yoga.PATH;
      this.ranName = Yoga.NAME;
      this.ranTime = Yoga.DURATION;
      this.ranDes = Yoga.DESCRIPTION;
      print(_classNames[ran]);
    }
    else if(_classNames[ran]=='BenchPress'){
      this.ranSong = BenchPress.SONGPATH;
      this.ranPath = BenchPress.PATH;
      this.ranName = BenchPress.NAME;
      this.ranTime = BenchPress.DURATION;
      this.ranDes = BenchPress.DESCRIPTION;
      print(_classNames[ran]);
    }
    else if(_classNames[ran]=='PullDowns'){
      this.ranSong = PullDowns.SONGPATH;
      this.ranPath = PullDowns.PATH;
      this.ranName = PullDowns.NAME;
      this.ranTime = PullDowns.DURATION;
      this.ranDes = PullDowns.DESCRIPTION;
      print(_classNames[ran]);
    }
    else if(_classNames[ran]=='InclinedBenchPress'){
      this.ranSong = InclinedBenchPress.SONGPATH;
      this.ranPath = InclinedBenchPress.PATH;
      this.ranName = InclinedBenchPress.NAME;
      this.ranTime = InclinedBenchPress.DURATION;
      this.ranDes = InclinedBenchPress.DESCRIPTION;
      print(_classNames[ran]);
    }
  }
  }

  void _launchURL() async {
  const url = 'https://web.learncodeonline.in/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}



   @override
   Widget build(BuildContext context) {
    return isMode ? _randomMode(context) : _manualMode(context);
  }
} 