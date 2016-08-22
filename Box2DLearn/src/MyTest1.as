package  
{
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

	
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class MyTest1 extends Sprite	{
		private var world:b2World;

		public var car_body:b2Body;
		public var front_wheel:b2Body;
		public var rear_wheel:b2Body;
		public var front_motor:b2RevoluteJointDef = new b2RevoluteJointDef();
		public var rear_motor:b2RevoluteJointDef = new b2RevoluteJointDef();
		// this is new!!!
		public var fixtureDef:b2FixtureDef = new b2FixtureDef();
		public var rear_motor_added:b2RevoluteJoint;
		public var front_motor_added:b2RevoluteJoint;
		private var worldScale:int = 30;
		public function MyTest1() 
		{
			world = new b2World(new b2Vec2(0, 2), true);
			//
			debugSet();
			var body:b2Body;
			var bodydef:b2BodyDef = new b2BodyDef();
			var boxDef:b2PolygonShape = new b2PolygonShape();
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			
			//test
			var jointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
			jointDef.Initialize();
			var jointDistDef:b2DistanceJointDef;
			
			jointDef.collideConnected
			body.GetLocalPoint();
			var joint:b2Joint;
			joint.get
			//end test
			//first one
			bodydef.linearDamping = 0;//0-infinite
			fixtureDef.density = 1;
			fixtureDef.friction = 0.25;
			boxDef.SetAsBox(250, 15);
			bodydef.position.Set(250, 300);
			bodydef.angle = Math.PI * 0;
			fixtureDef.shape = boxDef;
			world.CreateBody(bodydef).CreateFixture(fixtureDef);
			//second
			fixtureDef.density = 1;//density is used to compute the mass
			/*fixture->SetDensity(5.0f);
			body->ResetMassData();
			*/
			bodydef.userData
			/*bodydef.type = b2Body.b2_staticBody;
			//bodydef.position.Set(
			
			fixtureDef.filter.categoryBits = 2
			fixtureDef.filter.categoryBits = 4;
			fixtureDef.filter.maskBits = 4;
			fixtureDef.filter.groupIndex = 4;
			fixtureDef.isSensor;
			var t:b2Math;
			
			var mass:b2MassData = new b2MassData();
			mass.I*/
			
			//fixtureDef.restitution = 0.5;//0-1
			//Restitution is used to make objects bounce. 
			//A value of zero means the ball won't bounce
			fixtureDef.friction = 1;//0-1friction = sqrtf(shape1->friction * shape2->friction);
			boxDef.SetAsBox(15, 50);
			bodydef.position.Set(20, 250);
			fixtureDef.shape = boxDef;
			world.CreateBody(bodydef).CreateFixture(fixtureDef);
			//third
			fixtureDef.density = 1;
			fixtureDef.friction = 1;
			boxDef.SetAsBox(15, 50);
			bodydef.position.Set(480, 250);
			fixtureDef.shape = boxDef;
			body = world.CreateBody(bodydef);
			body.CreateFixture(fixtureDef);
			//new dynamic body
			//dynamic
			bodydef.type = b2Body.b2_dynamicBody;
			bodydef.position.Set(250, 200);
			body = world.CreateBody(bodydef);
			boxDef.SetAsBox(10, 20);
			
			fixtureDef.shape = boxDef;
			fixtureDef.density = 1;
			fixtureDef.friction = 0.25;
			body.CreateFixture(fixtureDef);
			//convex
			var vertices:Array = new Array();
			var verx:int = 100;
			var very:int = -20;
			var verw:int = 30;
			var verh:int = 10;
			vertices.push(new b2Vec2(0+verx, 0+very));
			vertices.push(new b2Vec2(verw+verx, 0+very));
			vertices.push(new b2Vec2(verw+verx, verh+very));
			vertices.push(new b2Vec2(0+verx, verh+very));
			var polygon:b2PolygonShape = new b2PolygonShape();
			polygon.SetAsArray(vertices, vertices.length);
		
			//bodydef.type = b2Body.b2_dynamicBody;
			//bodydef.position.Set(250-5, -20);
			body = world.CreateBody(bodydef);
			fixtureDef.shape = polygon;
			fixtureDef.density = 1;
			fixtureDef.friction = 0.25;
			body.CreateFixture(fixtureDef);
			//
			//var vertices:Array = new Array();
			
			/*vertices = new Array();
			var fixture:b2Fixture = body.CreateFixture(fixtureDef);
			
			
			bodydef.type = b2Body.b2_dynamicBody;
			bodydef.position.Set(250-5, -20);
			body = world.CreateBody(bodydef);
			fixtureDef.shape = polygon;
			fixtureDef.density = 2;
			fixtureDef.friction = 0.3;
			body.CreateFixture(fixtureDef);*/
			/*
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(2, 2);
			var body:b2Body = world.CreateBody(bodyDef);
			
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.density = 0;
			fixtureDef.friction = 1;
			
			var boxDef:b2PolygonShape = new b2PolygonShape();
			boxDef.SetAsBox(1, 1);
			fixtureDef.shape = boxDef;
			body.CreateFixture(fixtureDef);
			*/
			//
			/*var body:b2Body;
			var bodyDef:b2BodyDef = new b2BodyDef();bodyDef.position.Set(250/30, 200/30);
			//
			var boxDef:b2PolygonShape = new b2PolygonShape();boxDef.SetAsBox(600/30, 20/30);// was var boxDef:b2PolygonDef = new b2PolygonDef();
			//
			var circleDef:b2CircleShape=new b2CircleShape(20/30);// was var circleDef:b2CircleDef = new b2CircleDef();
			var revoluteJointDef:b2RevoluteJointDef = new b2RevoluteJointDef();//new b2RevoluteJointDef();
			// adding the ground
			
			// this is new!!
			fixtureDef.shape=boxDef;
			fixtureDef.friction=1;// was boxDef.friction=1;
			fixtureDef.density=1;// was boxDef.density=0;
			body=world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);// was body.CreateShape(boxDef);
			// remove: body.SetMassFromShapes();
			*//*bodyDef.position.Set(0/30, 200/30);
			boxDef.SetAsBox(50/30, 50/30);
			fixtureDef.shape=boxDef;
			fixtureDef.friction=1;// was boxDef.friction=1;
			fixtureDef.density=1;// was boxDef.density=0;
			body=world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);// was body.CreateShape(boxDef);
			// remove: body.SetMassFromShapes();
			bodyDef.position.Set(500/30, 200/30);
			boxDef.SetAsBox(50/30, 50/30);
			// this is new!!
			fixtureDef.shape=boxDef;
			fixtureDef.friction=1;// was boxDef.friction=1;
			fixtureDef.density=1;// was boxDef.density=0;
			body=world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);// was body.CreateShape(boxDef);
			// remove: body.SetMassFromShapes();
			// adding car body
			bodyDef.position.Set(250/30, 90/30);
			// this is new!!
			bodyDef.type=b2Body.b2_dynamicBody;
			boxDef.SetAsBox(50/30, 10/30);
			// this is new!!
			fixtureDef.shape=boxDef;
			fixtureDef.density=1;// was boxDef.density=1;
			fixtureDef.friction=1;// was boxDef.friction=1;
			fixtureDef.restitution=0.1;// was boxDef.restitution=0.1;
			car_body=world.CreateBody(bodyDef);
			car_body.CreateFixture(fixtureDef);// was body.CreateShape(boxDef);
			// remove: car_body.SetMassFromShapes();
			// adding wheels
			// remove: circleDef.radius=20/30;
			fixtureDef.density=1;// was circleDef.density=1;
			fixtureDef.friction=5;// was circleDef.friction=5;
			fixtureDef.density=0.1;// was circleDef.restitution=0.1;
			// this is new!!
			fixtureDef.shape=circleDef;
			// front wheel
			bodyDef.allowSleep=false;
			bodyDef.position.Set(car_body.GetWorldCenter().x + 40/30, car_body.GetWorldCenter().y);
			front_wheel=world.CreateBody(bodyDef);
			front_wheel.CreateFixture(fixtureDef);// was front_wheel.CreateShape(circleDef);
			// remove: front_wheel.SetMassFromShapes();
			// rear wheel
			bodyDef.position.Set(car_body.GetWorldCenter().x - 40/30, car_body.GetWorldCenter().y);
			rear_wheel=world.CreateBody(bodyDef);
			rear_wheel.CreateFixture(fixtureDef);// was rear_wheel.CreateShape(circleDef);
			// remove: rear_wheel.SetMassFromShapes();
			// front joint
			front_motor.enableMotor=true;
			front_motor.maxMotorTorque=10;
			front_motor.Initialize(car_body, front_wheel, front_wheel.GetWorldCenter());
			front_motor_added=world.CreateJoint(front_motor) as b2RevoluteJoint;
			// rear joint
			rear_motor.enableMotor=true;
			rear_motor.maxMotorTorque=1;
			rear_motor.Initialize(car_body, rear_wheel, rear_wheel.GetWorldCenter());
			rear_motor_added=world.CreateJoint(rear_motor) as b2RevoluteJoint;
			*/
			//
			
			addEventListener(Event.ENTER_FRAME, update);
			
		}
		private function debugSet():void {
			/*var m_sprite:Sprite=new Sprite();addChild(m_sprite);
			var dbgDraw:b2DebugDraw = new b2DebugDraw();
			var dbgSprite:Sprite = new Sprite();
			m_sprite.addChild(dbgSprite);
			dbgDraw.SetSprite(m_sprite); // was dbgDraw.m_sprite=m_sprite;
			dbgDraw.SetDrawScale(30); // was dbgDraw.m_drawScale=30;
			//dbgDraw.SetAlpha(1); // was dbgDraw.m_alpha=1;
			dbgDraw.SetFillAlpha(0.5); // was dbgDraw.m_fillAlpha=0.5;
			dbgDraw.SetLineThickness(1); // was dbgDraw.m_lineThickness=1;
			dbgDraw.SetFlags(b2DebugDraw.e_shapeBit); // was dbgDraw.m_drawFlags=b2DebugDraw.e_shapeBit;
			world.SetDebugDraw(dbgDraw);*/
			var mSprite:Sprite = new Sprite();
			addChild(mSprite);
			var dbgSprite:Sprite = new Sprite();
			mSprite.addChild(dbgSprite);
			var dbgDraw:b2DebugDraw = new b2DebugDraw();
			dbgDraw.SetSprite(mSprite);
			dbgDraw.SetDrawScale(1);
			dbgDraw.SetFlags(b2DebugDraw.e_shapeBit);
			dbgDraw.SetFillAlpha(0.5);
			dbgDraw.SetLineThickness(1);
			world.SetDebugDraw(dbgDraw);
		}
		private function update(e:Event):void {
			world.Step(60, 10,10);//60,6,3
			world.ClearForces();
			world.DrawDebugData();
		}
	}
	
}