import 'dart:async';
import 'package:flutter/material.dart';
import '../models/devices.dart';
import '../utils/database_helper.dart';
import 'package:intl/intl.dart';

class DeviceDetail extends StatefulWidget {

	final String appBarTitle;
	final Device device;

	DeviceDetail(this. device, this.appBarTitle);

	@override
  State<StatefulWidget> createState() {

    return DeviceDetailState(this.device, this.appBarTitle);
  }
}

class DeviceDetailState extends State<DeviceDetail> {

	DatabaseHelper helper = DatabaseHelper();

	String appBarTitle;
	Device device;

	TextEditingController nameController = TextEditingController();
	TextEditingController descriptionController = TextEditingController();

	DeviceDetailState(this.device, this.appBarTitle);

	@override
  Widget build(BuildContext context) {

		TextStyle textStyle = Theme.of(context).textTheme.title;

		nameController.text = device.name;
		descriptionController.text = device.description;

    return WillPopScope(

	    onWillPop: () {
	    	// Write some code to control things, when user press Back navigation button in device navigationBar
		    moveToLastScreen();
	    },

	    child: Scaffold(
	    appBar: AppBar(
		    title: Text(appBarTitle),
		    leading: IconButton(icon: Icon(
				    Icons.arrow_back),
				    onPressed: () {
		    	    // Write some code to control things, when user press back button in AppBar
		    	    moveToLastScreen();
				    }
		    ),
	    ),

	    body: Padding(
		    padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
		    child: ListView(
			    children: <Widget>[

				    // Second Element
				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: TextField(
						    controller: nameController,
						    style: textStyle,
						    onChanged: (value) {
						    	debugPrint('Something changed in Name Text Field');
						    	updateName();
						    },
						    decoration: InputDecoration(
							    labelText: 'Name',
							    labelStyle: textStyle,
							    border: OutlineInputBorder(
								    borderRadius: BorderRadius.circular(5.0)
							    )
						    ),
					    ),
				    ),

				    // Third Element
				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: TextField(
						    controller: descriptionController,
						    style: textStyle,
						    onChanged: (value) {
							    debugPrint('Something changed in Description Text Field');
							    updateDescription();
						    },
						    decoration: InputDecoration(
								    labelText: 'Description',
								    labelStyle: textStyle,
								    border: OutlineInputBorder(
										    borderRadius: BorderRadius.circular(5.0)
								    )
						    ),
					    ),
				    ),

				    // Fourth Element
				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: Row(
						    children: <Widget>[
						    	Expanded(
								    child: RaisedButton(
									    color: Theme.of(context).primaryColorDark,
									    textColor: Theme.of(context).primaryColorLight,
									    child: Text(
										    'Save',
										    textScaleFactor: 1.5,
									    ),
									    onPressed: () {
									    	setState(() {
									    	  debugPrint("Save button clicked");
									    	  _save();
									    	});
									    },
								    ),
							    ),

							    Container(width: 5.0,),

							    Expanded(
								    child: RaisedButton(
									    color: Theme.of(context).primaryColorDark,
									    textColor: Theme.of(context).primaryColorLight,
									    child: Text(
										    'Delete',
										    textScaleFactor: 1.5,
									    ),
									    onPressed: () {
										    setState(() {
											    debugPrint("Delete button clicked");
											    _delete();
										    });
									    },
								    ),
							    ),

						    ],
					    ),
				    ),

			    ],
		    ),
	    ),

    ));
  }

  void moveToLastScreen() {
		Navigator.pop(context, true);
  }

  void updateName(){
    device.name = nameController.text;
  }

	void updateDescription() {
		device.description = descriptionController.text;
	}

	// Save data to database
	void _save() async {

		moveToLastScreen();

		int result;
		if (device.id != null) {  // Case 1: Update operation
			result = await helper.updateDevice(device);
		} else { // Case 2: Insert Operation
			result = await helper.insertDevice(device);
		}

		if (result != 0) {  // Success
			print( 'Device Saved Successfully');
		} else {  // Failure
			print('Problem Saving Device');
		}

	}

	void _delete() async {

		moveToLastScreen();

		if (device.id == null) {
			print('No Device was deleted');
			return;
		}

		int result = await helper.deleteDevice(device.id);
		if (result != 0) {
			print('Device Deleted Successfully');
		} else {
			print('Error Occured while Deleting Device');
		}
	}



}










