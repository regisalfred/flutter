import 'package:flutter/material.dart';
import './screens/device_list.dart';
import './screens/device_detail.dart';
import './screens/homepage.dart';

void main() {
	runApp(MyApp());
}

class MyApp extends StatelessWidget {

	@override
  Widget build(BuildContext context) {

    return MaterialApp(
	    title: 'AYFT',
	    debugShowCheckedModeBanner: false,
	    theme: ThemeData(
		    primarySwatch: Colors.blueGrey
	    ),
	    home: HomePage(),
    );
  }
}