package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.Joints.*;
	public class car extends Sprite {
		public var world:b2World;
		public var car_body:b2Body;
		public var front_wheel:b2Body;
		public var rear_wheel:b2Body;
		public var front_motor:b2RevoluteJointDef = new b2RevoluteJointDef();
		public var rear_motor:b2RevoluteJointDef = new b2RevoluteJointDef();
		// this is new!!!
		public var fixtureDef:b2FixtureDef = new b2FixtureDef();
		public var rear_motor_added:b2RevoluteJoint;
		public var front_motor_added:b2RevoluteJoint;
		public function car():void {
			// world setup
			/*var worldAABB:b2AABB = new b2AABB();
			worldAABB.lowerBound.Set(-100, -100);
			worldAABB.upperBound.Set(100, 100);*/
			world=new b2World(new b2Vec2(0,10.0),true);// was world=new b2World(worldAABB,new b2Vec2(0,10.0),true);
			debug_draw();
			// variables used for bodies and motors
			var body:b2Body;
			var bodyDef:b2BodyDef= new b2BodyDef();
			var boxDef:b2PolygonShape = new b2PolygonShape();// was var boxDef:b2PolygonDef = new b2PolygonDef();
			var circleDef:b2CircleShape=new b2CircleShape(20/30);// was var circleDef:b2CircleDef = new b2CircleDef();
			var revoluteJointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
			// adding the ground
			bodyDef.position.Set(250/30, 200/30);
			boxDef.SetAsBox(600/30, 20/30);
			// this is new!!
			fixtureDef.shape=boxDef;
			fixtureDef.friction=1;// was boxDef.friction=1;
			fixtureDef.density=1;// was boxDef.density=0;
			body=world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);// was body.CreateShape(boxDef);
			// remove: body.SetMassFromShapes();
			bodyDef.position.Set(0/30, 200/30);
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
			//
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, key_down);
		}
		public function key_down(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case 39 :
					rear_motor_added.SetMotorSpeed(10);
					front_motor_added.SetMotorSpeed(10);
					break;
				case 37 :
					rear_motor_added.SetMotorSpeed(-10);
					front_motor_added.SetMotorSpeed(-10);
					break;
			}
		//0x80FF00
		}
		public function debug_draw():void {
			var m_sprite:Sprite;
			m_sprite = new Sprite();
			addChild(m_sprite);
			var dbgDraw:b2DebugDraw = new b2DebugDraw();
			var dbgSprite:Sprite = new Sprite();
			m_sprite.addChild(dbgSprite);
			dbgDraw.SetSprite(m_sprite); // was dbgDraw.m_sprite=m_sprite;
			dbgDraw.SetDrawScale(30); // was dbgDraw.m_drawScale=30;
			//dbgDraw.SetAlpha(1); // was dbgDraw.m_alpha=1;
			dbgDraw.SetFillAlpha(0.5); // was dbgDraw.m_fillAlpha=0.5;
			dbgDraw.SetLineThickness(1); // was dbgDraw.m_lineThickness=1;
			dbgDraw.SetFlags(b2DebugDraw.e_shapeBit); // was dbgDraw.m_drawFlags=b2DebugDraw.e_shapeBit;
			world.SetDebugDraw(dbgDraw);
		}
		public function update(e : Event):void {
			world.Step(1/30,10,10);// was world.Step(1/30, 10);
			// this is new!
			world.ClearForces() ;
			// this is new!!
			world.DrawDebugData();
		}
	}
}