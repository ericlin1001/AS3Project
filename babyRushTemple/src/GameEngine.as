package  
{
	import Box2D.Collision.b2DynamicTreeBroadPhase;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class GameEngine
	{
		private var numRows:int = 29;
		private var numCols:int = 39;
		private var size:int = 15;
		private var canva:Sprite;
		public var width:int;
		public var height:int;
		public var world:b2World;
		public var worldScale:int = 30;
		public var halfSize:Number =size*0.5;
		public var inv_worldScale:Number = 1 / worldScale;
		public var actor:b2Body;
		public var maxSpeed:Number = 1000 * inv_worldScale;
		public var force:Number =70*inv_worldScale;
		public function GameEngine(tcanva:Sprite,trow:int,tcol:int) 
		{
			canva = tcanva;
			numRows = trow;
			numCols = tcol;
			width = numCols * size;
			height = numRows * size;
			//
			world = new b2World(new b2Vec2(0, 10), true);
			debugDrawInit();
			//addBox(1, 1, 1);
			
		}
		public function createActor():void {
			var bodydef:b2BodyDef = new b2BodyDef();
			var boxDef:b2PolygonShape = new b2PolygonShape();
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			bodydef.type = b2Body.b2_dynamicBody;
			
			bodydef.fixedRotation = true;
			bodydef.position.Set(iToN(3), iToN(3));
			actor = world.CreateBody(bodydef); 
			/*var vertics:Array = new Array();
			vertics.push(new b2Vec2(0,-halfSize*3));
			vertics.push(new b2Vec2(halfSize,-size));
			vertics.push(new b2Vec2(halfSize,0));
			vertics.push(new b2Vec2(halfSize / 3, halfSize));
			//
			vertics.push(new b2Vec2( -halfSize / 3, halfSize));
			vertics.push(new b2Vec2(-halfSize,0));
			vertics.push(new b2Vec2(-halfSize,-size));
			vertics.push(new b2Vec2(0,-halfSize*3));
			boxDef.SetAsArray(vertics,vertics.length);*/
			boxDef.SetAsBox(1,1);
			//
			fixtureDef.friction = 1;
			fixtureDef.density = 1;
			fixtureDef.shape = boxDef;
			actor.CreateFixture(fixtureDef);
			trace("create an actor");
		}
		public function start():void {
			
		}
		public function test():void {
			createActor();
			
		}
		public function actorLeft():void {
		
			//actor.SetLinearVelocity(-speed);
		}
		public function actorRight():void
		{
			trace("actorright()");
			if(Math.abs(actor.GetLinearVelocity().x)< maxSpeed){
				actor.ApplyForce(new b2Vec2(force, 0), new b2Vec2());;
				trace("apply right force.");
			}
		}
		public function iToN( n:int):Number {
			return (n * size + halfSize)*inv_worldScale;//point to the center of the grid.
		}
		public function addBackGround(bk:Sprite):void {
			canva.addChildAt(bk, 0);
		}
		public function addBox(row:int, col:int, type:int=1):void {
			//trace("addBox", row, col, type);
			//var body:b2Body;
			var bodydef:b2BodyDef = new b2BodyDef();
			var boxDef:b2PolygonShape = new b2PolygonShape();
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			switch(type) {
				case Map.MAP_TYPE_ONEBOX:
					bodydef.position.Set(iToN(col), iToN(row));
					boxDef.SetAsBox(halfSize*inv_worldScale,halfSize*inv_worldScale);
				break;
				default:
				return ;
				break;
			}
			fixtureDef.friction = 0;
			fixtureDef.density = 0;
			fixtureDef.shape = boxDef;
			bodydef.type = b2Body.b2_staticBody;
			world.CreateBody(bodydef).CreateFixture(fixtureDef);
		}
		public function loadMap(map:Map):void {
			//
			var mapData:Array = map.getMapData();
			for (var row:int = 0; row < numRows; row++) {
				for (var col:int = 0; col < numCols; col++) {
					addBox(row, col, mapData[row][col]);
				}
			}
		}
		private function debugDrawInit():void {
			var dbgDraw:b2DebugDraw = new b2DebugDraw();
			var mySprite:Sprite = new Sprite();
			canva.addChild(mySprite);
			dbgDraw.SetLineThickness(1);
			dbgDraw.SetDrawScale(worldScale);
			dbgDraw.SetFlags(b2DebugDraw.e_shapeBit|b2DebugDraw.e_jointBit);
			dbgDraw.SetFillAlpha(0.5);
			dbgDraw.SetSprite(mySprite);
			world.SetDebugDraw(dbgDraw);
		}
		public function update(e:Event = null):void {
			world.Step(1/30,10,10);
			world.ClearForces();
			world.DrawDebugData();
			
		}
		
	}
	
}