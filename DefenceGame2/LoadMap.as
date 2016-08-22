package  
{
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author ErciLin
	 //*/
	public class LoadMap extends EventDispatcher
	{
		public var paths:Array;
		public var maps:Array;
		public var colors:Array ;
		//to store the data of map;
		public function loadMap(path:String):void{
			maps=new Array();
			paths = new Array();
			colors = new Array ();
			var loader:URLLoader=new URLLoader();
			loader.addEventListener(Event.COMPLETE,completeHander);
			try{
			loader.load(new URLRequest(path));
			}catch (e:IOError) {
				trace("thie is a ioError.\nLoad"+path+"failed.");
				
			}
		}
		private function completeHander(e:Event):void{
			var loader:URLLoader=URLLoader(e.target);
			trace("have loaded data:\n"+loader.data);
			analyseData(loader.data);
			UintArray(maps);
			UintArray(paths);
			UintArray(colors);
			trace("maps[0]="+maps[0]);
			trace("paths[0]=" + paths[0]);
			trace("colors[0]="+colors[0]);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		private function UintArray(a:Array):void{
			for(var i:int=0;i<a.length;i++){
				for(var j:int=0;j<a[i].length;j++){
				a[i][j]=int(a[i][j]);
				}
			}
		}

		private function analyseData(str:String):void{
			var lines:Array=str.split("\n");
			for(var i:int=0;i<lines.length;i++){
			var line:String=lines[i];
				if(isDefines(line)){
				parseDefines(line);
				}else if(!isComment(line) && !isEmpty(line)){
				//line is map
				parseMap(line);
				}
			}
		}

		private function parseMap(str:String):void{
			//this define maps
			maps.push(str.split(","));
		}

		private function parseDefines(str:String):void{
			if(str.indexOf("#path") == 0) {
			//this define path
			var t:Array=str.split(":");
			paths.push(t[1].split(","));
			}else if(str.indexOf("#color")==0){
			//this define colors
			var tt:Array=str.split(":");
			colors.push(tt[1].split(","));
			}
		}

		private function isDefines(str:String):Boolean{
			return str.indexOf("#")==0;
		}

		private function isComment(str:String):Boolean{
			return str.indexOf("//")==0;
		}

		private function isEmpty(str:String):Boolean{
			for(var i:int=0;i<str.length-1;i++){
				if(str.charAt(i)!=' '){
				return false;
				}
			}
			return true;
		}
	}
}