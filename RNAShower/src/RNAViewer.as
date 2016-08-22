package  
{
	import adobe.utils.CustomActions;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.SecurityErrorEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	/*，还有几个数据范围你要记，
	 * a-tail大约在0-40，
	 * stem+loop大约51个，
	 * loop在3-13长度，
	 * t-tail长度在0-30*/
	/**
	 * ...
	 * @author Ericlin
	 */
	public class RNAViewer extends Sprite
	{
		
		private var seqs:Array;
		private var matches:Array;
		private var points:Array;
		//
		private var spaceLen:Number = 6.0;
		private var size:Number = 18;
		private var color1:uint = 0x000000;
		private var color2:uint = 0xff0000;
		public function setArg(spaceLen:Number = 6.0, size:Number = 18):void {
			this.spaceLen = spaceLen;
			this.size = size;
		}
		public function setColors(c1:uint = 0, c2:uint = 0xff0000):void{
			color1 = c1;
			color2 = c2;
		}
		public function RNAViewer() 
		{
		}
		public function setSeqs(seqs:String, matches:String):Boolean {
			var numOne:int = 0;
			var i:int=0;
			if (seqs == null || matches == null || seqs.length <= 0 || seqs.length != matches.length) {
				return false;
			}
			for ( i = 0; i < matches.length; i++) {
				if (matches.charAt(i) == '1') numOne++;
					
			}
			if (numOne % 2 != 0) return false;
			this.seqs = new Array();
			this.matches = new Array();
			for (i = 0; i < seqs.length; i++){
				this.seqs.push(seqs.charAt(i));
				this.matches.push(matches.charAt(i));
			}
			return true;
		}
		public function draw():void {
			while (this.numChildren != 0) this.removeChildAt(0);
			var g:Graphics = this.graphics;
			g.clear();
			g.lineStyle(0);
			create();
			var temp:Array = arrayMultiP(points, new Point(size, -size));
			var rect:Rectangle = arrayGetRect(temp);
			temp = arrayAdd(temp, new Point(-rect.left,-rect.top));
			temp.push(temp[temp.length - 1]);
			//
			g.lineStyle(1, color1);
			for (var i:int = 0; i < temp.length - 1; i++) {
				getChar(seqs[i], temp[i].x, temp[i].y);
				drawCutLine(g, (temp[i] as Point).clone(), (temp[i + 1] as Point).clone(), spaceLen);
			}
			//
			g.lineStyle(1, color2);
			var l:int, r:int;
			 l = -1; r = matches.length;
			 while (l < r) {
				 //we assume the matches conatins double '1' (num>=0)
				 l++;
				 while (l < r && matches[l] != "1") l++;
				 if (l == r) break;
				 r--;
				 while (matches[r] != "1") r--;
				 drawCutLine(g,points[l], points[r],spaceLen);
			 }
		}
		private function drawCutLine(g:Graphics, from:Point, to:Point, cut:Number):Boolean {
			var base:Point = from.clone();
			var dir:Point = to.subtract(from);
			var len:Number = dir.length;
			if (len <= cut * 2) {
				return false;
			}
			dir = pointMulti(dir, 1 / len);
			from = base.add(pointMulti(dir, spaceLen));
			to = base.add(pointMulti(dir, len - spaceLen));
			//
			g.moveTo(from.x, from.y);
			g.lineTo(to.x, to.y);
			return true;
		}
		private function pointMulti(p:Point, t:Number):Point {
			return new Point(p.x*t,p.y*t);
		}
		private function createLoop(num:int):Array {
			var a:Array = new Array();
			if (num == 2) trace("error:createLoop num must >2");
			var angle:Number = Number(num - 2) * Math.PI / Number(num);
			//
			var p:Point = new Point( -1, 0);
			a.push(p);
			var i:int ;
			for (i = 1; i < num; i++) {
				p = a[i - 1];
				a.push(rotatePoint(new Point(-p.x,-p.y),angle));
			}
			
			a[0] = new Point(0, 0);
			for ( i = 1; i < num; i++) {
				var tempP:Point = a[i];
				a[i] = tempP.add( a[i - 1] as Point);
			}
			return a;
		}
		private function create():void {
			points = new Array();
			var loopL:int = -1, loopR:int = -1;
			var tailL:int, tailR:int;
			var l:int, r:int;
			var i:int = l;
			
			l = 0; r = matches.length-1;
			while (l < r && matches[l] != "1") l++;
			if (l < r) {
			trace("normal");
	
			while (l < r && matches[r] != "1") r--;
			
			tailL = l;
			tailR = r;
			//
			loopL = l;
			loopR = r;
			while (l < r) {
				 l++;
				 while (l < r && matches[l] != "1") l++;
				 if (l == r) break;
				 loopL = l;
				 r--;
				 while (matches[r] != "1") r--;
				 
			}
			loopR = r;
			l = loopL;
			//
			arrayFill(createLoop(r - l + 1), points, l);
			var leftPoints:Array;
			var rightPoints:Array;
			while(1){
				for (l = loopL-1; l >= tailL; l--) if (matches[l] == '1') break;
				for (r = loopR+1; r <= tailR; r++) if (matches[r] == '1') break;
				if (matches[l] != '1') break;
				//
				 leftPoints = createSideLoop(loopL - l + 1);
				leftPoints= arrayMultiP(leftPoints, new Point( -1, 1));
				rightPoints = createSideLoop(r - loopR + 1);
				//
				var heightL:Number = arrayGetHeight(leftPoints);
				var heightR:Number = arrayGetHeight(rightPoints);
				if (heightL < heightR) { leftPoints = arrayMultiP(leftPoints, new Point(1,heightR / heightL)); }
				else if(heightL > heightR){ rightPoints = arrayMultiP(rightPoints, new Point(1,heightL / heightR)); }
				//
				arrayFill(arrayAdd(leftPoints, points[loopL]).reverse(), points, l);
				arrayFill(arrayAdd(rightPoints, points[loopR]), points, loopR+1);
				//
				loopL = l;
				loopR = r;
				if (loopR == tailR) break;
			}
			
			leftPoints = createLine(tailL + 1);
			leftPoints= arrayMultiP(leftPoints, new Point( -1, 1));
			rightPoints = createLine(matches.length - tailR);
			//
			arrayFill(arrayAdd(leftPoints, points[loopL]).reverse(), points, 0);
			arrayFill(arrayAdd(rightPoints, points[loopR]), points, tailR+1);
			//
			}else {
				trace("contain only 0");
				points[0] = new Point(0, 0);
				arrayFill(createLine(matches.length), points, 1);
			}
			trace("points", points);
			
		}
		private function arrayGetRect(arr:Array):Rectangle {
			var minX:Number, maxX:Number;
			var minY:Number, maxY:Number;
			minX = maxX =0;
			minY = maxY =0;
			for (var i:int = 0; i < arr.length; i++) {
				var p:Point = arr[i] as Point;
				if (minX > p.x) minX = p.x;
				else if (maxX < p.x) maxX = p.x;
				if (minY > p.y) minY = p.y;
				else if (maxY < p.y) maxY = p.y;
			}
			return new Rectangle(minX, minY, maxX, maxY);
		}
		private function arrayGetWidth(arr:Array):Number {
			//assume that the (0,0) is included in arr
			var minX:Number, maxX:Number;
			minX = maxX =0;
			for (var i:int = 0; i < arr.length; i++) {
				var p:Point = arr[i] as Point;
				if (minX > p.x) minX = p.x;
				else if (maxX < p.x) maxX = p.x;
			}
			return maxX - minX;
		}
		private function arrayGetHeight(arr:Array):Number {
			//assume that the (0,0) is included in arr
			var minY:Number, maxY:Number;
			minY = maxY =0;
			for (var i:int = 0; i < arr.length; i++) {
				var p:Point = arr[i] as Point;
				if (minY > p.y) minY = p.y;
				else if (maxY < p.y) maxY = p.y;
			}
			return maxY - minY;
		}
		private function createLine(num:int):Array {
			//not conatin the first one (0,0); 
			//return a array with len of num-1
			var a:Array = new Array();
			for (var i:int = 0; i < num - 1; i++) {
				a.push(new Point(i + 1, 0));
			}
			return a;
		}
		private function createSideLoop(num:int):Array {
			//not contain the first one (0,0)
			//return a array with len of num-1
			var a:Array = new Array();
			switch(num) {
				case 2:
				a.push(new Point(0,-1));
				break;
				case 3:
				a.push(new Point(Math.sqrt(3) / 2, -0.5));
				a.push(new Point(0,-1));
				
				break;
				case 4:
				a.push(new Point(Math.sqrt(3) / 2, -0.5));
				a.push(new Point(Math.sqrt(3) / 2, -1.5));
				a.push(new Point(0,-2));
				
				break;
				default:
					var numLen:int = 2 * (num - 1);
					var loop:Array = createLoop(numLen);
					loop.splice(0, 1);
					var angle:Number = Math.PI *(1- (numLen-2) / numLen) / 2.0;
					for (var i:int = 0; i < loop.length; i++) {
						var tempP:Point = loop[i];
						loop[i] = rotatePoint(tempP, angle);
					}
					arrayFill(loop, a, 0, num-1);
					a = arrayMulti(a, -1);
				break;
				
				
			}
			return a;
		}
		private function rotatePoint(p:Point, a:Number):Point {
			var cosa:Number = Math.cos(a);
			var sina:Number = Math.sin(a);
			return new Point(p.x *cosa  - p.y *sina, p.x * sina + p.y * cosa );                                                                                          
		}
		private function arrayMulti(arr:Array, t:Number):Array {
			return arrayMultiP(arr,new Point(t,t));
		}
		private function arrayMultiP(arr:Array, t:Point):Array {
			for (var i:int = 0; i < arr.length; i++) {
				var p:Point = arr[i] as Point;
				 p.x *= t.x;
				 p.y*=t.y;
				 arr[i] = p;
			}
			return arr;
		}
		private function arrayAdd(arr:Array, adden:Point):Array {
			for (var i:int = 0; i < arr.length; i++) {
				var p:Point = arr[i] as Point;
				arr[i] = p.add(adden) ;
			}
			return arr;
		}
		private function arrayFill(from:Array, to:Array, start:int, len:int=-1):void {
			if (len == -1) len = from.length;
			for (var i:int = 0; i < len; i++) {
				to[start + i] = from[i];
			}
		}
		private function getChar( c:String, posx:int=0, posy:int=0):TextField {
			var t:TextField = new TextField();
			t.text = c.toUpperCase();
			t.autoSize = TextFieldAutoSize.CENTER;
			t.selectable = false;
			t.x = posx-t.width/2;
			t.y = posy-t.height/2;
			addChild(t);
			return t;
		}
		
	}
	
}