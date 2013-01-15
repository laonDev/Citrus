package
{
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import Box2D.Collision.b2Distance;
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import away3d.bounds.NullBounds;
	
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.input.controllers.Keyboard;
	import citrus.math.MathVector;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.box2d.Coin;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	
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
		
		private const HORIZONTAL_MEASURE:Number = 5;
		private const VERTICAL_MEASURE:Number = 2;
		//fly object values
		private var angle:int;
		
		private var floor:Platform;
		private var bg:CitrusSprite;
		private var gameBg:GameBackGround;
		private var setting:GameSetting;
		private var info:Information;
		
		private var hero:Hero;
		private var child:ChildHero;
		private var mobileInput:MobileInput;
		private var goal:Coin;
		private var launch:Boolean = false;
		private  var tick:Number;
		private var initForce:int;
		private var initDegree:int;
		private var windForce:int;
		private var massive:int;
		private var gravity:Number = 9.8;
		
		//info
		private var distance:Number;
		private var altitude:Number;
		
		public function GameStats()
		{
			super();
		}
		override public function initialize():void
		{
			super.initialize();
			
			mobileInput = new MobileInput();
			mobileInput.initialize();
//			this.view.setupCamera(hero, new MathVector(stage.stageWidth/2, stage.stageHeight/2), new Rectangle(0, 0, 1550, 450), new MathVector(.25, .05));
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, onWheel);
			
			var physics:Box2D = new Box2D("box2d");
			physics.visible = true;
			physics.gravity = new b2Vec2(0, gravity);
			add(physics);
			
			floor = new Platform("floor", {x:1024, y:748, width:2048, height:40});
			add(floor);
			floor.view = new Quad(2048, 40, 0x000000);
			
			bg = new CitrusSprite("bg", {x:0, y:0, width: 2048, height:768 +768 });
			bg.view = new GameBackGround();
			add(bg);

			child = new ChildHero("child", {x:50, y:50, width:280, height:280});
			child.view = new Cat();
			add(child);
//			var mass:b2MassData = new b2MassData();
//			mass.mass = 1;
//			child.body.SetMassData(mass);
			
			goal = new Coin("goal", {x:900, y:600, width:79, height:79});
			goal.onBeginContact.add(function(c:b2Contact):void{
				trace("ginants win");
			});
			add(goal);
			
			setting = new GameSetting();
			this.addChild(setting);
			setting.massive = child.body.GetMass();
			setting.gravity = physics.gravity.y;
			setting.force = 30;
			setting.degree = -45;
			
			info = new Information();
			this.addChild(info);
			angle = -70;
//			var p1:Platform = new Platform("p1", {x: 874, y:151, width:300, height:40});
//			p1.view = new Quad(300, 40, 0x000000); 
//			add(p1);

//			var mp:MovingPlatform = new MovingPlatform("moving", {x:220, y:700, width:200, height:40, startX:220, startY:700, endX:500, endY:151});
//			add(mp);

//			hero = new Hero("hero", {x:50, y:50, width:70, height:70});
//			hero.view = new giants();
//			hero.body.SetLinearVelocity(new b2Vec2(Math.cos(30),Math.sin(30)));
//			add(hero);
//			var cannon:Cannon = new Cannon("cannon", {x:50, y:50, width:70, height:70});
//			add(cannon);
//			var enemy:Enemy = new Enemy("enemy",
//				{x:900, y:700, width:70, height:70, leftBound:10, rightBound:1000});
//			add(enemy);
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
			
			view.camera.offset= new MathVector(stage.stageWidth /2 /scaleX, stage.stageHeight /2 /scaleY);
			view.camera.bounds = new Rectangle(0, 0, 1550 * scaleX, 450 * scaleY);
		}
		override public function update(timeDelta:Number):void
		{
//			vx = (initForce/massive) * Math.cos(deg2rad(-initDegree)) + 0.0015 * windForce * Math.cos(deg2rad(180)) / massive;
//			vy = (initForce/massive) * Math.sin(deg2rad(-initDegree)) - gravity * tick - 0.0015 * windForce * Math.sin(deg2rad(180)) / massive;
			super.update(timeDelta);
			tick += timeDelta;
			if(mobileInput.screenTouched);
			{
				
			}
			if(launch)
			{
				var velocity:b2Vec2 = child.body.GetLinearVelocity();
				velocity.x = (initForce / massive) * Math.cos(deg2rad(initDegree)) - tick * windForce * Math.cos(deg2rad(180)) / massive;
				velocity.y = (initForce / massive) * Math.sin(deg2rad(initDegree)) + gravity * tick + tick * windForce * Math.sin(deg2rad(180)) / massive;
				
//				var distance:Number = Math.sqrt((velocity.x * velocity.x) + (velocity.y*velocity.y));
//				var speed:Number = Math.abs(distance / tick);
				info.speed = child.getWalkingSpeed();
				
				
				distance += velocity.x;
				altitude -= velocity.y;
//				trace(altitude);
				info.distance = distance / stage.stageWidth * HORIZONTAL_MEASURE;
				info.altitude = altitude / stage.stageHeight * VERTICAL_MEASURE;
				if(child.x < 200)
				{
					bg.x = bg.x;
					floor.x = floor.x;
				}else
				{
					floor.x -= velocity.x;					
					bg.x -= velocity.x;
				}
				if(velocity.y < 0)
				{
					if(child.y > 300)
					{
						floor.y = floor.y;
						bg.y = bg.y;
					}else
					{
						floor.y -= velocity.y;
						bg.y -= velocity.y;
					}
				}else
				{
					floor.y =floor.y < 748 ? floor.y - velocity.y : 748;
					bg.y = bg.y > 0 ? bg.y - velocity.y : 0;
					
					if(floor.y == 748 && bg.y == 0)
					{
						launch = false;
						child.body.SetLinearVelocity(new b2Vec2());
					}
						
//					if(child.onGround)
//					{
//						trace("on ground");
//						launch = false;
//						child.body.SetLinearVelocity(new b2Vec2());
//						return;
//					}
				}
				if(floor.x < 0) floor.x = 0;
				if(floor.x < -stage.stageWidth) floor.x = -stage.stageWidth;
				
				if (bg.x > 0) bg.x = -stage.stageWidth;
				if (bg.x < -stage.stageWidth ) bg.x = 0;
				if (bg.y < 0) bg.y = -stage.stageHeight;
				if (bg.y > stage.stageHeight) bg.y = 0;

				velocity.x = child.x < 200 ? velocity.x : 0;
				if(velocity.y < 0) //상승
				{
					velocity.y = child.y > 300 ? velocity.y : 0;
				}else //하강
				{
//					trace("down");
					velocity.y = child.y > 300 ? velocity.y : 0;
					
				}
//				velocity.y = child.y > 300 ? velocity.y : 0;
				child.body.SetLinearVelocity(velocity);
				child.body.SetAngle(deg2rad(initDegree));
				
			}
			if(CitrusEngine.getInstance().input.isDown(Keyboard.SPACE))
			{
				trace("launch");
				launch = true;
				tick = 0;
				distance = 0;
				altitude = 0;
				initForce = setting.force;
				initDegree = setting.degree;
				windForce = 10;
				massive	= setting.massive;
				gravity = setting.gravity;
			}
			if(CitrusEngine.getInstance().input.isDown(Keyboard.RIGHT))
			{
				trace("right ", initDegree);
				initDegree = initDegree	< 90 ? initDegree + 11.25 : 90;
				trace(initDegree);
			}
			if(CitrusEngine.getInstance().input.isDown(Keyboard.LEFT))
			{
				trace("left ", initDegree);
				initDegree = initDegree	< -70 ? initDegree - 11.25 : -70;
				trace(initDegree);
			}
		}
	}
}