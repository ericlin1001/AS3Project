package 
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.text.TextField;
import flash.utils.Timer;
	/**
	 * ...
	 * @author ErciLin
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var money_txt:TextField=new TextField();
			var level_txt:TextField=new TextField();
			var life_txt:TextField=new TextField();
			var info_txt:TextField=new TextField();
			var error_txt:TextField = new TextField();
			var tankOneBtn:TankOneBtn = new TankOneBtn();
			var tankTwoBtn:TankTwoBtn = new TankTwoBtn();
			addChild( money_txt);
			addChild( level_txt);
			addChild(life_txt );
			addChild(info_txt );
			addChild( error_txt);
			addChild( tankOneBtn);
			addChild( tankTwoBtn);
			money_txt.x = 10;
			money_txt.y = 7;
			level_txt.x = 210;
			level_txt.y = 7;
			life_txt.x = 410;
			life_txt.y = 7;
			info_txt.x =260;
			info_txt.y = 400;
			error_txt.x = 40;
			error_txt.y = 540;
			tankOneBtn.x = 70;
			tankOneBtn.y = 500;
			tankTwoBtn.x = 200;
			tankTwoBtn.y = 500;
			
			include "DefenceGame.as"
			
		}
		
	}
	
}