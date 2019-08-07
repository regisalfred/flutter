import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/devices.dart';

class DatabaseHelper {

	static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
	static Database _database;                // Singleton Database

	String deviceTable = 'device_table';
	String colId = 'id';
	String colName = 'name';
	String colDescription = 'description';

	DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

	factory DatabaseHelper() {

		if (_databaseHelper == null) {
			_databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
		}
		return _databaseHelper;
	}

	Future<Database> get database async {

		if (_database == null) {
			_database = await initializeDatabase();
		}
		return _database;
	}

	Future<Database> initializeDatabase() async {
		// Get the directory path for both Android and iOS to store database.
		Directory directory = await getApplicationDocumentsDirectory();
		String path = directory.path + 'notes.db';

		// Open/create the database at a given path
		var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
		return notesDatabase;
	}

	void _createDb(Database db, int newVersion) async {

		await db.execute('CREATE TABLE $deviceTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, '
				'$colDescription TEXT)');
	}

	// Fetch Operation: Get all note objects from database
	Future<List<Map<String, dynamic>>> getDeviceMapList() async {
		Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
		var result = await db.query(deviceTable, orderBy: '$colName ASC');
		return result;
	}

	// Insert Operation: Insert a Note object to database
	Future<int> insertDevice(Device note) async {
		Database db = await this.database;
		var result = await db.insert(deviceTable, note.toMap());
		return result;
	}

	Future<int> updateDevice(Device device) async {
		var db = await this.database;
		final result = await db.update(deviceTable, device.toMap(), where: '$colId = ?', whereArgs: [device.id]);
		return result;
	}

	Future<int> deleteDevice(int id) async {
		var db = await this.database;
		int result = await db.rawDelete('DELETE FROM $deviceTable WHERE $colId = $id');
		return result;
	}

	Future<int> getCount() async {
		Database db = await this.database;
		List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $deviceTable');
		int result = Sqflite.firstIntValue(x);
		return result;
	}

	Future<List<Device>> getDeviceList() async {

		var deviceMapList = await getDeviceMapList(); // Get 'Map List' from database
		int count = deviceMapList.length;         // Count the number of map entries in db table

		List<Device> deviceList = List<Device>();
		for (int i = 0; i < count; i++) {
			deviceList.add(Device.fromMapObject(deviceMapList[i]));
		}

		return deviceList;
	}

}







