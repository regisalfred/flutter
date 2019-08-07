import 'dart:async';
import 'package:flutter/material.dart';
import '../models/devices.dart';
import '../utils/database_helper.dart';
import './device_detail.dart';
import 'package:sqflite/sqflite.dart';


class DeviceList extends StatefulWidget {

	@override
  State<StatefulWidget> createState() {

    return DeviceListState();
  }
}

class DeviceListState extends State<DeviceList> {

	DatabaseHelper databaseHelper = DatabaseHelper();
	List<Device> deviceList;
	int count = 0;

	@override
  Widget build(BuildContext context) {

		if (deviceList == null) {
			deviceList = List<Device>();
			updateListView();
		}

    return Scaffold(

	    appBar: AppBar(
		    title: Text('Devices'),
	    ),

	    body: getDeviceListView(),

	    floatingActionButton: FloatingActionButton(
		    onPressed: () {
		      debugPrint('FAB clicked');
		      navigateToDetail(Device('', ''), 'Add Device');
		    },

		    tooltip: 'Add Device',

		    child: Icon(Icons.add),

	    ),
    );
  }

  ListView getDeviceListView() {

		TextStyle titleStyle = Theme.of(context).textTheme.subhead;

		return ListView.builder(
			itemCount: count,
			itemBuilder: (BuildContext context, int position) {
				return Card(
					color: Colors.white,
					elevation: 2.0,
					child: ListTile(

						title: Text(this.deviceList[position].name, style: titleStyle,),

						subtitle: Text(this.deviceList[position].description),

						trailing: GestureDetector(
							child: Icon(Icons.delete, color: Colors.grey,),
							onTap: () {
								_delete(context, deviceList[position]);
							},
						),


						onTap: () {
							debugPrint("ListTile Tapped");
							navigateToDetail(this.deviceList[position],'Edit Device');
						},

					),
				);
			},
		);
  }

	void _delete(BuildContext context, Device device) async {

		int result = await databaseHelper.deleteDevice(device.id);
		if (result != 0) {
			_showSnackBar(context, 'Device Deleted Successfully');
			updateListView();
		}
	}

	void _showSnackBar(BuildContext context, String message) {

		final snackBar = SnackBar(content: Text(message));
		Scaffold.of(context).showSnackBar(snackBar);
	}

  void navigateToDetail(Device device, String name) async {
	  bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
		  return DeviceDetail(device, name);
	  }));

	  if (result == true) {
	  	updateListView();
	  }
  }

  void updateListView() {

		final Future<Database> dbFuture = databaseHelper.initializeDatabase();
		dbFuture.then((database) {

			Future<List<Device>> deviceListFuture = databaseHelper.getDeviceList();
			deviceListFuture.then((deviceList) {
				setState(() {
				  this.deviceList = deviceList;
				  this.count = deviceList.length;
				});
			});
		});
  }
}







