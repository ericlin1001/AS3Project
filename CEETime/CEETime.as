
var so:SharedObject=SharedObject.getLocal("CEETime");
if(so.data.time==undefined){
	so.data.time=0
}
time_txt.text=String(so.data.time);
var targetDate:Date=new Date(2011,6,9,0,0,0,0);
go_btn.addEventListener(MouseEvent.CLICK,onClick);
this.addEventListener(Event.ENTER_FRAME,update);
function update(e:Event):void{
	var disDate:Date=new Date(targetDate.getTime()-(new Date()).getTime());
	day_txt.text=String(30*disDate.getMonth()+disDate.getDate());
	hour_txt.text=String(disDate.getHours());
	minute_txt.text=String(disDate.getMinutes());
	second_txt.text=String(disDate.getSeconds());
	
}
function onClick(e:MouseEvent):void{
	so.data.time++;
	time_txt.text=String(so.data.time);
	so.flush();
}
