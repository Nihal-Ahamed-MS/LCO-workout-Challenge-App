import 'package:flutter/material.dart';
import 'WorkoutTime.dart';
class Details extends StatefulWidget {
  final heroTag;
  final exName;
  final exTime;
  final exDesc;
  final exMusic;

  Details({this.heroTag,this.exName,this.exTime,this.exDesc,this.exMusic});
  @override
   _DetailsState createState() => _DetailsState();
}
class _DetailsState extends State<Details> {

  bool isPressed = false;
   @override
   Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.purple,
       body: Stack(
         children: <Widget>[
           Positioned(
            child: AppBar(
              leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){Navigator.of(context).pop();}),
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text("Workout", style: TextStyle(fontSize: 20.0, fontFamily: 'Montserrat')),
            ),
          ),
          SizedBox(height: 50),
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
           Positioned(
            top:100,
            left: (MediaQuery.of(context).size.width /2) - 100.0,
            child: Hero(
             tag: widget.heroTag,
             child: Container(
               decoration: BoxDecoration(
                 image: DecorationImage(
                   image: AssetImage(widget.heroTag),
                   fit: BoxFit.cover
                 )
               ),
               height: 200.0,
               width: 200.0,
             )
             ),
          ),
          Positioned(
            top:300,
            left: 25.0,
            right: 25.0,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('Excerise: ',textAlign: TextAlign.left,style:TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    )),
                    Text(widget.exName,style: TextStyle(
                      fontSize: 20,
                    ))
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  children: <Widget>[
                    Text('Description: ',textAlign: TextAlign.left,style:TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    )),
                  ],
                ),
                SizedBox(height: 10.0),
                Container(
                  width: MediaQuery.of(context).size.width*10.0,
                  child: SelectableText.rich(
                       TextSpan(
                          text: widget.exDesc,
                          style: TextStyle(
                            fontSize: 20.0
                          )
                       )
                     ),
                ),
                SizedBox(height: 20.0),
                Row(
                  children: <Widget>[
                    Text('Duration: ',textAlign: TextAlign.left,style:TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    )),
                    Text(widget.exTime,style: TextStyle(
                      fontSize: 20,
                    )),
                    Text('min',style: TextStyle(
                      fontSize: 20,
                    ))
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  children: <Widget>[
                    Text('Break Time: ',textAlign: TextAlign.left,style:TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    )),
                    Text('40sec',style: TextStyle(
                      fontSize: 20,
                    ))
                  ],
                ),
                SizedBox(height: 20.0),
                MaterialButton(
                  onPressed: navigateToTimeScreen,
                  color: Colors.purple,
                  child: Text('START',style: TextStyle(color: Colors.white,fontSize: 18),),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)
                  ),
                  minWidth: MediaQuery.of(context).size.width,
                  height: 45.0,
                )
              ],
            ),
          ),
         ],
       ),
    );
  }
  navigateToTimeScreen(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>WorkoutTime(time:widget.exTime,title: widget.exName,music: widget.exMusic)));
  }
} 