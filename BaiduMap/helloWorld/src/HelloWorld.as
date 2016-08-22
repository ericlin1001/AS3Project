package{
    import baidu.map.basetype.Size;
	import baidu.map.control.base.Navigator;
	import baidu.map.control.base.Overview;
	import baidu.map.control.base.Ruler;
	import baidu.map.control.base.Scaler;
    import baidu.map.core.Map;
    import baidu.map.basetype.LngLat;
    import baidu.map.layer.Layer;
    import baidu.map.layer.RasterLayer;
     
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
     
    /**
    * Demo:Hello World!
    */
    public class HelloWorld extends Sprite
    {
		public function HelloWorld()
		{
			// 创建一个大小为600*400的Map对象
			var map:Map = new Map(new Size(600, 400));
			addChild(map);
			// 初始化Map的中心点和显示级别
			map.centerAndZoom(new LngLat(116.404, 39.915),12);
			// 添加底图
			var layer:Layer = new RasterLayer("BaiduMap", map);
			map.addLayer(layer);
			//
			var nav:Navigator = new Navigator(map);
			map.addControl(nav);
			var overview:Overview = new Overview(map);
			map.addControl(overview);
			var scaler:Scaler = new Scaler(map);
			map.addControl(scaler);
			var ruler:Ruler = new Ruler(map);
			map.addControl(ruler);
			ruler.offset = new Size(100, -200);
			
		}
		
    }
}