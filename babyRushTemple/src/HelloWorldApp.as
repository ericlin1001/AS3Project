package  
{
        import Box2D.Collision.*;
		import Box2D.Common.*;
		import Box2D.Common.Math.*;
		import Box2D.Dynamics.*;
		import Box2D.Dynamics.Contacts.*;
		import Box2D.Dynamics.Controllers.*;
		
        import flash.display.Sprite;
        import flash.events.Event;
        import flash.events.KeyboardEvent;
        import flash.events.MouseEvent;
        /**
     * ...
     * @description    HelloWorld
     * @author    ispooky
     * @date    2010.11.15
     * 
     * @see http://ispooky.cnblogs.com
     */
    
        public class HelloWorldApp extends Sprite
        {
                //缩放比例
                public static const RATIO :int        = 30;
                //时间步
                public static const ITERATIONS     :int         = 30;
                //迭代次数
                public static const TIME_STEP:Number = 1 / 30;
                
                //物理空间
                private static var world:b2World;
                //Debug绘制容器
                private static var spriteToDrawOn                :Sprite;
                
                public function HelloWorldApp() 
                {
                        if (stage) init();
                        else addEventListener(Event.ADDED_TO_STAGE, init);
                }
                
                private function init(e:Event = null):void 
                {
                        removeEventListener(Event.ADDED_TO_STAGE, init);
                        
                        initB2D();
                        stage.addEventListener(MouseEvent.CLICK, onClickHandler);
                        stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownHandler);
                }
                
                private function onKeyDownHandler(e:KeyboardEvent):void 
                {
                        if (e.keyCode == 82/*R*/)
                        {
                                /////////////////////////////
                                // 销毁Body
                                /////////////////////////////
                                for (var bb:b2Body = world.m_bodyList; bb; bb = bb.m_next)
                                {
                                        if (!bb.IsStatic()) { world.DestroyBody(bb) };
                                }
                        }
                }
                
                private function onClickHandler(e:MouseEvent):void 
                {
                        if (world.GetBodyCount() > 30) return;
                        createBoxs();
                }
                
                private function initB2D():void
                {
                        addEventListener(Event.ENTER_FRAME, onLoopHandler, false, 0, true);
                        createWorld();
                        showDebug();
                        createGrounds();
                        createBoxs();
                }
                
                private function createBoxs():void
                {
                        var bodyDef:b2BodyDef;
                        var boxDef:b2PolygonDef;
                        var body:b2Body;
                        
                        bodyDef = new b2BodyDef();
                        bodyDef.position.Set(((int(Math.random() * 200) - 100) + 275.0) / RATIO, -100.0 / RATIO);
                        boxDef = new b2PolygonDef();
                        boxDef.SetAsBox(int((Math.random() * 20) + 20) / RATIO / 2, (int(Math.random() * 20) + 20) / RATIO / 2);
                        boxDef.density = 1;
                        boxDef.friction = 0.4;
                        boxDef.restitution = 0.1;
                        
                        body = world.CreateBody(bodyDef);
                        body.CreateShape(boxDef);
                        body.SetMassFromShapes();
                }
                
                private function createGrounds():void
                {
                        var bodyDef:b2BodyDef;
                        var boxDef:b2PolygonDef;
                        var body:b2Body;
                        
                        //刚体定义
                        bodyDef = new b2BodyDef();
                        //设置位置
                        bodyDef.position.Set(275.0 / RATIO, 390.0 / RATIO);
                        //形状定义
                        boxDef = new b2PolygonDef();
                        //设置高宽
                        boxDef.SetAsBox(550.0 / RATIO / 2, 20.0 / RATIO / 2);
                        //密度，0为静态物
                        boxDef.density = 0;
                        //摩擦力
                        boxDef.friction = 0.3;
                        //弹力
                        boxDef.restitution = 0.2;
                        
                        body = world.CreateBody(bodyDef);
                        body.CreateShape(boxDef);
                        //计算质量，因此处为静态物，所以不需计算
                        //body.SetMassFromShapes();
                }
                
                private function showDebug():void
                {
                        spriteToDrawOn = new Sprite();
                        addChild(spriteToDrawOn);
                        var dbgDraw:b2DebugDraw = new b2DebugDraw();
                        //绘制图形
                        dbgDraw.m_sprite = spriteToDrawOn;
                        //缩放比例
                        dbgDraw.m_drawScale = RATIO;
                        //填充线的颜色透明度
                        dbgDraw.m_alpha = 1.0;
                        //填充区域的颜色透明度
                        dbgDraw.m_fillAlpha = 0.5;
                        //线型粗细
                        dbgDraw.m_lineThickness = 1.0;
                        //绘制图形位
                        dbgDraw.m_drawFlags = b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit;
                        
                        world.SetDebugDraw(dbgDraw);
                }
                
                private function createWorld():void
                {
                        //边界
                        var worldAABB:b2AABB = new b2AABB();
                        worldAABB.lowerBound.Set( -3000 / RATIO, -3000 / RATIO);
                        worldAABB.upperBound.Set(3000 / RATIO, 3000 / RATIO);
                        //重力
                        var gravity:b2Vec2 = new b2Vec2(0, 10);
                        //允许休眠
                        var doSleep:Boolean = true;
                        
                        world = new b2World(worldAABB, gravity, doSleep);
                }
                
                private function onLoopHandler(e:Event):void 
                {
                        if (world == null) return;
                        //刷新物理空间
                        world.Step(TIME_STEP, ITERATIONS);
                }
                
        }

}