var settedOrders:Object={Up:"up",Down:"down",Left:"left",Right:"right",Pen:"pen",NoPen:"nopen",
Clear:"clear",Draw:"draw",DrawCircle:"drawcircle",DrawRect:"drawrect",Undo:"undo",Line:"line",Color:"color",FillColor:"fillcolor",Set:"set",Reset:"reset",AllReset:"allreset"};
//****************************************initialing************************
const blankWid:Number=430;
const blankHei:Number=250;
const eachLen:Number =3;
const centerX:Number=blankWid/2;
const centerY:Number=blankHei/2;
const LINE_MAX:Number=20;
var oldX:Number=0;
var oldY:Number=0;
var myX:Number=0;
var myY:Number=0;
var color:uint =0x00ff00;
var fillColor:uint =0xffffff;
var lineWidth:Number=3;
var isPen:Boolean =true;
//***************************************initialing*******************
//**************** setting Text ************
var orders_txt:TextField=new TextField();
var before_txt:TextField=new TextField();
var trace_txt:TextField=new TextField();
var container:Sprite=new Sprite();
addChild(container);
container.addChild (before_txt);
container.addChild (trace_txt);
container.addChild (orders_txt);
with (orders_txt) {
	type=TextFieldType.INPUT;
	border=true;
	width=220;
	height=120;
	x=0;
	y=0;
	multiline=true;
}
with (before_txt) {
	type=TextFieldType.DYNAMIC;
	border=true;
	width=230;
	height=60;
	x=300;
	y=0;
	multiline=true;
	appendText("说明：可按F5或Ctrl代替\"执行\"按钮\n")
}
with (trace_txt) {
	type=TextFieldType.DYNAMIC;
	border=true;
	width=230;
	height=65;
	x=300;
	y=60;
	multiline=true;
	appendText("相应代码如下:\n");
}
//**********************end setting Text****************
container.x=8;
container.y=blankHei+20;
var drawBlank:Sprite=new Sprite();
drawBlank.graphics.lineStyle(0);
drawBlank.graphics.drawRect(0,0,blankWid,blankHei);
Pen(new Array());
drawBlank.x=50;
drawBlank.y=10
addChild(drawBlank);
var hand_mc:Sprite=new Sprite();
Set(new Array(0,0));
with(hand_mc.graphics ){
	lineStyle(0);
	drawRect(0,0,2,2);
}
drawBlank.addChild(hand_mc);
enter_mc.x=268;
enter_mc.y=380;
enter_mc.addEventListener(MouseEvent.CLICK,clickHandler);
//*****************************
var request:URLRequest=new URLRequest("userSetting.txt");
var loader:URLLoader=new URLLoader();
loader.addEventListener(Event.COMPLETE,completeHandler);
try {
	loader.load(request);
} catch (error:Error) {
	trace("Can't load the userSettingj.txt");
	trace_txt.appendText ("Can't load the userSettingj.txt");
} finally {
	settedOrders=changeLowerCase(settedOrders);
//
}
function completeHandler(event:Event):void {
	trace("Load userSetting.txt has been completed!")
	trace_txt.appendText("Load userSettingj.txt has been completed!\n");
	var Vars:URLVariables=new URLVariables(event.target.data);
	var regExp:RegExp=/[a-zA-Z]+/;
	for (var i:String in settedOrders) {
		var tOrder:String=(String(Vars[i]).match(regExp))[0];
		/**/if (tOrder!=null && tOrder!="undefined") {
			settedOrders[i]=tOrder;
		}
		trace(i+"="+settedOrders[i]);
		trace_txt.appendText(i+"="+settedOrders[i]+"\n");
	}
	settedOrders=changeLowerCase(settedOrders);
}

//*************************
//************************
function executeOrder(str:String):void {
	var orderRegExp:RegExp=/([a-zA-Z]+)[ (]*((-|\w)*([ ,](-|\w)+)*)[ )]*;*/;
	var results:Array=orderRegExp.exec(str);
	/**/var orderName:String =results[1];
	var para:Array=results[2].split(/[ ,]/);
	trace("orderName:",orderName);
	/**/trace("para:",para);
	/**/switch(orderName.toLowerCase()){
	case settedOrders.Up:
	Up(para);
	break;
	case settedOrders.Down:
	Down(para);
	break;
	case settedOrders.Right:
	Right(para);
	break;
	case settedOrders.Left:
	Left(para);
	break;
	case settedOrders.Pen:
	Pen(para);
	break;
	case settedOrders.NoPen:
	NoPen();
	break;
	case settedOrders.Clear:
	Clear();
	break;
	case settedOrders.Draw:
	Draw(para);
	break;
	case settedOrders.DrawCircle:
	DrawCircle(para);
	break;
	case settedOrders.DrawRect:
	DrawRect(para);
	break;
	case settedOrders.Undo:
	Undo();
	break;
	case settedOrders.Line:
	Line(para);
	break;
	case settedOrders.Color:
	Color(para);
	break;
	case settedOrders.FillColor:
	FillColor(para);
	break;
	case settedOrders.Set:
	Set(para);
	break;
	case settedOrders.Reset:
	Reset();
	break;
	case settedOrders.AllReset:
	AllReset();
	break;
	default:
    trace("default...")
	break;
	}
}
//*******************definate all the orders *********************
function Pen(paraArray:Array):void{
	isPen=true;
	var tlineWidth:Number=lineWidth;
	var tcolor:uint=color;
	if(paraArray.length>=1){
		 tlineWidth=Number(paraArray[0]);
	}
	if(paraArray.length>=2){
		 tcolor=uint(paraArray[1]);
	}
	if((tlineWidth>=0)&&(tlineWidth<=LINE_MAX)){
		lineWidth=tlineWidth;
	}
	if((tcolor>=0)&&(tcolor<=0xffffff)){
		color=tcolor;
	}
	with(drawBlank){
		graphics.lineStyle(lineWidth,color);
	}
}
function NoPen():void{
	 isPen=false;
}
function Clear():void{
	with(drawBlank ){
		graphics.clear();
	}
}
function  Draw(paraArray:Array):void{
	var para1:Number=Number(paraArray[0]);
	var para2:Number=Number(paraArray[1]);
	if(!isNaN(para1) && !isNaN(para2) ){
	oldX=myX;
	oldY=myY;
	myX=para1;
	myY=-para2;
	if(isPen){
	with(drawBlank){
		graphics.moveTo(oldX*eachLen+centerX,oldY*eachLen+centerY);
		graphics.lineTo(myX*eachLen+centerX,myY*eachLen+centerY)
	}
	}
	hand_mc.x=myX*eachLen+centerX;
	hand_mc.y=myY*eachLen+centerY;
	}
}
function Undo():void{
	with(drawBlank){
		graphics.lineStyle(lineWidth,0xffffff);
		graphics.moveTo(myX*eachLen+centerX,myY*eachLen+centerY);
		graphics.lineTo(oldX*eachLen+centerX,oldY*eachLen+centerY)
	}
	myX=oldX;
	myY=oldY;
	hand_mc.x=myX*eachLen+centerX;
	hand_mc.y=myY*eachLen+centerY;
	Pen(new Array());
}
function Line(paraArray:Array):void{
	if(paraArray.length>0){
	Pen(new Array(paraArray[0],color));
	}
}
function Color(paraArray:Array):void{
	if(paraArray.length>0){
	Pen(new Array(lineWidth,paraArray[0]));
	}
}
function FillColor(paraArray:Array):void{
	if(paraArray.length>0){
	fillColor=uint(paraArray[0]);
	}
}
function Set(paraArray:Array):void{
	var para1:Number=0;
	var para2:Number=0;
	if(paraArray.length>0){
		 para1=Number(paraArray[0]);
	}
	if(paraArray.length>1){
		 para2=Number(paraArray[1]);
	}
	oldX=myX;
	oldY=myY;
	myX=para1;
	myY=-para2;
	hand_mc.x=myX*eachLen+centerX;
	hand_mc.y=myY*eachLen+centerY;
}
function Reset():void{
	Set(new Array(0,0))
}
function AllReset():void{
	Clear()
	Pen(new Array(1,0x000000))
}
function Up(paraArray:Array):void{
	var para:Number=Number(paraArray[0]);
	oldX=myX;
	oldY=myY;
	myY-=para;
	if(isPen){
	with(drawBlank){
		graphics.moveTo(oldX*eachLen+centerX,oldY*eachLen+centerY);
		graphics.lineTo(myX*eachLen+centerX,myY*eachLen+centerY)
	}
	}
	hand_mc.x=myX*eachLen+centerX;
	hand_mc.y=myY*eachLen+centerY;
}
function Down(paraArray:Array):void{
	var para:Number=Number(paraArray[0]);
	oldX=myX;
	oldY=myY;
	myY+=para;
	if(isPen){
	with(drawBlank){
		graphics.moveTo(oldX*eachLen+centerX,oldY*eachLen+centerY);
		graphics.lineTo(myX*eachLen+centerX,myY*eachLen+centerY)
	}
	}
	hand_mc.x=myX*eachLen+centerX;
	hand_mc.y=myY*eachLen+centerY;
}
function Right(paraArray:Array):void{
	var para:Number=Number(paraArray[0]);
	oldX=myX;
	oldY=myY;
	myX+=para;
	if(isPen){
	with(drawBlank){
		graphics.moveTo(oldX*eachLen+centerX,oldY*eachLen+centerY);
		graphics.lineTo(myX*eachLen+centerX,myY*eachLen+centerY)
	}
	}
	hand_mc.x=myX*eachLen+centerX;
	hand_mc.y=myY*eachLen+centerY;
}
function Left(paraArray:Array):void{
	var para:Number=Number(paraArray[0]);
	oldX=myX;
	oldY=myY;
	myX-=para;
	if(isPen){
	with(drawBlank){
		graphics.moveTo(oldX*eachLen+centerX,oldY*eachLen+centerY);
		graphics.lineTo(myX*eachLen+centerX,myY*eachLen+centerY)
	}
	}
	hand_mc.x=myX*eachLen+centerX;
	hand_mc.y=myY*eachLen+centerY;
}
function DrawCircle(paraArray:Array):void{
	var cx:Number=Number(paraArray[0]);
	var cy:Number=Number(paraArray[1]);
	var r:Number=Number(paraArray[2]);
	if(!isNaN(cx) && !isNaN(cy) && !isNaN(r)){
	if(r<0){
		r=0;
	}
	oldX=myX;
	oldY=myY;
	myX=cx
	myY=-cy;
	if(isPen){
	with(drawBlank){
		graphics.beginFill(fillColor);
		graphics.drawCircle(myX*eachLen+centerX,myY*eachLen+centerY,r);
		graphics.endFill()
	}
	}
	hand_mc.x=myX*eachLen+centerX;
	hand_mc.y=myY*eachLen+centerY;
	}
}
function DrawRect(paraArray:Array):void{
	var cx:Number=Number(paraArray[0]);
	var cy:Number=Number(paraArray[1]);
	var a:Number=Number(paraArray[2]);
	var b:Number=Number(paraArray[3]);
	if(!isNaN(cx) && !isNaN(cy) && !isNaN(a) && !isNaN(b)){
	if(a<0 ){
		a=0;
	}
	if(b<0){
		b=0;
	}
	oldX=myX;
	oldY=myY;
	myX=cx
	myY=-cy;
	if(isPen){
	with(drawBlank){
		graphics.beginFill(fillColor);
		graphics.drawRect(myX*eachLen+centerX,myY*eachLen+centerY,a*eachLen,b*eachLen);
		graphics.endFill()
	}
	}
	hand_mc.x=myX*eachLen+centerX;
	hand_mc.y=myY*eachLen+centerY;
	}
}
//*********************end definating all the orders *************
//********************
function changeLowerCase(obj:Object):Object {
	for (var i:String in obj) {
		obj[i]=obj[i].toLowerCase();
	}
	return obj;
}
//*****************
function separteOrders(str:String):Array {
	var eachOrder:RegExp=/[A-Za-z0-9 ,()\-]+?[$;\n\r]/mg;
	return str.match(eachOrder);
}
//*************************
function clickHandler(event:MouseEvent):void {
	var torders:String=orders_txt.text;
	if(torders.charAt(torders.length -1)!=';'){
		torders+=';';
	}
	var orders:Array=separteOrders(torders);
	for (var i=0; i<orders.length; i++) {
		trace("seperateOrders:"+orders[i]);
		executeOrder(orders[i]);
	}
	before_txt.appendText(torders+"\n");
	orders_txt.text ="";
}
stage.addEventListener(KeyboardEvent.KEY_DOWN ,keyDownHandler);
function keyDownHandler(event:KeyboardEvent):void{
	switch(event.keyCode){
		case 116://F5
		case 17://ctrl
		clickHandler(new MouseEvent("test"));
		trace("you press F5 or Ctrl")
		break;
		default:
		//trace("Default...key press:"+event.keyCode);
		break;
	}
}