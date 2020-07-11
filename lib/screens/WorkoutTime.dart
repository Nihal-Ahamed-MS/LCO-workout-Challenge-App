import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';


class WorkoutTime extends StatefulWidget {
  final time;
  final title;
  final music;
  WorkoutTime({this.time,this.title,this.music});
  @override
   _WorkoutTimeState createState() => _WorkoutTimeState();
}
class _WorkoutTimeState extends State<WorkoutTime> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timeInt = int.parse(widget.time);
    print(timeInt);
    initializePlayer();
  }

  void initializePlayer(){
    _audioPlayer = AudioPlayer();
    _audioCache = AudioCache(fixedPlayer: _audioPlayer);
  }

  AudioPlayer _audioPlayer;
  AudioCache _audioCache;

  var timeInt;
  bool started = true;
  bool stopped = true;
  int timeCalculated = 0;
  String timeDisplayed='';
  bool cancelTimer = true;
  bool string = false;
  String _stop = 'Stop';
  String _break = 'Break Time';
  int innerTime = 0;

  void start(){
    _audioCache.play(widget.music);
    
    setState(() {
      started = false;
      stopped = false;
    });
    if(timeInt<=5){
      timeCalculated = timeInt * 60;
    }else {
      timeCalculated = timeInt;
    }
    
    Timer.periodic(Duration(seconds: 1), 
      (Timer t){
        setState(() {
          if(timeCalculated < 1 || cancelTimer == false){
            t.cancel();
            cancelTimer = true;
            Navigator.of(context).pop();
            _audioPlayer.stop();
          }
          else if(timeCalculated == 2 && innerTime == 0){
            string = true;
            timeCalculated = 41;
            timeCalculated -= 1;
            timeDisplayed = timeCalculated.toString();
            innerTime++;
          }
          else if(timeCalculated < 60){
            timeDisplayed = timeCalculated.toString();
            timeCalculated -= 1;
          }
          else if (timeCalculated < 3600){
            int m = timeCalculated ~/ 60;
            int n = timeCalculated - (60*m);
            timeDisplayed = m.toString() + ":" + n.toString();
            timeCalculated -= 1;
          }
          else{
            timeCalculated -= 1;
          }
        
        });
      }
    );
  }
  void stop(){
    setState(() {
      started = true;
      stopped = true;
      cancelTimer = false;
    });
  }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.purple,
       body: Stack(
         children: <Widget>[
           Positioned(
            child: AppBar(
              leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){Navigator.of(context).pop();_audioPlayer.stop();}),
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text(widget.title, style: TextStyle(fontSize: 20.0, fontFamily: 'Montserrat')),
            ),
          ),
          Center(
            // top: 300,
            // left: (MediaQuery.of(context).size.width /2) - 60.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(child: Text(timeDisplayed,style:TextStyle(fontSize: 90,fontWeight: FontWeight.bold, color: Colors.white)))
              ],
            ),
          ),
          Positioned(
            top: 500,
            left: 25.0,
            right: 25.0,
            child: Center(
              child: Column(
                children: <Widget>[
                  started ? 
              MaterialButton(
                onPressed: started? start : null,
                color: Colors.green,
                child: Text("Start",style: TextStyle(color: Colors.white),),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)
                  ),
                  minWidth: MediaQuery.of(context).size.width,
                  height: 45.0,
              ) : 
              MaterialButton(
                onPressed: stopped? null : stop,
                color: Colors.red,
                child: Text(string? _break : _stop,
                style: TextStyle(color:Colors.white),),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)
                  ),
                  minWidth: MediaQuery.of(context).size.width,
                  height: 45.0,
              )
                ],
              )
            )
          )
         ],
       )
     );
  }
} 


