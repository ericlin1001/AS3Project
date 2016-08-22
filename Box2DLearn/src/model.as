package  
{
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	import flash.display.Sprite;
	import Box2D.Collision.b2RayCastInput;
	import Box2D.Collision.b2TimeOfImpact;
	import Box2D.Collision.b2TOIInput;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2EdgeChainDef;
	import Box2D.Collision.Shapes.b2EdgeShape;
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Math;
	import Box2D.Common.Math.b2Transform;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Contacts.b2EdgeAndCircleContact;
	import Box2D.Dynamics.Joints.b2DistanceJointDef;
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import flash.display.ActionScriptVersion;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author Ericlin
	 */
	public class model extends Sprite
	{
		private var actor:b2Body;
		private var world:b2World;
		private var worldScale:int = 30;
		private var bTrace:Boolean = true;
		private var 
		public function model() 
		{
			
			world = new b2World(new b2Vec2(0,10),true);
			debugDrawInit();
			initFloor();
			init();
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyRelease);
		}
		protected function initFloor():void {
			addFloor(300, 480, 600, 40);
			addFloor(300, 480, 600, 40);
		}
		private function onKeyPress(e:KeyboardEvent):void {
			switch(e.keyCode) {
			}
			trace("you press:" + e.keyCode);
		}
		public function addFloor(tx:Number, ty:Number, tw:Number, th:Number):void {
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			var boxDef:b2PolygonShape = new b2PolygonShape();
			var bodyDef:b2BodyDef = new b2BodyDef();
			boxDef.SetAsBox(tw * 0.5, th * 0.5);
			bodyDef.position.Set(tx, ty);
			fixtureDef.density = 0;
			fixtureDef.friction = 0;
			fixtureDef.shape = boxDef;
			world.CreateBody(bodyDef).CreateFixture(fixtureDef);
		}
		private function onKeyRelease(e:KeyboardEvent):void {
			switch(e.keyCode) {
				
			}
			trace("you release:" + e.keyCode);
		}
		private function init():void {
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			var boxDef:b2PolygonShape = new b2PolygonShape();
			var bodyDef:b2BodyDef = new b2BodyDef();
		}
		private function debugDrawInit():void {
			var dbgDraw:b2DebugDraw = new b2DebugDraw();
			var dbgSprite:Sprite = new Sprite();
			addChild(dbgSprite);
			dbgDraw.SetLineThickness(1);
			dbgDraw.SetDrawScale(worldScale);
			dbgDraw.SetFlags(b2DebugDraw.e_shapeBit|b2DebugDraw.e_jointBit);
			dbgDraw.SetFillAlpha(0.5);
			dbgDraw.SetSprite(dbgSprite);
			world.SetDebugDraw(dbgDraw);
		}
		private function update(e:Event = null):void {
			world.Step(1/30,10,10);
			world.ClearForces();
			//Todo:
			//
			world.DrawDebugData();
		}
	
		
	}
	
}