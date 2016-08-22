package  
{
	import com.sina.microblog.data.MicroBlogStatus;
	import com.sina.microblog.data.MicroBlogUser;
	import com.sina.microblog.events.MicroBlogErrorEvent;
	import com.sina.microblog.events.MicroBlogEvent;
	import com.sina.microblog.MicroBlog;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	/*
	 * App Key：
2326126366
App Secret：
b80d8480aae952531fe39fdedce1705e
*/
	public class test1 extends Sprite
	{
		private var mb:MicroBlog;
		private var loginBtn:Sprite;
		public function test1() 
		{
			trace("init");
			loginBtn = new Sprite();
			loginBtn.buttonMode = true;
			addChild(loginBtn);
			loginBtn.x = 200;
			loginBtn.y = 200;
			var g:Graphics = loginBtn.graphics;
			g.lineStyle(0);
			g.beginFill(0xff0000);
			g.drawCircle(0, 0, 50);
			g.endFill();
			loginBtn.addEventListener(MouseEvent.CLICK, onLoginClick);
			init();
		}
		private function init():void {
			mb = new MicroBlog();
			mb.source = "2326126366";
			mb.debugMode = true;
			mb.addEventListener(MicroBlogEvent.ANYWHERE_TOKEN_RESULT, onLoginResult);
		}
		private function onLoginClick(e:MouseEvent):void {
			mb.addEventListener(MicroBlogEvent.LOGIN_RESULT, onLoginResult);// .
			mb.login();
			trace("trying to login");
		}
		private function onLoginResult(e:MicroBlogEvent):void {
			trace("login success.");
			/*mb.addEventListener(MicroBlogEvent.LOAD_FOLLOWERS_ID_LIST_RESULT, follwerIDListH);
			mb.addEventListener(MicroBlogErrorEvent.LOAD_FOLLOWERS_ID_LIST_ERROR, follwerIDListE);
			mb.loadFollowersIDList();
			*///
			/*trace("loadFollowerInfo");
			mb.addEventListener(MicroBlogEvent.LOAD_FOLLOWERS_INFO_RESULT, follwerInfoH);
			mb.addEventListener(MicroBlogErrorEvent.LOAD_FOLLOWERS_INFO_ERROR, follwerInfoE);
			mb.loadFollowersInfo();*/
			//
			trace("loadFollowerInfo");
			mb.addEventListener(MicroBlogEvent.LOAD_MENSIONS_RESULT, loadMentionsH);
			mb.addEventListener(MicroBlogErrorEvent.LOAD_MENSIONS_ERROR, loadMentionsE);
			mb.loadMentions();
			
				}
			private function loadMentionsE(e:MicroBlogErrorEvent):void {
			trace("error",e.message);
		}
		private function loadMentionsH(e:MicroBlogEvent):void {
				var  infos:Array = e.result as Array;
				trace("in follwerInfoH",e.result,infos.length);
				for (var i:int = 0; i < infos.length; i++) {
					var user:MicroBlogStatus = infos[i] as MicroBlogStatus;
					trace(user.id);
				}
		}
		private function follwerInfoE(e:MicroBlogErrorEvent):void {
			trace("error",e.message);
		}
		private function follwerInfoH(e:MicroBlogEvent):void {
				var  infos:Array = e.result as Array;
				trace("in follwerInfoH",e.result,infos.length);
				for (var i:int = 0; i < infos.length; i++) {
					var user:MicroBlogUser = infos[i] as MicroBlogUser;
					trace(user.name,user.id,user.city);
				}
		}
		private function follwerIDListE(e:MicroBlogErrorEvent):void {
			trace(e.message);
		}
		private function follwerIDListH(e:MicroBlogEvent):void {
			var  IDlists:Array = e.result as Array;
			trace("follwer id listst:", IDlists);
		}
		
	}
	
}