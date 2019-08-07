
import 'package:flutter/material.dart';
import './device_list.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  void buttonPressed(){

  }

  Future navigateToDeviceList(context) async{
    Navigator.push(context, MaterialPageRoute(builder: (context) => DeviceList()),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('AYFT'),
          backgroundColor: Colors.blueGrey,
        ),
        //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
        body: Container(
          padding: EdgeInsets.all(32.0),
          child: Center(
            child: Column(
            children: <Widget>[
              Card(
              child: Container(
              padding: EdgeInsets.all(32.0),
              child: Column(
              children: <Widget>[
              Text('Catalog'),
              RaisedButton(
                  color: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).primaryColorLight,
              child: Text('Devices'), onPressed: (){
                navigateToDeviceList(context);})
              ],
              ),
              ),
              ),
              new Card(
                child: new Container(
                  padding: new EdgeInsets.all(32.0),
                  child: new Column(
                  children: <Widget>[
                  Text('ICE'),
                    RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                    child: Text('Emergency Contacts'), onPressed: buttonPressed,)
                  ],
                  ),
                ),
              ),
            ],
            ),
          ),
    ),
    );
  }
}