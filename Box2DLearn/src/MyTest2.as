package  
{

	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.b2MouseJointDef;
	import Box2D.Dynamics.Joints.b2PulleyJointDef;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ericlin
	 */
	public class MyTest2 extends Sprite
	{
		private var world:b2World;
		private var motor:b2RevoluteJoint;
		private var mouseBody:b2Body;
		public function MyTest2() 
		{
			world = new b2World(new b2Vec2(0,5),true);
			debugDrawInit();
			//
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			var boxDef:b2PolygonShape = new b2PolygonShape();
			var bodyDef:b2BodyDef = new b2BodyDef();
			//below create ground.
			//middle
			boxDef.SetAsBox(10, 10);
			bodyDef.position.Set(0, 0);
			bodyDef.type = b2Body.b2_dynamicBody;
			fixtureDef.shape = boxDef;
			mouseBody = world.CreateBody(bodyDef);
			mouseBody.CreateFixture(fixtureDef);
			//
			//
			init();
			//
			addEventListener(Event.ENTER_FRAME, update);
		}
		private function init():void {
			var body:b2Body;
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			var boxDef:b2PolygonShape = new b2PolygonShape();
			var bodyDef:b2BodyDef = new b2BodyDef();
			//below create ground.
			//middle
			boxDef.SetAsBox(250, 25);
			bodyDef.position.Set(250, 425);
			bodyDef.type = b2Body.b2_staticBody;
			fixtureDef.shape = boxDef;
			fixtureDef.friction = 0.5;
			fixtureDef.density = 0;
			world.CreateBody(bodyDef).CreateFixture(fixtureDef);
			//left
			bodyDef.position.Set(0, 425);
			boxDef.SetAsBox(25, 50);
			bodyDef.type = b2Body.b2_staticBody;
			fixtureDef.shape = boxDef;
			fixtureDef.friction = 0.2;
			fixtureDef.density = 0;
			world.CreateBody(bodyDef).CreateFixture(fixtureDef);
			//right
			bodyDef.position.Set(500, 425);
			boxDef.SetAsBox(25, 50);
			bodyDef.type = b2Body.b2_staticBody;
			fixtureDef.shape = boxDef;
			fixtureDef.friction = 0.2;
			fixtureDef.density = 0;
			world.CreateBody(bodyDef).CreateFixture(fixtureDef);
			//end create ground.
			
			//create can move box
			var vertices:Array;
			var bothY:int = 200;
			//bodyA:triangle
			vertices = new Array();
			var triangleL:int = 25;
			vertices.push(new b2Vec2(0, -triangleL));
			vertices.push(new b2Vec2(triangleL, 0));
			vertices.push(new b2Vec2(-triangleL,0));
			bodyDef.position.Set(250, 400-bothY);
			boxDef.SetAsArray(vertices, vertices.length);
			bodyDef.type = b2Body.b2_staticBody;
			fixtureDef.shape = boxDef;
			fixtureDef.friction = 0.2;
			fixtureDef.density = 1;
			var bodyA:b2Body = world.CreateBody(bodyDef);
			bodyA.CreateFixture(fixtureDef);
			//BodyB:square.
			vertices = new Array();
			var squareL:int = 30;
			vertices.push(new b2Vec2(0, -squareL));
			vertices.push(new b2Vec2(squareL, 0));
			vertices.push(new b2Vec2( 0, squareL));
			vertices.push(new b2Vec2( -squareL, 0));
			bodyDef.position.Set(260, 400-bothY-triangleL-squareL+20);
			boxDef.SetAsArray(vertices, vertices.length);
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyDef.angle = Math.PI * 1/6;
			fixtureDef.shape = boxDef;
			fixtureDef.friction = 0.2;
			fixtureDef.density = 1;
			//bodyDef.angle = Math.PI*0.25;//Math.PI / 18;
			var bodyB:b2Body = world.CreateBody(bodyDef);
			bodyB.CreateFixture(fixtureDef);
			//end define body
			bothY = 200;
			bodyA.SetPosition(new b2Vec2(250, bothY));
			bodyB.SetPosition(new b2Vec2(250+20, bothY-23));
			//create joint between A and B
			var jointMouse:b2MouseJointDef = new b2MouseJointDef();
			jointMouse.maxForce = 10;
			jointMouse.target.Set(0, 0);
			jointMouse.bodyA = mouseBody;
			jointMouse.bodyB = bodyB;
			world.CreateJoint(jointMouse);
			//end create joint
			/*var jointRevoluteDef:b2RevoluteJointDef = new b2RevoluteJointDef();
			jointRevoluteDef.Initialize(bodyA, bodyB, bodyA.GetWorldCenter());// new b2Vec2(250, 400 -bothY- triangleL));
			*//*jointRevoluteDef.lowerAngle = -Math.PI*0.5;
			jointRevoluteDef.upperAngle = Math.PI * 0.25;
			jointRevoluteDef.enableLimit = false;
			jointRevoluteDef.maxMotorTorque = 1;
			jointRevoluteDef.motorSpeed =1;
			jointRevoluteDef.enableMotor = true;*/
			//motor=world.CreateJoint(jointRevoluteDef)as b2RevoluteJoint;
			
			//
			/*var jointPullyDef:b2PulleyJointDef = new b2PulleyJointDef();
			var groundA:b2Vec2 = new b2Vec2(bodyA.GetPosition().x, bothY - 100);
			var groundB:b2Vec2 = new b2Vec2(bodyB.GetPosition().x, bothY - 100);
			var ratio:Number = 1;
			jointPullyDef.Initialize(bodyA, bodyB, groundA, groundB, bodyA.GetWorldCenter(), bodyB.GetWorldCenter(), ratio);
			world.CreateJoint(jointPullyDef);*/
		}
		
		private function debugDrawInit():void {
			var dbgDraw:b2DebugDraw = new b2DebugDraw();
			var mySprite:Sprite = new Sprite();
			addChild(mySprite);
			dbgDraw.SetLineThickness(1);
			dbgDraw.SetDrawScale(1);
			dbgDraw.SetFlags(b2DebugDraw.e_shapeBit);
			dbgDraw.SetFillAlpha(0.5);
			dbgDraw.SetSprite(mySprite);
			world.SetDebugDraw(dbgDraw);
		}
		private function update(e:Event = null):void {
			
			world.Step(30,10,10);
			world.ClearForces();
			//
			world.GetBodyList();
			mouseBody.SetPosition(new b2Vec2(mouseX, mouseY));
			//motor.SetMotorSpeed(1);
			//
			world.DrawDebugData();
		}
	}
	
}