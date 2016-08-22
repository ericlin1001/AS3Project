package  
{
	import adobe.utils.CustomActions;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class KanMap extends Sprite
	{
		
		private var varNames:Array;
		private var YName:String;
		private var title:String = "title";
		public static const VALUE_EMPTY:int = -1;
		public static const VALUE_X:int = 2;
		private var values:Array;/*-1 means empty
									2 means X*/
								
		//
		private var mapCountTime:Array;
		private var size:int = 30;
		private var mx:Number;
		private var my:Number;
		//
		private var canvas:Sprite = new Sprite();
		public function KanMap() 
		{
			init();
			addEventListener(MouseEvent.MOUSE_DOWN, onmousedown);
		}
		
		private function init():void {
			values = new Array(16);
			for (var i:int = 0; i < 16; i++) {
				values[i] = VALUE_EMPTY;
			}
			varNames = new Array(4);
			varNames[0] = new String("Q0");
			varNames[1] = new String("Q1");
			varNames[2] = new String("Q2");
			varNames[3] = new String("Q3");
			YName = new String("Y");
		}
		public function clearAll():void {
			while (this.numChildren > 0) this.removeChildAt(0);
			this.graphics.clear();
		}
		public function draw():void {
			clearAll();
			var g:Graphics = this.graphics;
			g.lineStyle(0);
			//
			var startX:int, startY:int;
			startX = this.size * 1.3;
			startY = this.size * 1.1;
			g.moveTo(0, 0); g.lineTo(startX, startY);
			var lefttext:TextField = drawText(0,0, varNames[0] + varNames[1]);
			lefttext.y = startY - lefttext.textHeight;
			lefttext.x = 0;
			var righttext:TextField = drawText(0,0, varNames[2] + varNames[3]);
			righttext.y = 0;
			righttext.x =startX-righttext.textWidth;
			//
			var i:int;
			var grayCodes:Array = [ "00", "01", "11", "10" ];
			for ( i = 0; i < 4; i++) {
				drawText(startX + i * size + size / 2, startY / 2, grayCodes[i]);
				drawText(startX / 2, startY + i * size + size / 2, grayCodes[i]);
				
			}
			var titleText:TextField = drawText(startX + size * 2, 0, title);
			titleText.y =  -4;
			for ( i = 0; i < 4; i++) {
				for (var j:int = 0; j < 4; j++) {
					var xx:int, yy:int;
					xx = startX + j * size;
					yy = startY + i * size;
					g.drawRect(xx, yy , size, size);
					var value:int = getMapValue(i, j);
					if (value== VALUE_EMPTY) {
					//	drawText(xx + size / 2, yy + size / 2, "-1");
					}else if (value== VALUE_X) {
						drawText(xx + size / 2, yy + size / 2, "X");
					}else{
						drawText(xx + size / 2, yy + size / 2, value.toString());
					}
				}
			}
			var circles:Array = getKanMapCircles();
			var sop:String = getSOPStr(circles);
			var soptext:TextField = drawText((startX + size * 4) / 2, startY + size * 4.5, this.YName + "=" + sop);
			drawKanMapCircles(circles); canvas.x = startX; canvas.y = startY;
			soptext.x = soptext.x < 0?0:soptext.x;
			//
			g.lineStyle(1, 1, 0);
			g.beginFill(0, 0);
			g.drawRect(0, 0, startX + size * 4, startY + size * 4);
			g.endFill();
		}
		private function isToContain(row:int, col:int):Boolean {
			return getMapValue(row,col) == 1 || getMapValue(row,col) == VALUE_X;
		}
		private function circleLagger(c:KanMapCircle,n:int):Boolean {
			var row:int, col:int;
			for (row = c.leftTop[0]; row <= c.rightBottom[0]; row++) {
				for (col = c.leftTop[1]; col <= c.rightBottom[1]; col++) {
					if (!(mapCountTime[row%4][col%4] > n)) return false;
				}
			}
			return true;
		}
		
		private function circleAdd(c:KanMapCircle,addition:int):void {
			var row:int, col:int;
			for (row = c.leftTop[0]; row <= c.rightBottom[0]; row++) {
				for (col = c.leftTop[1]; col <= c.rightBottom[1]; col++) {
					mapCountTime[row%4][col%4] += addition;
				}
			}
		}
		public function printMapCountTime():void {
			trace("mapCountTime:");
			var row:int, col:int;
			for (row = 0; row < 4; row++) {
			trace(mapCountTime[row]);
				for (col = 0; col < 4; col++) {
				}
			}
		}
		public function getKanMapCircles():Array {
			mapCountTime = new Array(4);
			var row:int, col:int;
			for (row = 0; row < 4; row++) {
				mapCountTime[row] = new Array(4);
				for (col = 0; col < 4; col++) {
					if (getMapValue(row, col)==1) mapCountTime[row][col] = 1;
					
					else if (getMapValue(row, col)==2) mapCountTime[row][col] = 100;
					
					else mapCountTime[row][col] = 0;
				}
			}
			//
			
			var circles:Array = new Array();
			var circle:KanMapCircle; 
			//4*4
			circle= new KanMapCircle([0, 0], [3, 3]);
			if (circleLagger(circle, 0)) { circles.push(circle.clone()); circleAdd(circle, 1); }
			//4*2
			circle= new KanMapCircle([0, 0], [3, 1]);
			for (col = 0; col < 4; col++) {
				circle.setStartPoint([0, col]);
				if (circleLagger(circle, 0)) { circles.push(circle.clone()); circleAdd(circle, 1); }
			
			}
			//2*4
			circle= new KanMapCircle([0, 0], [1, 3]);
			for (row = 0; row < 4; row++) {
				circle.setStartPoint([row, 0]);
				if (circleLagger(circle, 0)) { circles.push(circle.clone()); circleAdd(circle, 1); }
			}
			//2*2
			circle= new KanMapCircle([0, 0], [1, 1]);
			for (row = 0; row < 4; row++) {
				for (col = 0; col < 4; col++) {
					circle.setStartPoint([row, col]);
					if (circleLagger(circle, 0)) {  circles.push(circle.clone()); circleAdd(circle, 1); }
				}
			}
			//1*4
			circle= new KanMapCircle([0, 0], [0, 3]);
			for (row = 0; row < 4; row++) {
				circle.setStartPoint([row, 0]);
				if (circleLagger(circle, 0)) { circles.push(circle.clone()); circleAdd(circle, 1); }
			}
			//4*1
			circle= new KanMapCircle([0, 0], [3, 0]);
			for (col = 0; col < 4; col++) {
				circle.setStartPoint([0, col]);
				if (circleLagger(circle, 0)) { circles.push(circle.clone()); circleAdd(circle, 1); }
			
			}
			//1*2
			circle= new KanMapCircle([0, 0], [0, 1]);
			for (row = 0; row < 4; row++) {
				for (col = 0; col < 4; col++) {
					circle.setStartPoint([row, col]);
					if (circleLagger(circle, 0)) { circles.push(circle.clone()); circleAdd(circle, 1); }
				}
			}
			//2*1
			circle= new KanMapCircle([0, 0], [1, 0]);
			for (row = 0; row < 4; row++) {
				for (col = 0; col < 4; col++) {
					circle.setStartPoint([row, col]);
					if (circleLagger(circle, 0)) { circles.push(circle.clone()); circleAdd(circle, 1); }
				}
			}
			//1*1
			circle= new KanMapCircle([0, 0], [0, 0]);
			for (row = 0; row < 4; row++) {
				for (col = 0; col < 4; col++) {
					circle.setStartPoint([row, col]);
					if (circleLagger(circle, 0)) { circles.push(circle.clone()); circleAdd(circle, 1); }
				}
			}
			printMapCountTime();
			trace("circles.lenght=", circles.length);
			//
			//*************************delete the too more circle**********
			var i:int ;
			for (i= circles.length - 1; i >= 0; i--) {
				circle = circles[i];
				trace(i,circle.toString());
				if (circleLagger(circle, 2)) { 
					circles.splice(i, 1);
					circleAdd(circle, -1); 
				}
			}
			printMapCountTime();
			
			return circles;
		}
		public function setSize(n:int):void {
			size = n;
		}
		private function drawKanMapCircle(circle:KanMapCircle):void {
			var margin:int = size * 0.15;
			var radius:Number = Number(size) * 0.5;
			var rowLen:int, colLen:int;
			rowLen = circle.vector[0]+1;
			colLen = circle.vector[1] + 1;
			//
			var circleSprite:Sprite = new Sprite();
			canvas.addChild(circleSprite);
			var g:Graphics = circleSprite.graphics;
			g.clear(); g.lineStyle(0);
			g.beginFill(0xffffff * 0.8, 0.5);
			
			if (circle.rightBottom[0] <4) {
				if (circle.rightBottom[1] <4) {
						g.drawRoundRectComplex(circle.leftTop[1] * size+margin,
												circle.leftTop[0] * size+margin,
												 colLen* size-2 * margin,
												rowLen * size-2 * margin,
												radius, radius, radius, radius);
												
				}else {
					g.drawRoundRectComplex(circle.leftTop[1] * size+margin,
												circle.leftTop[0] * size+margin,
												(4-circle.leftTop[1] ) * size-2 * margin,
												rowLen * size-2 * margin,
												radius, 0, radius, 0);
					g.drawRoundRectComplex( margin,
												circle.leftTop[0] * size+margin,
												(circle.rightBottom[1]-3 ) * size-2 * margin,
												rowLen * size-2 * margin,
												 0, radius, 0,radius);
																			
				}
			}else {
				if (circle.rightBottom[1] <4) {
					g.drawRoundRectComplex(circle.leftTop[1] * size+margin,
												circle.leftTop[0] * size+margin,
												colLen * size-2 * margin,
												(4-circle.leftTop[0]) * size-2 * margin,
												radius, radius, 0, 0);
					g.drawRoundRectComplex(circle.leftTop[1] * size+margin,
												margin,
												colLen * size-2 * margin,
												(circle.rightBottom[0]-3) * size-2 * margin,
												0,0,radius, radius);
				}else {
					g.drawRoundRectComplex(circle.leftTop[1] * size+margin,
												circle.leftTop[0] * size+margin,
												(4-circle.leftTop[1]) * size-2 * margin,
												(4-circle.leftTop[0]) * size-2 * margin,
												radius, 0,0, 0);
					g.drawRoundRectComplex(margin,
												margin,
												(circle.rightBottom[1]-3) * size-2 * margin,
												(circle.rightBottom[0] - 3) * size-2 * margin,
													0,0,0, radius);
					g.drawRoundRectComplex(circle.leftTop[1] * size+margin,
												margin,
												 (4-circle.leftTop[1])* size-2 * margin,
												(circle.rightBottom[0]-3) * size-2 * margin,
												0, 0, radius, 0);		
					g.drawRoundRectComplex(margin,
												circle.leftTop[0] * size+margin,
												 (circle.rightBottom[1]-3) * size-2 * margin,
												(4-circle.leftTop[0]) * size-2 * margin,
												0, radius, 0, 0);							
				}
			}
		
			g.endFill();
		}
		private function drawKanMapCircles(circles:Array):void {
			addChild(canvas); while (canvas.numChildren > 0) canvas.removeChildAt(0);
			for (var i:int = 0; i < circles.length; i++) 
				drawKanMapCircle(circles[i]);
		}
		//
		
		private function getExpressionFromCircle(c:KanMapCircle):Array {
			trace("getExpressionFromCircle:");
			var exp:Array = new Array(4);
			var vars:Array = new Array();
			var temp:Array = [0, 0];
			var row:int, col:int;
			var k:int;
			for (row = c.leftTop[0]; row <= c.rightBottom[0]; row++) {
				temp = KanMapCircle.add(temp, convertToBinary(convertToGray(row%4),2));
				trace("temp:", temp);
			}
			if (c.vector[0] == 0) temp = KanMapCircle.add(temp, temp);
			else if (c.vector[0] == 3) temp = KanMapCircle.add(temp, [-1,-1]);
			
			vars = vars.concat(temp);
			
			temp = [0, 0];
			for (col = c.leftTop[1]; col <= c.rightBottom[1]; col++) {
				trace("temp:", temp);
				temp=KanMapCircle.add(temp, convertToBinary(convertToGray(col%4),2));
			}
			if (c.vector[1] == 0) temp = KanMapCircle.add(temp, temp);
			else if (c.vector[1] == 3) temp = KanMapCircle.add(temp, [-1,-1]);

			vars = vars.concat(temp);
			
			for (var i:int = 0; i < vars.length; i++) {
				vars[i] -= 1;
			}
			trace(vars);
			return vars;
		}
		private function getVarName(index:int, type:int = 1):String {
			if (type == 1) return varNames[index];
			else if (type == -1) return "^" + varNames[index];
			else return "";
		}
		private function getSOPStr(circles:Array):String {
			var t:String = "";
			if (circles.length == 0) return "0";
			for (var i:int = 0; i < circles.length; i++) {
				if (i != 0) t += " + ";
				var c:KanMapCircle = circles[i] as KanMapCircle;
				trace(c.toString());
				var e:Array = getExpressionFromCircle(c);
				var expstr:String="";
				for (var j:int = 0; j < 4; j++) {
					expstr+= getVarName(j, e[j]);
				}
				trace("expstr:", expstr);
				t += expstr;
			}
			if (t == "") t = "1";
			return t;
		}
		public function initValues(n:int):void {
			for (var i:int = 0; i < 16; i++) {
				values[i] = n;
			}
		}
		private function drawText(xx:int, yy:int, content:String):TextField {
			var t:TextField = new TextField();
			t.autoSize = TextFieldAutoSize.CENTER;
			t.type = TextFieldType.DYNAMIC;
			t.selectable = false;
			t.text = content;
			t.x = xx-t.textWidth/2;
			t.y = yy - t.textHeight / 2;
			this.addChild(t);
			return t;
		}
		
		//some getter and setter:
		public function setTitle(title:String):void {
			this.title = title;
		}
		public function setValuesName(names:Array):void {
			for (var i:int = 0; i < 4; i++) {
				this.varNames[i] = names[i];
			}
		}
		public function setYName(name:String):void {
			this.YName = name;
		}
		public function setValues(vars:Array, Y:int):void {
			values[convertToInt(vars)] = Y;
		}
		public function getMapValue(row:int, col:int):int {
			return values[convertToGray(row)*4+convertToGray(col)];
		}
		public function getValues(vars:Array):int {
			return values[convertToInt(vars)];
		}
		//end getter and setter
		
		static public function convertToGray(n:int):int {
			switch(n) {
				case 0:return 0;
				case 1:return 1;
				case 2:return 3;
				case 3:return 2;
			}
			trace("Error in convertToGray");
			return 0;
		}
		static public function convertToBinary(n:int, numBits:int=4):Array {
			var an:Array = new Array(numBits);
			for (var i:int = numBits-1; i >=0 ; i--) {
				an[i] = n % 2;
				n /= 2;
			}
			return an;
		}
		static public function convertToInt(a:Array):int {
			var n:int = 0;
			for (var i:int =0; i<a.length  ; i++) {
				n *= 2;
				n += a[i];
			}
			return n;
		}
		
		private function onmousedown(e:MouseEvent):void {
			mx = mouseX;
			my = mouseY;
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseup);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onmousemove);
		}
		private function onmousemove(e:MouseEvent):void {
			this.x += mouseX - mx;
			this.y += mouseY - my;
			mx = mouseX;
			my = mouseY;
		}
		private function onMouseup(e:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onmousemove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseup);
		}
		
	}
	
}