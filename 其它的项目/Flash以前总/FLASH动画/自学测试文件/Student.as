// Student.as
class Student {
    private var _id:String;
    private var _firstName:String;
    private var _middleName:String;
    private var _lastName:String;

    public function Student(id:String, firstName:String, middleName:String, lastName:String) {
        this._id = id;
        this._firstName = firstName;
        this._middleName = middleName;
        this._lastName = lastName;
    }
    public function get firstName():String {
        return this._firstName;
    }
    public function set firstName(value:String):Void {
        this._firstName = value;
    }
	    public function get id():String {
        return this._id;
		
    }
    public function set id(value:String):Void {
        this._id = value;
    }
    // ...
}
