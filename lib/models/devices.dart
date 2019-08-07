
class Device {

	int _id;
	String _name;
	String _description;

	Device(this._name,[this._description]);

	Device.withId(this._id, this._name, [this._description]);

	int get id => _id;

	String get name => _name;

	String get description => _description;

	set name(String newName) {
		if (newName.length <= 255) {
			this._name = newName;
		}
	}

	set description(String newDescription) {
		if (newDescription.length <= 255) {
			this._description = newDescription;
		}
	}

	Map<String, dynamic> toMap() {

		var map = Map<String, dynamic>();
		if (id != null) {
			map['id'] = _id;
		}
		map['name'] = _name;
		map['description'] = _description;

		return map;
	}

	Device.fromMapObject(Map<String, dynamic> map) {
		this._id = map['id'];
		this._name = map['name'];
		this._description = map['description'];
	}
}









