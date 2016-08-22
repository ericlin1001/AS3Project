package  
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class TimingCircuitDesign extends Sprite
	{
		private var numState:int = 12;
		private var states:Array;
		private var kanmaps:Array;
		private var varNames:Array;
		private var size:int = 20;
		private var container:Sprite = new Sprite();
		private var values:Array;
		private var t:TextField ;
		private var logText:TextField;
		
		private var nowText:TextField;
		private var nextText:TextField;
		private var table:Array;
		//
		
		public function TimingCircuitDesign(){ 
			
			varNames = ["A", "B", "C", "D"];// ["Q0", "Q1", "Q2", "Q3"];
			init();
			
		}
		public function init():void {
			
			//
			
			var stateText:TextField = new TextField();
			addChild(stateText);
			stateText.autoSize = TextFieldAutoSize.LEFT;
			stateText.type = TextFieldType.DYNAMIC;
			stateText.x = 0;
			stateText.y = 0;
			stateText.selectable = false;
			stateText.text = "States:(split by ',' or ' ',example:0,1,2,3)";
			
			//
			t = new TextField();
			addChild(t);
			t.type = TextFieldType.INPUT;
			t.x = 5;
			t.y = 20;
			t.width = 200;
			t.height = 30;
			t.text = "0,1,2,3";
			t.border = true;
			//
			
			logText = new TextField();
			addChild(logText);
			//logText.autoSize = TextFieldAutoSize.CENTER;
			logText.multiline = true;
			logText.type = TextFieldType.DYNAMIC;
			logText.x = 290;
			logText.y = 10;
			logText.height = 500;
			logText.width = 300;
			logText.border = true;
			logText.alwaysShowSelection = true;
			logText.text = "logtext:";
			
			var button:Sprite = new Sprite();
			button.x = 230;
			button.y = 20;
			addChild(button);
			var g:Graphics = button.graphics;
			g.lineStyle(0);
			g.beginFill(0xff0000);
			g.drawRect(0, 0, 50, 20);
			g.endFill();
			button.addEventListener(MouseEvent.CLICK, click);
			var buttonLabel:TextField = new TextField();
			button.addChild(buttonLabel);
			buttonLabel.autoSize = TextFieldAutoSize.LEFT;
			buttonLabel.type = TextFieldType.DYNAMIC;
			buttonLabel.x = 0;
			buttonLabel.y = 0;
			buttonLabel.width = 200;
			buttonLabel.height = 30;
			buttonLabel.selectable = false;
			buttonLabel.text = "Create";
			//
			addChild(container);
			container.y = 50;
		}
		public function makeAll():void {
			createJKMap();
			 create();
			 show();
		}
		public function setLogText(t:String):void {
			logText.appendText("\n" + t);
		}
		public function click(e:MouseEvent):void {
			var i:int = 0;
			var beginIndex:int = logText.text.length;
			setLogText("\nClean the stage!");
			while (container.numChildren > 0) container.removeChildAt(0);
			
			setLogText("Creating,please wait...");
			values = t.text.split(',');
			if (values.length <= 1) values = t.text.split(' ');
			for (i = 0; i < values.length;i++)if(values[i] == "")values.splice(i++, 1);

			numState = values.length;
			var temp:String = "";
			for (i= 0; i < numState; i++) {
				temp += values[i];
				if(i!=numState-1)temp += ",";
			}
			t.text = temp;
			setLogText("set states(length="+numState+"):" + temp);
			makeAll();
			setLogText("Create succcessfully!");
			logText.setSelection(beginIndex, logText.text.length);
		}
		public function show():void {
			var t:String = "";
			t += "num  A B C D   A B C D   J0K0  J1K1  J2K2  J3K3\n";
			for (var row:int = 0; row < table.length; row++) {
				var line:Array = table[row];
				if (values[row] < 10) t += "    ";
				else t += "  ";
				t += values[row];
				t += '  ';
				for (var col:int = 0; col < line.length; col++) {
					t += (line[col] as String).replace('2 ','X')+"  ";
				}
				if(row!=table.length-1)t += "\n";
			}
			setLogText(t);
			
			for (var i:int = 0; i < 8; i++) {
				kanmaps[i].draw();
				container.addChild(kanmaps[i]);
			}
		}
		private function create():void {
			 table = new Array();
			var now:Array = new Array();
			var next:Array = new Array();
			var i:int;
			for (i = 0; i < numState; i++) {
				now[i] = KanMap.convertToBinary(values[i]);
				table[i] = new Array();
				(table[i] as Array).push((now[i] as Array).join('  ')+'  ');
			}
			for (i = 0; i < numState; i++) {
				next[i] = now[(i + 1) % numState];
				(table[i] as Array).push((next[i] as Array).join('  ')+'  ');
			}
			
			for (i = 0; i < numState; i++) {
				var tableLine:String = "";
				var n:int ;
				for ( n = 0;n < 4;n++) {
					var j:KanMap = kanmaps[n * 2];
					var k:KanMap = kanmaps[n * 2 + 1];
					var jkvalue:Array = getJKValue(now[i][n], next[i][n]);
					j.setValues(now[i], jkvalue[0]);
					k.setValues(now[i], jkvalue[1]);
					(table[i] as Array).push(jkvalue.join('  ')+'  ');
				}
			}
			
		}
		private function getJKValue(now:int, next:int):Array {
			var t:Array = new Array(2);
			switch(now * 2 + next) {
				case 0:return [0,KanMap.VALUE_X];
				case 1:return [1, KanMap.VALUE_X];
				case 2:return [ KanMap.VALUE_X,1];
				case 3:return [KanMap.VALUE_X,0];
				
			}
			trace("Error in getJKValue");
			return [0, 0];
		}
		private function createJKMap():void {
			//var space:int = 10;
			kanmaps = new Array();
			for (var i:int = 0; i < 4; i++) {
				var j:KanMap = new KanMap();
				j.setTitle("J" + i);
				j.setYName("J"+i);
				j.setValuesName(varNames);
				j.setSize(size);
				j.x = 0;
				j.y = i * size * 7;
				
				j.initValues(KanMap.VALUE_X);
				//j.draw();
				
				var k:KanMap = new KanMap();
				k.setTitle("K" + i);
				k.setYName("K"+i);
				k.setValuesName(varNames);
				k.setSize(size);
				k.x = 0+size*7;
				k.y = i * size * 7;
				
				k.initValues(KanMap.VALUE_X);
				//k.draw();
				
				kanmaps.push(j);
				kanmaps.push(k);
			}
		}
	}
	
}