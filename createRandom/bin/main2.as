//main.as
import Animated;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLVariables;
stop();
var panel:MovieClip;
const num:int = 2;
var tests:Array=new Array();
var panels:Array=new Array();
var getAns:Array=new Array();
var allStop:Boolean = true;
var init_answer:String = "";
for(var i:int = 0; i < num; i++) {
	 init_answer+= '_';
}
init();
stageInit();
//answer_txt
//

var setting:Object = { "from":1, "to":9999, "except":[], "startWith":[] };
function loadSetting():void{
var request:URLRequest=new URLRequest("setting.ini");
var loader:URLLoader=new URLLoader();
loader.addEventListener(Event.COMPLETE,completeHandler);
loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandle);
try {
	loader.load(request);
} catch (error:Error) {
	trace("Can't load the setting.ini");
	//trace("Can't load the userSettingj.txt");
}

}
function errorHandle(e:Event):void {
	trace("can't load setting.ini");
}
 function convertToInts(arr:Array):Array {
	var j:int;
	var r:Array = new Array();
	for (j = 0; j < arr.length; j++) {
		var s:Number = parseInt( arr[j]);
		if (!isNaN(s)) {
			r.push(int(s));
		}
	}
	return r;
}
function completeHandler(event:Event):void {
	trace("Load setting.ini has been completed!");
	var Vars:URLVariables=new URLVariables(event.target.data);
	setting["from"] = parseInt(Vars["from"]);
	setting["to"] = parseInt(Vars["to"]);
	//
	setting["from"] = isNaN(setting["from"])?1:int(setting["from"]);
	setting["to"] = isNaN(setting["to"])?(Math.pow(10,num)-1):int(setting["to"]);
	setting["except"] =convertToInts((Vars["except"] as String).split(','));
	setting["startWith"] =convertToInts((Vars["startWith"] as String).split(','));
	var i:String;
	for ( i in setting) {
		trace("setting:"+i+"="+setting[i]);
	}
}






function printObj(test:Object):void{
	trace("a="+test.a,"w="+test.w,"f="+test.f,"an="+test.an);
}
function answer(k:int,index:int):void {
	getAns[index]=k;
	//
	trace("an"+index+"="+k);
	var i:int;
	var s:String="";
	allStop=true;
	for( i=0;i<num;i++){
		if(getAns[i]>=0)s+=getAns[i];
		else {allStop=false;s+="_";}
	}
	setAns(s);
}
function setAns(s:String):void { answer_txt.text = s; };

function getNeedCreateRandoms():Array{
	var ans:Array = new Array();
	var an:int = 0;
	var i:int;
	//setting
	// { "from":1, "to":200, "except":[2, 10], "startWith":[1, 3, 8] };
	var startWith:Array = setting["startWith"] as Array;
	var except:Array = setting["except"] as Array;
	var from:int =setting["from"];
	var to:int = setting["to"];
	var count = 1000;
	while(--count){
		if (startWith.length > 0) {
			an = startWith.shift();
		}else {
			an = Math.floor(Math.random() *(to - from + 1) + from);
		}
		if (from<=an && an<=to && except.indexOf(an)<0) {
			break;
		}
	}
	an = int(an);
	//
	trace("an=" + an);
	while (an != 0) {
		ans.unshift(an % 10);
		an /= 10;
	}
	while (ans.length < num) ans.unshift(0);
	for (i = 0; i < ans.length; i++) {
		trace("ans[" + i + "]=" + ans[i]);
	}
	return ans;
}


function go(e:MouseEvent):void {
	if(allStop){
	allStop=false;
	setAns(init_answer);
	getAns=[-1,-1,-1];
	var ans:Array=getNeedCreateRandoms();
	for(var i:int=0;i<panels.length;i++){
		var p:Sprite=panels[i];
		var an:int=ans[ans.length-panels.length+i];
		//trace("p"+i+"->an="+an);
		startPanel(p.getChildAt(0) as Sprite,an,answer,i);
	}
	}
}
function init():void {
	loadSetting();
	for(var i:int=0;i<num;i++){
		var p:Sprite=createPanel(i*130+100,100);
		addChild(p);
		panels.push(p);
	}
	setAns(init_answer);
}



//************************************************//
function startPanel(mc:Sprite,k:int,an:Function,index:int):void{
	var test=getArgs(k,mc.rotation);
	var animate:Animated=new Animated();
	animate.init(test.a,test.w,test.f);
	animate.setComplete(an);
	animate.setIndex(index);
	animate.startAnimate(mc);
}

function getRnd(r:Number):Number{
	return Math.random()*r+(1-r);
}
function getArgs(k:int,startOrient:int=0):Object{
	if(k<0 || k>9)trace("error k="+k);
	var i:int;
	var test;
	var temp:int=756-startOrient;
	var tempAn:int;
	
	for(i=0;i<tests.length;i++){
		tempAn=Math.floor((temp-tests[i].rotation)/36)%10;
		if(tempAn==k){
			test=tests[i];
			tests.splice(i,1);
			return test;
			break;
		}
	}
	var count:int=100;
	while(1){
		var a:Number=-3.0*getRnd(0.2);
		var w:Number=200*getRnd(0.2);
		var f:Number=0.98*getRnd(0.2);
		test=testOne(a,w,f);
		tempAn=Math.floor((temp-test.rotation)/36)%10;
		if(tempAn==k){
			return test;
		}
		if(count<=0)break;
		
		tests.push(test);
		count--;
	};
	return tests[0];
}
function createPanel(x:int,y:int):Sprite{
	var container:Sprite=new Sprite();
	var panel:MovieClip=new Panel();
	var panelArrow:MovieClip=new PanelArrow();
	container.addChild(panel);
	container.addChild(panelArrow);
	panel.x=x;
	panel.y=y;
	panelArrow.x=panel.x;
	panelArrow.y=panel.y;
	return container;
}
function stageInit():void {
	go_btn.addEventListener(MouseEvent.CLICK,go);
}

//**********************//
var isEnd:Boolean=true;
var an:int=-1;
function end( k:int,index:int):void {
	isEnd=true;
	an=k;
}
function testOne(a:Number=-3,w:Number=200,f:Number=0.98):Object {
	var animate:Animated=new Animated();
	var mc:Sprite=new Sprite();
	mc.rotation=0;
	animate.autoStart=false;
	animate.init(a,w,f);
	animate.setComplete(end);
	animate.startAnimate(mc);
	an=-1;
	isEnd=false;
	while (!isEnd) {
		animate.update();
	}
	return {"a":a,"w":w,"f":f,"an":an,"rotation":mc.rotation};
}
//***********************//