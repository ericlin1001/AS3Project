package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.Joints.*;
	public class AngryBird extends Sprite {
		private var world:b2World=new b2World(new b2Vec2(0,10),true);
		private var worldScale:int=30;
		private var bird:Bird=new Bird();
		private var birdSphere:b2Body;
		private var preview:Sprite=new Sprite();
		public function AngryBird() {
			var bg:Background=new Background();
			addChild(bg);
			addChild(bird);
			addChild(preview);
			bird.x=170;
			bird.y=270;
			bird.buttonMode=true;
			addWall(320,10,320,395);
			addWall(320,10,320,-5);
			addWall(10,320,-5,240);
			addWall(10,320,645,240);
			addEventListener(Event.ENTER_FRAME,updateWorld);
			bird.addEventListener(MouseEvent.MOUSE_DOWN,birdClicked);
		}
		private function addWall(w:Number,h:Number,px:Number,py:Number):void {
			var floorShape:b2PolygonShape = new b2PolygonShape();
			floorShape.SetAsBox(w/worldScale,h/worldScale);
			var floorFixture:b2FixtureDef = new b2FixtureDef();
			floorFixture.density=0;
			floorFixture.friction=10;
			floorFixture.restitution=0.5;
			floorFixture.shape=floorShape;
			var floorBodyDef:b2BodyDef = new b2BodyDef();
			floorBodyDef.position.Set(px/worldScale,py/worldScale);
			var floor:b2Body=world.CreateBody(floorBodyDef);
			floor.CreateFixture(floorFixture);
		}
		private function birdClicked(e:MouseEvent):void {
			addEventListener(MouseEvent.MOUSE_MOVE,birdMoved);
			addEventListener(MouseEvent.MOUSE_UP,birdReleased);
			bird.removeEventListener(MouseEvent.MOUSE_DOWN,birdClicked);
		}
		private function birdMoved(e:MouseEvent):void {
			bird.x=mouseX;
			bird.y=mouseY;
			var distanceX:Number=bird.x-170;
			var distanceY:Number=bird.y-270;
			if (distanceX*distanceX+distanceY*distanceY>10000) {
				var birdAngle:Number=Math.atan2(distanceY,distanceX);
				bird.x=170+100*Math.cos(birdAngle);
				bird.y=270+100*Math.sin(birdAngle);
			}
			fakeRelease();
		}
		private function fakeRelease():void {
			var sphereShape:b2CircleShape=new b2CircleShape(15/worldScale);
			var sphereFixture:b2FixtureDef = new b2FixtureDef();
			sphereFixture.density=1;
			sphereFixture.friction=3;
			sphereFixture.restitution=0.1;
			sphereFixture.shape=sphereShape;
			var sphereBodyDef:b2BodyDef = new b2BodyDef();
			sphereBodyDef.type=b2Body.b2_dynamicBody;
			sphereBodyDef.userData=bird;
			sphereBodyDef.position.Set(bird.x/worldScale,bird.y/worldScale);
			birdSphere=world.CreateBody(sphereBodyDef);
			birdSphere.CreateFixture(sphereFixture);
			var distanceX:Number=bird.x-170;
			var distanceY:Number=bird.y-270;
			var distance:Number=Math.sqrt(distanceX*distanceX+distanceY*distanceY);
			var birdAngle:Number=Math.atan2(distanceY,distanceX);
			birdSphere.SetLinearVelocity(new b2Vec2(-distance*Math.cos(birdAngle)/4,-distance*Math.sin(birdAngle)/4));
			preview.graphics.clear();
			preview.graphics.lineStyle(1,0x000000);
			preview.graphics.beginFill(0xff0000);
			for (var i:int=1; i<=150; i++) {
				world.Step(1/30,10,10);
				preview.graphics.drawCircle(birdSphere.GetPosition().x*worldScale,birdSphere.GetPosition().y*worldScale,2);
				world.ClearForces();
			}
			preview.graphics.endFill();
			world.DestroyBody(birdSphere);
 
		}
		private function birdReleased(e:MouseEvent):void {
			bird.buttonMode=false;
			removeEventListener(MouseEvent.MOUSE_MOVE,birdMoved);
			removeEventListener(MouseEvent.MOUSE_UP,birdReleased);
			var sphereShape:b2CircleShape=new b2CircleShape(15/worldScale);
			var sphereFixture:b2FixtureDef = new b2FixtureDef();
			sphereFixture.density=1;
			sphereFixture.friction=3;
			sphereFixture.restitution=0.1;
			sphereFixture.shape=sphereShape;
			var sphereBodyDef:b2BodyDef = new b2BodyDef();
			sphereBodyDef.type=b2Body.b2_dynamicBody;
			sphereBodyDef.userData=bird;
			sphereBodyDef.position.Set(bird.x/worldScale,bird.y/worldScale);
			birdSphere=world.CreateBody(sphereBodyDef);
			birdSphere.CreateFixture(sphereFixture);
			var distanceX:Number=bird.x-170;
			var distanceY:Number=bird.y-270;
			var distance:Number=Math.sqrt(distanceX*distanceX+distanceY*distanceY);
			var birdAngle:Number=Math.atan2(distanceY,distanceX);
			birdSphere.SetLinearVelocity(new b2Vec2(-distance*Math.cos(birdAngle)/4,-distance*Math.sin(birdAngle)/4));
		}
		private function updateWorld(e:Event):void {
			world.Step(1/30,10,10);
			for (var currentBody:b2Body=world.GetBodyList(); currentBody; currentBody=currentBody.GetNext()) {
				if (currentBody.GetUserData()) {
					currentBody.GetUserData().x=currentBody.GetPosition().x*worldScale;
					currentBody.GetUserData().y=currentBody.GetPosition().y*worldScale;
					currentBody.GetUserData().rotation=currentBody.GetAngle()*(180/Math.PI);
				}
			}
			world.ClearForces();
			world.DrawDebugData();
		}
	}
}