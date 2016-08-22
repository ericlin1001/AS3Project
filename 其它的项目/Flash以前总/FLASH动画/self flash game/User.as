/**
 User Class
 作者：Eric
 版本：0.8
 	 修改时间：01/23/2009
 	 版权所有：Eric
 	 This ActionScript 定义一个自定义Users Class ,以允许您创建新用户并指定用户登录信息。
 */
class User {
	//private variables
	private var _username:String;
	private var _password:String;
	public function User(p_username:String, p_password:String) {
		this._username = p_username;
		this._password = p_password;
	}
	public function get username():String {
		return this._username;
	}
	public function set username(value:String):Void {
		this._username = value;
	}
	public function get password():String {
		return this._password;
	}
	public function set password(value:String):Void {
		this._password = value;
	}
}
