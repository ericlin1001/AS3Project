/* 导入包，以便能够从此类
   直接引用这些包。 */
import mx.core.UIComponent;
import mx.controls.Label;
import mx.controls.TextInput;
import mx.controls.Button;

// 事件元数据标记
[Event("change")]
[Event("click")]
class LogIn extends UIComponent
{
    /* 组件必须将这些成员变量声明为
       组件框架中的相应组件。 */
    static var symbolName:String = "LogIn";
    static var symbolOwner:Object = LogIn;
    var className:String = "LogIn";

    // 组件的图形表示形式。
    private var name_label:MovieClip;
    private var password_label:MovieClip;
    private var name_ti:MovieClip;
    private var password_ti:MovieClip;
    private var login_btn:MovieClip;
    private var boundingBox_mc:MovieClip;
    private var startDepth:Number = 10;

    /* 可通过 getter/setter 公开使用的私有成员变量。
       这些表示名称和密码 InputText 字符串值。 */
    private var __name:String;
    private var __password:String;

    /* 构造函数： 
       为所有类所需要的同时，第 2 版组件还需要
       构造函数为空，有零个参数。 
       构造类实例后，所有初始化都发生
       在所需的 init 方法中。 */
    function LogIn() {
    }

    /* 初始化代码：
       第 2 版组件需要 init 方法。它还必须
       用 super.init() 调用它的父类 init() 方法。
       组件扩展 UIComponent 需要 init 方法。 */
    function init():Void {
        super.init();
        boundingBox_mc._visible = false;
        boundingBox_mc._width = 0;
        boundingBox_mc._height = 0;
    }

    /* 创建启动时所需的子对象：
       组件扩展 UIComponent 需要
       createChildren 方法。 */
    public function createChildren():Void {
        name_label = createObject("Label", "name_label", this.startDepth++);
        name_label.text = "Name:";
        name_label._width = 200;
        name_label._x = 20;
        name_label._y = 10;
        
        name_ti = createObject("TextInput", "name_ti", this.startDepth++,{_width:200,_heigh:22,_x:20,_y:30});
        name_ti.html = false;
        name_ti.text = __name;
        name_ti.tabIndex = 1;
        /* 将此文本输入字段设置为具有焦点。 
           注意：确保在 Flash Debugger 中选择"控制">"禁用快捷键"
           （如果尚未选择），否则
           测试时可能不设置焦点。 */
        name_ti.setFocus(); 
        
        name_label = createObject("Label", "password_label", this.startDepth++,{_width:200,_heigh:22,_x:20,_y:60});
        name_label.text = "Password:";
        
        password_ti = createObject("TextInput", "password_ti", this.startDepth++,{_width:200,_heigh:22,_x:20,_y:80});
        password_ti.html = false;
        password_ti.text = __password;
        password_ti.password = true;
        password_ti.tabIndex = 2;

        login_btn = createObject("Button", "login_btn", this.startDepth++,{_width:80,_heigh:22,_x:240,_y:80});
        login_btn.label = "LogIn";
        login_btn.tabIndex = 3;
        login_btn.addEventListener("click", this);
        
        size();
        
    }

    /* 第 2 版组件需要 draw 方法。
       通过调用 invalidate() 使组件
       无效后，即调用该方法。
       这将在一次重绘中成批进行更改，
       而不是逐个执行这些更改。此方法
       可以使效率更高，代码更集中。 */
    function draw():Void {
        super.draw();
    }

    /* 组件的大小更改时，
       即调用 size 方法。这一特性可用来调整子级大小，
       组件扩展 UIComponent 需要 size 方法。 */
    function size():Void {
        super.size();
        // 导致需要时进行重绘。
        invalidate();
    }

    /* 事件处理函数： 
       在 LogIn 按钮接收到鼠标单击时即由 LogIn 按钮调用。
       由于希望此事件可以在此组件范围外
       访问，因此使用 dispatchEvent 发送 click 事件。 */
    public function click(evt){
        // 用输入字段内容更新成员变量。
        __name = name_ti.text;
        __password = password_ti.text;
        // 当按钮激发一个 click 事件时即发送该事件。
        dispatchEvent({type:"click"});
    }

    /* 这是 name 属性的 getter/setter。
       [Inspectable] 元数据使属性显示在
       "属性"检查器中，并允许设置
       默认值。在值更改时，通过使用 getter/setter，您可以
       调用 invalidate 并强制组件重绘。 */
    [Bindable]
    [ChangeEvent("change")]
    [Inspectable(defaultValue="")]
    function set name(val:String){
        __name = val;
        invalidate();
    }
    
    function get name():String{ 
        return(__name);
    }
    
    [Bindable]
    [ChangeEvent("change")]
    [Inspectable(defaultValue="")]
    function set password(val:String){
        __password=val;
        invalidate();
    }
    
    function get password():String{ 
        return(__password);
    }
    
}
