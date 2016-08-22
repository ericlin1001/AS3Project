//main.as
trace("main");
import Animated;
trace("main");
//stop();
go_btn.addEventListener(MouseEvent.CLICK,go);

var panel:MovieClip=new Panel();
var panelArrow:MovieClip=new PanelArrow();
addChild(panel);
panel.x=100;
panel.y=100;

addChild(panelArrow);
panelArrow.x=panel.x;
panelArrow.y=panel.y;

var animate:Animated=new Animated();
function go(e:MouseEvent):void {
	/*panel.addEventListener(Event.ENTER_FRAME,update);
	trace("go");
	w=200;
	 a=-2.0;
	    friction=0.97;*/
	animate.init();
	animate.startAnimate(panel);
	
}