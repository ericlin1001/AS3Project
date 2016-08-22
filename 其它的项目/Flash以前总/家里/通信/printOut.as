package{
	public class printOut {
		public function printOut(str:String,mc:Sprite ){
			 var txt:TextField=new TextField();
			 txt.x=0
			 txt.y=0
			 txt.width =200
			 txt.height =50
			 txt.type =TextFieldType.DYNAMIC ;
			 mc.addChild(txt);
		}
	}
}
			