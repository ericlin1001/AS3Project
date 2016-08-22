package{
	import flash.display.Sprite;
	import flash.net.SharedObject ;
	public class ExmapleShareobject extends Sprite{
		public function ExmapleShareobject(){
			var so:SharedObject =SharedObject.getLocal ("example");
			if(so.size ==0){
				trace("creating...");
				so.data.name="eric";
				so.data.pass="12345";
				so.flush ();
				delete so.data.name;
				//obj.clear ();
			}else{
				for(var i:String in so.data ){
					trace(i+"="+so.data[i]);
				}
				//obj.clear ();
			}
		}
	}
}