package {
 
        import flash.display.Sprite;
 
        import flash.events.Event;
 
        import Box2D.Dynamics.*;
 
        import Box2D.Collision.*;
 
        import Box2D.Collision.Shapes.*;
 
        import Box2D.Common.Math.*;
 
        public class Test extends Sprite {
 
                public var world:b2World=new b2World(new b2Vec2(0,10.0),true);
 
                public var world_scale:int=30;//1meter=30pixel
 
                public function Test():void {
 
                        debug_draw();
 
                        draw_box(250,300,500,100,false);
 
                        draw_box(250,100,100,100,true);
 
                        draw_circle(100,100,50,false);
 
                        draw_circle(400,100,50,true);
 
                        addEventListener(Event.ENTER_FRAME, update);
 
                }
 
                public function draw_circle(px:Number,py:Number,r:Number,d:Boolean):void {
 
                        var my_body:b2BodyDef= new b2BodyDef();
 
                        my_body.position.Set(px/world_scale, py/world_scale);
 
                        if (d) {
                               my_body.type=b2Body.b2_dynamicBody;
                        }
                        var my_circle:b2CircleShape=new b2CircleShape(r/world_scale);
                        var my_fixture:b2FixtureDef = new b2FixtureDef(); 
                        my_fixture.shape=my_circle;
                        var world_body:b2Body=world.CreateBody(my_body);
                        world_body.CreateFixture(my_fixture);
 
                }
 
                public function draw_box(px:Number,py:Number,w:Number,h:Number,d:Boolean):void {
 
                        var my_body:b2BodyDef= new b2BodyDef();
 
                        my_body.position.Set(px/world_scale, py/world_scale);
 
                        if (d) {
 
                                my_body.type=b2Body.b2_dynamicBody;
 
                        }
 
                        var my_box:b2PolygonShape = new b2PolygonShape();
 
                        my_box.SetAsBox(w/2/world_scale, h/2/world_scale);
 
                        var my_fixture:b2FixtureDef = new b2FixtureDef();
 
                        my_fixture.shape=my_box;
 
                        var world_body:b2Body=world.CreateBody(my_body);
 
                        world_body.CreateFixture(my_fixture);
 
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
 
                        world.Step(1/30,10,10);//the more iteration ,the better effect.
                        world.ClearForces();
                        world.DrawDebugData();
 
                }
 
        }
 
}