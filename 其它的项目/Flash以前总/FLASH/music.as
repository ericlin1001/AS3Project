package {
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class music extends Sprite {

		var sc:SoundChannel;
		public function music() {
			[Embed(source='月光.mp3',mimeType='audio/mpeg')]
			//[Embed(source='D:\Backup\我的文档\FLASH\月光.mp3',mimeType='application/octet-stream')];
			var Song:Class;
			var mysound:Sound=new Song();
			mysound.play
			stage.addEventListener(MouseEvent.MOUSE_DOWN ,onMouseDown);
		}
		private function onMouseDown(event:Event):void {

		}
	}
}