package  
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.b2PulleyJointDef;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class Hello extends Sprite
	{
		public var world:b2World=new b2World(new b2Vec2(0,10.0),true);
		public var world_scale:int=30;

		public function Hello () 
		{
			/*var gravity:b2Vec2 = new (0, -10);
			var doSleep:Boolean = true;
			world = new b2World(gravity, doSleep);
			var groundBodyDef:b2BodyDef = new b2BodyDef();
			groundBodyDef.position.Set(0, -10);
			var groundBody:b2Body = world.CreateBody(groundBodyDef);
			var groundBox:b2PolygonShape = new b2PolygonShape();
			groundBox.SetAsBox(50, 10);
			//groundBody.CreateFixture(groundBox);
			//
			var bodyDef:b2BodyDef = new b2BodyDef();
			//bodyDef.type = b2_dynamicBody;*/
			//debug_draw();
   debug_draw();

                    draw_box(250,300,500,100,false);
 
                       draw_box(250,100,100,100,true);


			addEventListener(Event.ENTER_FRAME, update);
		}
		public function debug_draw():void {
			var debug_draw:b2DebugDraw = new b2DebugDraw();
                      var debug_sprite:Sprite = new Sprite();
                       addChild(debug_sprite);
                        debug_draw.SetSprite(debug_sprite);
                        debug_draw.SetDrawScale(world_scale);
                      debug_draw.SetFlags(b2DebugDraw.e_shapeBit);
 
                      world.SetDebugDraw(debug_draw);
 
               }


		public function update(e : Event):void {
                      world.Step(1/30,10,10);
                     world.ClearForces();
 
                    world.DrawDebugData();
 
               }
public function draw_box(px:Number,py:Number,w:Number,h:Number,d:Boolean):void {
                       var my_body:b2BodyDef= new b2BodyDef();

                      my_body.position.Set(px / world_scale, py / world_scale);                        
					  if (d) {
						  
                               my_body.type=b2Body.b2_dynamicBody;                       }                         var my_box:b2PolygonShape = new b2PolygonShape();
                       my_box.SetAsBox(w/2/world_scale, h/2/world_scale);
                        var my_fixture:b2FixtureDef = new b2FixtureDef();
					
                       my_fixture.shape=my_box;
 
                     var world_body:b2Body = world.CreateBody(my_body); 
					 world_body.CreateFixture(my_fixture);
 
          }



	}
	
}