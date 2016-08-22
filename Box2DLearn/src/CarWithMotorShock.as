package  
{
	import adobe.utils.CustomActions;
	import Box2D.Collision.b2BroadPhase;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.b2PrismaticJoint;
	import Box2D.Dynamics.Joints.b2PrismaticJointDef;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class CarWithMotorShock extends Sprite
	{
		private var world:b2World;
		private var worldScale:int = 30;
		private var carBody:b2Body;
		private var rearWheelJoint:b2RevoluteJoint;
		private var frontWheelJoint:b2RevoluteJoint;
		private var left:Boolean = false;
		private var right:Boolean = false;
		private var motorSpeed:Number = 0;
		private var frontAxlePriJoint:b2PrismaticJoint;
		private var rearAxlePriJoint:b2PrismaticJoint;
		public function CarWithMotorShock() 
		{
			
			world = new b2World(new b2Vec2(0,10),true);
			debugDrawInit();
			//
			initFloor();
			init();
			//
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyRelease);
		}
		private function onKeyPress(e:KeyboardEvent):void {
			switch(e.keyCode) {
				case 37:
				left = true;
				break;
				case 39:
				right = true;
				break;
				
			}
		}
		private function onKeyRelease(e:KeyboardEvent):void {
			switch(e.keyCode) {
				case 37:
				left = false;
				break;
				case 39:
				right = false;
				break;
			}
		}
		private function init():void {
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			var boxDef:b2PolygonShape = new b2PolygonShape();
			var bodyDef:b2BodyDef = new b2BodyDef();
			//car
			boxDef.SetAsBox(120 / worldScale, 20/worldScale);
			bodyDef.position.Set(320/worldScale, 100/worldScale);
			bodyDef.type = b2Body.b2_dynamicBody;
			fixtureDef.density = 5;
			fixtureDef.friction = 3;
			fixtureDef.restitution = 0.3;
			fixtureDef.filter.groupIndex = -1;
			fixtureDef.shape = boxDef;
			carBody = world.CreateBody(bodyDef);
			carBody.CreateFixture(fixtureDef);
			//trunk
			var trunkShape:b2PolygonShape = new b2PolygonShape();
			var trunkFixture:b2FixtureDef = new b2FixtureDef();
			trunkShape.SetAsOrientedBox(40 / worldScale, 40/worldScale,new b2Vec2(-80/worldScale,-60/worldScale));;
			trunkFixture.density = 1;
			trunkFixture.friction = 3;
			trunkFixture.restitution = 0.3;
			trunkFixture.filter.groupIndex = -1;
			trunkFixture.shape = trunkShape;
			//the hood
			var hoodShape:b2PolygonShape = new b2PolygonShape();
			var cartVector:Vector.<b2Vec2> = new Vector.<b2Vec2>();
			cartVector[0] = new b2Vec2( -40 / worldScale, -20 / worldScale);
			cartVector[1]=new b2Vec2(-40/worldScale,-100/worldScale);
			cartVector[2]=new b2Vec2(120/worldScale,-20/worldScale);
			hoodShape.SetAsVector(cartVector);
			var hoodFixture:b2FixtureDef = new b2FixtureDef();
			hoodFixture.density = 1;
			hoodFixture.friction = 3;
			hoodFixture.restitution = 0.3;
			hoodFixture.filter.groupIndex = -1;
			hoodFixture.shape = hoodShape;
			//make all together
			carBody.CreateFixture(trunkFixture);
			carBody.CreateFixture(hoodFixture);
			//
			//axles
			var axleShape:b2PolygonShape = new b2PolygonShape();
			axleShape.SetAsBox(20 / worldScale, 20 / worldScale);
			// fixture
			var axleFixture:b2FixtureDef = new b2FixtureDef();
			axleFixture.density=0.5;
			axleFixture.friction=3;
			axleFixture.restitution=0.3;
			axleFixture.shape=axleShape;
			axleFixture.filter.groupIndex=-1;
			// body definition
			var axleBodyDef:b2BodyDef = new b2BodyDef();
			axleBodyDef.type=b2Body.b2_dynamicBody;
			// the rear axle itself
			axleBodyDef.position.Set(carBody.GetWorldCenter().x-(80/worldScale),carBody.GetWorldCenter().y+(65/worldScale));
			var rearAxle:b2Body=world.CreateBody(axleBodyDef);
			rearAxle.CreateFixture(axleFixture);
			// the front axle itself
			axleBodyDef.position.Set(carBody.GetWorldCenter().x+(90/worldScale),carBody.GetWorldCenter().y+(65/worldScale));
			var frontAxle:b2Body=world.CreateBody(axleBodyDef);
			frontAxle.CreateFixture(axleFixture);
			// ************************ THE WHEELS ************************ //
			// shape
			var wheelShape:b2CircleShape=new b2CircleShape(40/worldScale);
			// fixture
			var wheelFixture:b2FixtureDef = new b2FixtureDef();
			wheelFixture.density=1;
			wheelFixture.friction=3;
			wheelFixture.restitution=0.1;
			wheelFixture.filter.groupIndex=-1;
			wheelFixture.shape=wheelShape;
			// body definition
			var wheelBodyDef:b2BodyDef = new b2BodyDef();
			wheelBodyDef.type=b2Body.b2_dynamicBody;
			// the real wheel itself
			wheelBodyDef.position.Set(carBody.GetWorldCenter().x-(80/worldScale),carBody.GetWorldCenter().y+(65/worldScale));
			var rearWheel:b2Body=world.CreateBody(wheelBodyDef);
			rearWheel.CreateFixture(wheelFixture);
			// the front wheel itself
			wheelBodyDef.position.Set(carBody.GetWorldCenter().x+(90/worldScale),carBody.GetWorldCenter().y+(65/worldScale));
			var frontWheel:b2Body=world.CreateBody(wheelBodyDef);
			frontWheel.CreateFixture(wheelFixture);
			//
			var rearWheelJointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
			rearWheelJointDef.Initialize(rearWheel, rearAxle, rearWheel.GetWorldCenter());
			rearWheelJointDef.enableMotor = true;
			rearWheelJointDef.maxMotorTorque = 10000;
			rearWheelJoint = world.CreateJoint(rearWheelJointDef) as b2RevoluteJoint;
			var frontWheelJointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
			frontWheelJointDef.Initialize(frontWheel, frontAxle, frontWheel.GetWorldCenter());
			frontWheelJointDef.enableMotor = true;
			frontWheelJointDef.maxMotorTorque = 10000;
			frontWheelJoint = world.CreateJoint(frontWheelJointDef) as b2RevoluteJoint;
			//
			// ************************ PRISMATIC JOINTS ************************ 
			//  definition
			var axlePrismaticJointDef:b2PrismaticJointDef=new b2PrismaticJointDef();
			axlePrismaticJointDef.lowerTranslation=-20/worldScale;
			axlePrismaticJointDef.upperTranslation=5/worldScale;
			axlePrismaticJointDef.enableLimit=true;
			axlePrismaticJointDef.enableMotor=true;
			// front axle
			axlePrismaticJointDef.Initialize(carBody,frontAxle,frontAxle.GetWorldCenter(),new b2Vec2(0,1));
			frontAxlePriJoint=world.CreateJoint(axlePrismaticJointDef) as b2PrismaticJoint;
			// rear axle
			axlePrismaticJointDef.Initialize(carBody,rearAxle,rearAxle.GetWorldCenter(),new b2Vec2(0,1));
			rearAxlePriJoint=world.CreateJoint(axlePrismaticJointDef) as b2PrismaticJoint;
			

		}
		private function initFloor():void {
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			var boxDef:b2PolygonShape = new b2PolygonShape();
			var bodyDef:b2BodyDef = new b2BodyDef();
			//below create floor.
			boxDef.SetAsBox(640 / worldScale, 10/worldScale);
			bodyDef.position.Set(320/worldScale, 480/worldScale);
			fixtureDef.density = 0;
			fixtureDef.friction = 3;
			fixtureDef.restitution = 0;
			fixtureDef.shape = boxDef;
			world.CreateBody(bodyDef).CreateFixture(fixtureDef);
			//
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
			if (left) {
				motorSpeed += 0.5;
			}
			if (right) {
				motorSpeed -= 0.5;
			}
			motorSpeed *= 0.99;
			if (motorSpeed > 100) {
				motorSpeed = 100;
			}
			rearWheelJoint.SetMotorSpeed(motorSpeed);
			frontWheelJoint.SetMotorSpeed(motorSpeed);
			//
			/*frontAxlePriJoint.SetMaxMotorForce(Math.abs(600*frontAxlePriJoint.GetJointTranslation()));
			frontAxlePriJoint.SetMotorSpeed((frontAxlePriJoint.GetMotorSpeed()-2*frontAxlePriJoint.GetJointTranslation()));
			rearAxlePriJoint.SetMaxMotorForce(Math.abs(600*rearAxlePriJoint.GetJointTranslation()));
			rearAxlePriJoint.SetMotorSpeed((rearAxlePriJoint.GetMotorSpeed()-2*rearAxlePriJoint.GetJointTranslation()));
			*/
			//
			world.Step(1/30,10,10);
			world.ClearForces();
			//
	
	
			//
			world.DrawDebugData();
		}
	}
	
}