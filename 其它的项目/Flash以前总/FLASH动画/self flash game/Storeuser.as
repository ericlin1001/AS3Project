/*
User class
...
**/
class Shapes.Storeuser {
	private var _username :String 
	private var _password :String       
    public function Storeuser(p_username:String ,p_password:String ) {
		this._username= p_username
		this._password =p_password
	}
	
	public function set username(value:String ):Void{
		this._username= value
	}	
	public  function set password(value:String ):Void {
		this._password= value
	}	
	public function get username(){
		return this._username
	}	
	public function get password(){
		return this._password
	}
}