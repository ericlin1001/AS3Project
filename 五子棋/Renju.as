package {
	public class Renju {
		private var n:Number=15;
		public function Renju(tn:Number=15 ) {
			if((1<tn)&&(tn<50)){
				n=tn;
			}
			trace("所用的棋盘是："+n+" * "+n)
		}
		public function getAllType(web:Array,tx:Number ,ty:Number ):Array {
			if (web[tx][ty]==1) {
				return getBAllType(web,tx,ty);
			} else if (web[tx][ty]==0) {
				return getWAllType(web,tx,ty);
			}
			return new Array();
		}
		private function getBAllType(web:Array,tx:Number ,ty:Number ):Array {
			var shape:String="";
			var allType:Array=new Array();
			for (var i=0; i<=10; i++) {
				allType[i]=0;
			}
			var top:int =ty-5;
			var bottom:int =ty+5;
			var left:int =tx-5;
			var right:int =tx+5;
			//竖直方向
			shape="";
			for (i=top; i<=bottom; i++) {
				if ((i<0)||(i>n-1)) {
					shape+="0";
				} else {
					shape+=web[tx][i];
				}
			}
			allType[getType(shape)]++;
			//横向方向
			shape="";
			for (i=left; i<=right; i++) {
				if ((i<0)||(i>n-1)) {
					shape+="0";
				} else {
					shape+=web[i][ty];
				}
			}
			allType[getType(shape)]++;
			//正斜方向
			shape="";
			var j=left;
			for (i=top; i<=bottom; i++) {
				if ((i<0)||(j<0)||(i>n-1)||(j>n-1)) {
					shape+="0";
				} else {
					shape+=web[j][i];
				}
				j++;
			}
			allType[getType(shape)]++;
			//反斜方向
			shape="";
			j=right;
			for (i=top; i<=bottom; i++) {
				if ((i<0)||(j<0)||(i>n-1)||(j>n-1)) {
					shape+="0";
				} else {
					shape+=web[j][i];
				}
				j--;
			}
			allType[getType(shape)]++;
			return allType;
		}
				private function getWAllType(web:Array,tx:Number ,ty:Number ):Array {
			var tempweb:Array =new Array();
			for (var i=0; i<n; i++) {
				var tempArray=new Array();
				for (var j=0; j<n; j++) {
					if (web[i][j]==2) {
						tempArray[j]=2;
					} else {
						tempArray[j]=1-web[i][j];
					}
				}
				tempweb[i]=tempArray;
			}
			return getBAllType(tempweb,tx,ty);
		}
		public function getType(str:String):Number {
			var type:Number=10;
			str=cutDown(str);
			var l=str.length;
			if (str.length<6) {
				return 10;
			}
			for (var j=0; j<2; j++) {
				for (var i=0; i<=l-6; i++) {
					type=Math.min(type,findType(str.substr(i,6)));
				}
				str=reverseStr(str);
			}
			return type;
		}
		private function cutDown(str:String):String {
			var l:Number=str.length-1;
			if ((l>6)&&(str.substr(5,1)=="1")) {
				var left:Number=0;
				for (var i=5; i>=0; i--) {
					if (str.substr(i,1)=="0") {
						left=i;
						break;
					}
				}
				for (i=5; i<=l; i++) {
					if (str.substr(i,1)=="0") {
						l=i;
						break;
					}
				}
				return str.substring(left,l+1);
			} else {
				return str;
			}
		}
		private function strFromNum(num:Number ):String {
			var str:String="";
			switch (num) {
				case 0 :
					str="连五";
					break;
				case 1 :
					str="活四";
					break;
				case 2 :
					str="冲四";
					break;
				case 3 :
					str="活三";
					break;
				case 4 :
					str="跳三";
					break;
				case 5 :
					str="眠三";
					break;
				case 6 :
					str="活二";
					break;
				case 7 :
					str="跳二";
					break;
				case 8 :
					str="大跳二";
					break;
				case 9 :
					str="眠二";
					break;
				default :
					break;
			}
			return str;
		}
		private function findType(str:String):Number {
			switch (str) {
					//1.活四：
				case "211112" :
					return 1;
					break;
					//2.冲四：
				case "011112" :
				case "011121" :
				case "011211" :
				case "012111" :
					return 2;
					break;
					//3.活三：
				case "221112" :
					return 3;
					break;
					//4.跳三：
				case "212112" :
					return 4;
					break;
					//5.眠三：
				case "011122" :
				case "011212" :
				case "012112" :
					return 5;
					break;
					//6.活二：
				case "221122" :
				case "211222" :
					return 6;
					break;
					//7.跳二：
				case "212122" :
					return 7;
					break;
					//8.大跳二：
				case "212212" :
					return 8;
					break;
					//9.眠二：
				case "011222" :
				case "012122" :
				case "012212" :
					return 9;
					break;
					//10.连五：
				case "011111" :
				case "211111" :
					return 0;
					break;
				default :
					return 10;
					break;
			}
		}
		private function reverseStr(str:String):String {
			var temp="";
			for (var i=str.length-1; i>=0; i--) {
				temp+=str.substr(i,1);
			}
			return temp;
		}
	}
}
/*
black:1 White:0 Space:2
1.活四：
211112
2.冲四：
011112
011121
011211
012111
3.活三：
221112
4.跳三：
212112
5.眠三：
011122
011212
012112
6.活二：
221122
211222
7.跳二：
212122
8.大跳二：
212212
9.眠二：
011222
012122
012212
10.连五：
011111
211111
*/