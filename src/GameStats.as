package
{
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import box2dstarling.PhysicsEditorObjects;
	
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.input.controllers.Keyboard;
	import citrus.math.MathVector;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.box2d.Coin;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	
	import item.Candy;
	import item.FishShapedBread;
	import item.Tuna;
	
	import objectPool.PoolCandy;
	import objectPool.PoolFishShapedBread;
	import objectPool.PoolTuna;
	
	import starling.display.Quad;
	import starling.utils.deg2rad;
	
	public class GameStats extends StarlingState
	{
		[Embed(source="sky1.png")]
		private var Sky1:Class;
		
		[Embed(source="sky2.png")]
		private var Sky2:Class;
		
		[Embed(source="cat.png")]
		private var Cat:Class;
		
		[Embed(source="candy.png")]
		private var CandyImage:Class;
		
		[Embed(source="tunaCan.jpg")]
		private var TunaImage:Class;
		
		[Embed(source="fishShapedBread.jpg")]
		private var FiahBreadImage:Class;
		
		
		//fly object values
		private var angle:int;
		
		private var floor:Platform;
		private var lowerBg1:CitrusSprite;
		private var lowerBg2:CitrusSprite;
		private var upperBg1:CitrusSprite;
		private var upperBg2:CitrusSprite;
		private var gameBg:GameBackGround;
		private var setting:GameSetting;
		private var info:Information;
		
		private var hero:Hero;
//		private var child:ChildHero;
		private var bg:CitrusSprite;
		private var child:CatObject_2;
		private var mobileInput:MobileInput;
		private var goal:Coin;
		private var launch:Boolean = false;
		private  var tick:Number;
		private var initForce:Number;
		private var initDegree:int;
		private var windForce:Number;
		private var massive:Number;
		private var acceleration:Number = 0;
//		private var gravity:Number = 9.8;
		
		private var candyPool:PoolCandy;
		private var candyToAnimate:Vector.<Candy>;
		private var candyToAnimateLength:uint = 0;
		
		private var tunaPool:PoolTuna;
		private var tunaToAnimate:Vector.<Tuna>;
		private var tunaToAnimateLength:uint = 0;
		private var tunaEffectRemainSeconds:Number = 0;
		
		private var fishBreadPool:PoolFishShapedBread;
		private var fishBreadToAnimate:Vector.<FishShapedBread>;
		private var fishBreadToAnimateLength:uint = 0;
		private var fishBreadEffectRemainSeconds:Number = 0;
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
			
			var physics:Box2D = new Box2D("box2d");
//			physics.visible = true;
			physics.gravity = new b2Vec2(0, GameConstantValue.GRAVITY);
			add(physics);
			
			floor = new Platform("floor", {x:1024, y:748, width:2048, height:40});
			add(floor);
			floor.view = new Quad(2048, 40, 0x000000);
			
			bg = new CitrusSprite("bg", {x:0, y:768, width: 2048, height:768 +768 });
			bg.view = new GameBackGround();
			add(bg);

			lowerBg1= new CitrusSprite("lowerBg1", {x:0, y:0, width: 1024, height:768});
			lowerBg1.view = new Sky1();
			add(lowerBg1);
			lowerBg2 = new CitrusSprite("lowerBg2", {x:stage.stageWidth, y:0, width: 1024, height:768});
			lowerBg2.view = new Sky2();
			add(lowerBg2);
			upperBg1= new CitrusSprite("upperBg1", {x:0, y:-stage.stageHeight, width: 1024, height:768});
			upperBg1.view = new Sky1();
			add(upperBg1);
			upperBg2 = new CitrusSprite("upperBg2", {x:stage.stageWidth, y:-stage.stageHeight, width: 1024, height:768});
			upperBg2.view = new Sky2();
			add(upperBg2);

			child = new CatObject_2("cat", {peObject:"cat", view:"cat.png", registration:"topLeft", x:50, y:300, width:280, height:280});
			add(child);
			
			setting = new GameSetting();
			this.addChild(setting);
			setting.massive = child.body.GetMass();
			setting.force = 20 * child.body.GetMass();
			setting.degree = -45;
			
			info = new Information();
			this.addChild(info);
//			angle = -70;
			
			
			this.view.setupCamera(child, new MathVector(280, 280), new Rectangle(0, -stage.stageHeight, stage.stageWidth * 100, stage.stageHeight * 100), new MathVector(.25, .25));
//			this.view.camera.cameraLensHeight = 768;
//			this.view.camera.cameraLensWidth = 1024;
			
		}
		override public function destroy():void
		{
			mobileInput.destroy();
			
		}
		private function onWheel(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			trace("wheel");
			scaleX = e.delta > 0? scaleX + 0.03 : scaleX - 0.03;
			scaleY = scaleX;
			
			view.camera.offset= new MathVector(stage.stageWidth /2 /scaleX, stage.stageHeight /2 /scaleY);
			view.camera.bounds = new Rectangle(0, 0, 1550 * scaleX, 450 * scaleY);
		}
		/*
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
				var current_velocity:b2Vec2 = child.body.GetLinearVelocity();
//				trace(current_velocity.x, current_velocity.y);
//				trace(child.body.GetLinearVelocity().x);
				if(fishBreadEffectRemainSeconds > 0)
				{
					acceleration += 0.25;
					current_velocity.x += acceleration * Math.cos(deg2rad(initDegree));
					current_velocity.y += acceleration * Math.sin(deg2rad(initDegree));
					fishBreadEffectRemainSeconds -= 0.5;
					trace("fish bread: ", acceleration, fishBreadEffectRemainSeconds);
				}else
				{
					acceleration = 0;
				}
//				velocity.x = acceleration * Math.cos(deg2rad(initDegree)) + (initForce / massive) * Math.cos(deg2rad(initDegree)) + tick * windForce * Math.cos(deg2rad(180)) / massive;
//				velocity.y = acceleration * Math.sin(deg2rad(initDegree)) + (initForce / massive) * Math.sin(deg2rad(initDegree)) + GameConstantValue.GRAVITY * tick + tick * windForce * Math.sin(deg2rad(180)) / massive;
				var speedX:Number = 0;
				var speedY:Number = 0;
				var tickDistance:Number = Math.sqrt((current_velocity.x * current_velocity.x) + (current_velocity.y*current_velocity.y));
				var speed:Number = Math.abs(tickDistance / tick);
				info.speed = speed;
//				info.speed = child.getWalkingSpeed();
				
				distance += current_velocity.x;
				altitude += -(current_velocity.y);
				info.distance = distance / stage.stageWidth * GameConstantValue.HORIZONTAL_MEASURE;
				info.altitude = altitude / stage.stageHeight * GameConstantValue.VERTICAL_MEASURE;
				
				if(child.x + stage.stageWidth > lowerBg1.x + lowerBg1.width)
				{
					lowerBg2.x = lowerBg1.x + lowerBg1.width;
					showItem();
				}
				if(child.x + stage.stageWidth > lowerBg2.x + lowerBg2.width)
				{
					showItem();
					lowerBg1.x = lowerBg2.x + lowerBg2.width;
				}
//				if(child.y + stage.stageHeight > lowerBg1.y + lowerBg1.height)
//					upperBg1.y = lowerBg1.y - lowerBg1.height;
//				if(child.y + stage.stageHeight > upperBg1.y + upperBg1.height)
//					lowerBg1.y = upperBg1.y - upperBg1.height;
//				if(child.y + stage.stageHeight > lowerBg2.y + lowerBg2.height)
//					upperBg2.y = lowerBg2.y - lowerBg2.height;
//				if(child.y + stage.stageHeight > upperBg2.y + upperBg2.height)
//					lowerBg2.y = upperBg2.y - upperBg2.height;
				
				
				
//				this.view.camera.bounds = new Rectangle(-child
//				if(child.x > 200);
//					floor.x = floor.x - (child.x + 200);
//				if(child.x < 200)
//				{
//					bg.x = bg.x;
//					floor.x = floor.x;
//				}else
//				{
//					floor.x -= current_velocity.x;					
//					bg.x -= current_velocity.x;
//					speedX = current_velocity.x;
//				}
//				if(current_velocity.y < 0)
//				{
//					if(child.y > 300)
//					{
//						bg.y = bg.y;
//					}else
//					{
//						bg.y -= current_velocity.y;
//						speedY = current_velocity.y;
//					}
//				}else
//				{
//					bg.y = bg.y > stage.stageHeight ? bg.y - current_velocity.y : stage.stageHeight;
//					speedY = current_velocity.y;
//				}
				
				animateCandy(speedX, speedY);
				animateTuna(speedX, speedY);
				animateFishBread(speedX, speedY);
				if(floor.x < 0) floor.x = 0;
				if(floor.x < -stage.stageWidth) floor.x = -stage.stageWidth;
				
//				if (bg.x > 0) bg.x = -stage.stageWidth;
//				if (bg.x < -stage.stageWidth )
//				{
//					bg.x = 0;
//					showItem();
//				}
//				if (bg.y < 0)
//				{
//					bg.y = stage.stageHeight;
//				}
//				if (bg.y > stage.stageHeight)
//				{
//					bg.y = 0;
//					showItem();
//				}
				
//				velocity.x = child.x < 200 ? velocity.x : 0;
//				if(velocity.y < 0) //상승
//				{
//					velocity.y = child.y > 300 ? velocity.y : 0;
//				}else //하강
//				{
//					velocity.y = child.y > 300 ? velocity.y : 0;
//					
//				}
				if(child.onGround)
				{
					launch = false;
				}
			}
			
			floor.x = child.x;
			
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
				acceleration = 0;
				massive	= setting.massive;
				
				var velocity:b2Vec2;
				velocity = child.body.GetLinearVelocity();
				velocity.x = acceleration * Math.cos(deg2rad(initDegree)) + (initForce / massive) * Math.cos(deg2rad(initDegree)) + tick * windForce * Math.cos(deg2rad(180)) / massive;
				velocity.y = acceleration * Math.sin(deg2rad(initDegree)) + (initForce / massive) * Math.sin(deg2rad(initDegree)) + GameConstantValue.GRAVITY * tick + tick * windForce * Math.sin(deg2rad(180)) / massive;
				child.body.SetLinearVelocity(velocity);
				
//				floor.x = 1024; 
//				floor.y = 748;
//				bg.x = 0;
//				bg.y = 0;
				child.onGround = false;
				child.x = 50;
				
				candyToAnimate = new Vector.<Candy>();
				candyToAnimateLength = 0;
				tunaToAnimate = new Vector.<Tuna>();
				tunaToAnimateLength = 0;
				fishBreadToAnimate = new Vector.<FishShapedBread>();
				fishBreadToAnimateLength = 0;
				
				createCandyItemPool();
				createTunaItemPool();
				createFishBreadItemPool();
				
				showItem();
				//				child.body.SetAngularVelocity(deg2rad(90)/10);
				//				candyTimer.start();
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
			if(CitrusEngine.getInstance().input.isDown(Keyboard.UP))
			{
				trace("get fish bread");
				fishBreadEffectRemainSeconds = GameConstantValue.ITEM_MAINTENANCE_SECONDS;
			}
		}
		*/
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
				if(fishBreadEffectRemainSeconds > 0)
				{
					acceleration += 0.3;
					fishBreadEffectRemainSeconds -= 0.1;
					trace("fish bread: ", acceleration, fishBreadEffectRemainSeconds);
				}else
				{
					acceleration = 0;
				}
//				trace(Math.sin(deg2rad(initDegree)));
				velocity.x = acceleration * Math.cos(deg2rad(initDegree)) + (initForce / massive) * Math.cos(deg2rad(initDegree)) + tick * windForce * Math.cos(deg2rad(180)) / massive;
				velocity.y = acceleration * Math.sin(deg2rad(initDegree)) + (initForce / massive) * Math.sin(deg2rad(initDegree)) + GameConstantValue.GRAVITY * tick + tick * windForce * Math.sin(deg2rad(180)) / massive;
//				Math.atan2(
				var speedX:Number = 0;
				var speedY:Number = 0;
				var tickDistance:Number = Math.sqrt((velocity.x * velocity.x) + (velocity.y*velocity.y));
				var speed:Number = Math.abs(tickDistance / tick);
				info.speed = speed;
//				info.speed = child.getWalkingSpeed();
				
				distance += velocity.x;
				altitude += -velocity.y;
				info.distance = distance / stage.stageWidth * GameConstantValue.HORIZONTAL_MEASURE;
				info.altitude = altitude / stage.stageHeight * GameConstantValue.VERTICAL_MEASURE;
				if(child.x < 200)
				{
					bg.x = bg.x;
					floor.x = floor.x;
				}else
				{
					floor.x -= velocity.x;					
					bg.x -= velocity.x;
					speedX = velocity.x;
				}
				if(velocity.y < 0)
				{
					if(child.y > 300)
					{
						bg.y = bg.y;
					}else
					{
						bg.y -= velocity.y;
						speedY = velocity.y;
					}
				}else
				{
//					trace("1",velocity.x, velocity.y);
//					trace("2",floor.y, bg.y);
//					floor.y = floor.y < 748 ? floor.y - velocity.y : 748;
					bg.y = bg.y > stage.stageHeight ? bg.y - velocity.y : stage.stageHeight;
					speedY = velocity.y;
//					if(bg.y == stage.stageHeight)
//					{
//						launch = false;
//						child.body.SetLinearVelocity(new b2Vec2());
////						trace("3",floor.y, bg.y);
//					}
				}
				animateCandy(speedX, speedY);
				animateTuna(speedX, speedY);
				animateFishBread(speedX, speedY);
				if(floor.x < 0) floor.x = 0;
				if(floor.x < -stage.stageWidth) floor.x = -stage.stageWidth;
				
				if (bg.x > 0) bg.x = -stage.stageWidth;
				if (bg.x < -stage.stageWidth )
				{
					bg.x = 0;
					showItem();
				}
				if (bg.y < 0)
				{
					bg.y = stage.stageHeight;
				}
				if (bg.y > stage.stageHeight)
				{
					bg.y = 0;
					showItem();
				}
				
				velocity.x = child.x < 200 ? velocity.x : 0;
				if(velocity.y < 0) //상승
				{
					velocity.y = child.y > 300 ? velocity.y : 0;
				}else //하강
				{
					velocity.y = child.y > 300 ? velocity.y : 0;
					
				}
				if(child.onGround)
				{
					launch = false;
					
				}
//				child.acceleration
				
				child.body.SetLinearVelocity(velocity);
				
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
				
				floor.x = 1024; 
				floor.y = 748;
				bg.x = 0;
				bg.y = 0;
				child.onGround = false;
				child.x = 50;
//				child.y = 50;
				
				
//				gravity = setting.gravity;
				
				candyToAnimate = new Vector.<Candy>();
				candyToAnimateLength = 0;
				tunaToAnimate = new Vector.<Tuna>();
				tunaToAnimateLength = 0;
				fishBreadToAnimate = new Vector.<FishShapedBread>();
				fishBreadToAnimateLength = 0;
				
				createCandyItemPool();
				createTunaItemPool();
				createFishBreadItemPool();
				
				showItem();
//				child.body.SetAngularVelocity(deg2rad(90)/10);
//				candyTimer.start();
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
			if(CitrusEngine.getInstance().input.isDown(Keyboard.UP))
			{
				trace("get fish bread");
				fishBreadEffectRemainSeconds = GameConstantValue.ITEM_MAINTENANCE_SECONDS;
			}
		}
		
		private function showItem():void
		{
			var loop:Boolean = true;
			while(loop)
			{
				var random:uint = Math.random() * 100;
				if(random < GameConstantValue.CANDY_LIKEHOOD)
				{
					trace("candy");
					var candyToTrack:Candy = candyPool.checkOut();
					candyToTrack.x = child.x + stage.stageWidth + Math.random() *(stage.stageWidth/2);
					candyToTrack.y = 50 + Math.random() * (stage.stageHeight /2);
					candyToAnimate[candyToAnimateLength++] = candyToTrack;
				}
				else
				{
					trace("generate done");
					loop = false;
				}
				if(random < GameConstantValue.TUNA_LIKEHOOD)
				{
					trace("tuna");
					var tunaToTrack:Tuna = tunaPool.checkOut();
					tunaToTrack.x = child.x + stage.stageWidth + Math.random() *300;
					tunaToTrack.y = 50 + Math.random() * 250;
					tunaToAnimate[tunaToAnimateLength++] = tunaToTrack;
				}
				if(random < GameConstantValue.FISH_BREAD_LIKEHOOD)
				{
					trace("fishBread");
					var fishBreadToTrack:FishShapedBread = fishBreadPool.checkOut();
					fishBreadToTrack.x = child.x + stage.stageWidth + Math.random() *300;
					fishBreadToTrack.y = 50 + Math.random() * 250;
					fishBreadToAnimate[fishBreadToAnimateLength++] = fishBreadToTrack;
				}
			}
			
		}
		private function animateCandy($speedX:Number, $speedY:Number):void
		{
			var candy:Candy;
			if(!launch)
				return;
			for(var i:uint = 0; i < candyToAnimateLength; ++i)
			{
				candy = candyToAnimate[i];
				if(candy != null)
				{
					candy.x -= $speedX;
					candy.y -= $speedY;
				}
				if(candy.x < 80)
					disposeItemTemporarily(i, candy);
			}
		}
		private function animateFishBread($speedX:Number, $speedY:Number):void
		{
			var fishBread:FishShapedBread;
			if(!launch)
				return;
			for(var i:uint = 0; i < fishBreadToAnimateLength; ++i)
			{
				fishBread = fishBreadToAnimate[i];
				if(fishBread != null)
				{
					fishBread.x -= $speedX;
					fishBread.y -= $speedY;
				}
				if(fishBread.x < 80)
					disposeItemTemporarily(i, fishBread);
			}
		}
		private function animateTuna($speedX:Number, $speedY:Number):void
		{
			var tuna:Tuna;
			if(!launch)
				return;
			for(var i:uint = 0; i < tunaToAnimateLength; ++i)
			{
				tuna = tunaToAnimate[i];
				if(tuna != null)
				{
					tuna.x -= $speedX;
					tuna.y -= $speedY;
				}
				if(tuna.x < 80)
					disposeItemTemporarily(i, tuna);
			}
		}
		private function createCandyItemPool():void
		{
			if(candyPool == null)
				candyPool = new PoolCandy(createCandy, cleanCandy);
//			candyPool.item
		}
		private function createTunaItemPool():void
		{
			if(tunaPool == null)
				tunaPool = new PoolTuna(createTuna, cleanTuna);
		}
		private function createFishBreadItemPool():void
		{
			if(fishBreadPool == null)
				fishBreadPool = new PoolFishShapedBread(createFishBread, cleanFishBread);
		}
		private function cleanCandy($candy:Candy):void
		{
			$candy.x = stage.stageWidth + 100;
		}
		private function cleanTuna($tuna:Tuna):void
		{
			$tuna.x = stage.stageWidth + 100;
		}
		private function cleanFishBread($fishBread:FishShapedBread):void
		{
			$fishBread.x = stage.stageWidth + 100;
		}
		private function createCandy():Candy
		{
			var positionX:int = child.x + (stage.stageWidth *2) + Math.random() *300;
			var positionY:int = 50 + Math.random() * 250;
			var candy:Candy = new Candy("Candy", {x:positionX, y: positionY, width:85, height:60});
			candy.view = new CandyImage();
			candy.onBeginContact.add(contactCandy);
			add(candy);
			return candy;
		}
		private function createTuna():Tuna
		{
			var positionX:int = child.x + (stage.stageWidth *2) + Math.random() *300;
			var positionY:int = 50 + Math.random() * 250;
			var tuna:Tuna = new Tuna("Tuna", {x:positionX, y:positionY, width:92, height:55});
			tuna.view = new TunaImage();
			tuna.onBeginContact.add(contactTuna);
			add(tuna);
			return tuna;
		}
		private function createFishBread():FishShapedBread
		{
			var positionX:int = child.x + (stage.stageWidth *2) + Math.random() *300;
			var positionY:int = 50 + Math.random() * 250;
			var fishBread:FishShapedBread = new FishShapedBread("fishBread", {x:positionX, y:positionY, width:62, height:62});
			fishBread.view = new FiahBreadImage();
			fishBread.onBeginContact.add(contactFishBread);
			add(fishBread);
			return fishBread;
			
		}
		private function contactCandy(c:b2Contact):void
		{
			trace("get candy");
		}
		//during five seconds income game money will twice than normal situation 
		//At the first time, multiply 2, second multiply 3, third multiply 5, 
		//after forth no increase multiple value refresh time to five seconds 
		private function contactTuna(c:b2Contact):void
		{
			trace("get tuna");
		}
		//during five seconds give more speed 0.3 * timeDelta
		private function contactFishBread(c:b2Contact):void
		{
			trace("get fish bread");
			fishBreadEffectRemainSeconds = GameConstantValue.ITEM_MAINTENANCE_SECONDS;
		}
		private function disposeItemTemporarily($animateId:uint, $object:Object):void
		{
			if($object is Candy)
			{
				candyToAnimate.splice($animateId, 1);
				candyToAnimateLength--;
			}
			if($object is Tuna)
			{
				tunaToAnimate.splice($animateId, 1);
				tunaToAnimateLength--;
			}
			if($object is FishShapedBread)
			{
				fishBreadToAnimate.splice($animateId, 1);
				fishBreadToAnimateLength--;
			}
			
			$object.x = stage.stageWidth + $object.width * 2;
		}
	}
}