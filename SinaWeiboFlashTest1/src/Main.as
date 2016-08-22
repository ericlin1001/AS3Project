package  {

	import flash.display.GradientType;
	import flash.display.Graphics;
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import com.sina.microblog.MicroBlog;
    import com.sina.microblog.events.*;    
    public class Main extends MovieClip {
        ///sdk的调用对象实例
        private var _mb:MicroBlog;

 

        private var _btnLogin:SimpleButton;

		private var t:Sprite = new Sprite();

        ///构造函数

        public function Main() {
			addChild(t);
			var g:Graphics = t.graphics;
			g.lineStyle(0);
			g.beginFill(0xff0000);
			g.drawCircle(0, 0, 50);
			g.endFill();
			t.x = 100;
			t.y = 100;
			t.buttonMode = true;
            init();

        }

 

        ///初始化函数

        private function init():void

        {

            //_btnLogin = this["btnLogin"];

            _mb = new MicroBlog(); ///创建实例
			_mb.logout();
			_mb.login();
            _mb.addEventListener(MicroBlogEvent.LOGIN_RESULT,onLoginResult); ///侦听登录完成后的事件
            _mb.addEventListener(MicroBlogEvent.LOAD_FRIENDS_TIMELINE_RESULT, onUserTimelineResult);///侦听调用获取用户好友发的微博接口结果事件
            _mb.addEventListener(MicroBlogErrorEvent.LOAD_FRIENDS_TIMELINE_ERROR, onUserTimelineError);///侦听调用获取用户好友发的微博接口错误事件
            _mb.source = "2326126366";///设置请求来源，就是创建工程时的app key
            _mb.debugMode = true;///设置为调试模式，如果没有此属性请update svn或者重新下载最新版本的sdk源码，记得上线版本去掉
            t.addEventListener(MouseEvent.CLICK, onLoginClick);
			trace("init");
        }
        ///点击登录按钮后触发登录
        private function onLoginClick(e:MouseEvent):void

        {
			trace("you are trying to login in.");
			_mb.logout();
            _mb.login();
			

        }
        ///登录成功
        private function onLoginResult(e:MicroBlogEvent):void

        {
			trace("login success.");
            _mb.loadFriendsTimeline(); ///登录成功后我们可以开始调用接口了，此处测试一个获取登录用户好友发的微博接口

        }


        ///成功获取当前登录用户好友发的微博
        private function onUserTimelineResult(e:MicroBlogEvent):void

        {
            trace(e.result);

        }

 

        ///获取当前登录用户好友发的微博发生错误

        private function onUserTimelineError(e:MicroBlogErrorEvent):void

        {
            trace(e.message);

        }

    }

}
