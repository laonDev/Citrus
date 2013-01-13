package
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.input.controllers.Keyboard;
	import citrus.math.MathUtils;
	import citrus.math.MathVector;
	import citrus.objects.platformer.box2d.Cannon;
	import citrus.objects.platformer.box2d.Coin;
	import citrus.objects.platformer.box2d.Enemy;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.MovingPlatform;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	import citrus.utils.Mobile;
	
	import starling.display.Quad;
	import starling.utils.deg2rad;
	
	public class GameStats extends StarlingState
	{
		[Embed(source="cat.png")]
		private var Cat:Class;
		
		[Embed(source="ring.png")]
		private var ring:Class;
		
		[Embed(source="tigers.png")]
		private var tigers:Class;
		
		private var floor:Platform;
		private var hero:Hero;
		private var child:ChildHero;
		private var mobileInput:MobileInput;
		private var goal:Coin;
		
		public function GameStats()
		{
			super();
		}
		override public function initialize():void
		{
			super.initialize();
			
			mobileInput = new MobileInput();
			mobileInput.initialize();
			this.view.setupCamera(hero, new MathVector(stage.stageWidth/2, stage.stageHeight/2), new Rectangle(0, 0, 1550, 450), new MathVector(.25, .05));
			
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, onWheel);
			
			var physics:Box2D = new Box2D("box2d");
			physics.visible = true;
			add(physics);
			
			floor = new Platform("floor", {x:1024, y:748, width:2048, height:40});
			floor.view = new Quad(2048, 40, 0x000000);
			add(floor);
			
			var p1:Platform = new Platform("p1", {x: 874, y:151, width:300, height:40});
			p1.view = new Quad(300, 40, 0x000000); 
			add(p1);
			
//			var mp:MovingPlatform = new MovingPlatform("moving", {x:220, y:700, width:200, height:40, startX:220, startY:700, endX:500, endY:151});
//			add(mp);
			
//			hero = new Hero("hero", {x:50, y:50, width:70, height:70});
//			hero.view = new giants();
//			hero.body.SetLinearVelocity(new b2Vec2(Math.cos(30),Math.sin(30)));
//			add(hero);
			
			child = new ChildHero("child", {x:50, y:50, width:376, height:374});
			child.view = new Cat();
			add(child);
			
//			var cannon:Cannon = new Cannon("cannon", {x:50, y:50, width:70, height:70});
//			add(cannon);
//			var enemy:Enemy = new Enemy("enemy",
//				{x:900, y:700, width:70, height:70, leftBound:10, rightBound:1000});
//			add(enemy);
			
			goal = new Coin("goal", {x:900, y:600, width:79, height:79});
			goal.onBeginContact.add(function(c:b2Contact):void{
				trace("ginants win");
			});
			add(goal);
			
		}
		override public function destroy():void
		{
			mobileInput.destroy();
			
		}
		private function onWheel(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			scaleX = e.delta > 0? scaleX + 0.03 : scaleX - 0.03;
			scaleY = scaleX;
			
			view.cameraOffset = new MathVector(stage.stageWidth /2 /scaleX, stage.stageHeight /2 /scaleY);
			view.cameraBounds = new Rectangle(0, 0, 1550 * scaleX, 450 * scaleY);
		}
		override public function update(timeDelta:Number):void
		{
//			vx = (initForce/massive) * Math.cos(deg2rad(-initDegree)) + 0.0015 * windForce * Math.cos(deg2rad(180)) / massive;
//			vy = (initForce/massive) * Math.sin(deg2rad(-initDegree)) - gravity * tick - 0.0015 * windForce * Math.sin(deg2rad(180)) / massive;
			super.update(timeDelta);
			
			goal
			
			if(mobileInput.screenTouched)
			{
				trace("touch");
				var velocity:b2Vec2 = child.body.GetLinearVelocity();
				velocity.x = 10 *Math.cos(-30);
				velocity.y = -(10 *Math.sin(-30));
				
				velocity.x = child.x < 200 ? 10 *Math.cos(-30) : 0;
				velocity.y = child.y > 300 ? -(10 *Math.sin(-30)) : 0;
				trace(floor.x);
				floor.x = child.x < 200 ? floor.x : floor.x - (10 *Math.cos(-30));
				trace(floor.x);
				child.body.SetLinearVelocity(velocity);
			}
//			var vx:Number = Math.cos(deg2rad(-30));
//			var vy:Number = Math.sin(deg2rad(-30));
//			trace(vx, vy);
//			child.x = child.x < 200 ? child.x + vx: child.x;
//			child.y = child.y - vy;
////			child.y = child.y > 300 ? child.y - vy: child.y;
//			
////			trace(floor.x);
//			floor.x = child.x < 200 ? floor.x : floor.x - vx;
////			floor.y = child.y < 300 ? floor.y : floor.y + vy;
////			trace(floor.x);
//			if(floor.x < 0) floor.x = 0;
//			if(floor.x < -stage.stageWidth) floor.x = -stage.stageWidth;
			
			if(CitrusEngine.getInstance().input.isDown(Keyboard.SPACE))
			{ 
				trace("dd");
//				hero.body.SetLinearVelocity(new b2Vec2(Math.cos(30),Math.sin(30)));
			}
		}
	}
}