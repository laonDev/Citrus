package
{
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.datastructures.PoolObject;
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
	
	import starling.display.Image;
	import starling.utils.deg2rad;
	
	public class GameStats extends StarlingState
	{
		[Embed(source="sky1.png")]
		private var Sky1:Class;
//		
//		[Embed(source="sky2.png")]
//		private var Sky2:Class;
//		[Embed(source="BG.png")]
//		private var BG:Class;
		
		[Embed(source="cat_small.png")]
		private var Cat:Class;
		
		[Embed(source="candy.png")]
		private var CandyImage:Class;
		
		[Embed(source="tunaCan.jpg")]
		private var TunaImage:Class;
		
		[Embed(source="fishShapedBread.jpg")]
		private var FiahBreadImage:Class;
		
		
		private var gameState:int;
		//fly object values
		private var angle:int;
		
		private var floor:Platform;
//		private var lowerBg1:CitrusSprite;
//		private var lowerBg2:CitrusSprite;
//		private var upperBg1:CitrusSprite;
//		private var upperBg2:CitrusSprite;
		private var gameBg:GameBackGround;
		private var setting:GameSetting;
		private var info:Information;
		
//		private var hero:Hero;
//		private var child:ChildHero;
		private var bg:GameBackGround;
		private var child:CatObject_2;
		private var mobileInput:MobileInput;
//		private var goal:Coin;
		private var launch:Boolean = false;
		private  var tick:Number;
		private var initForce:Number;
		private var initDegree:int;
		private var windForce:Number;
		private var massive:Number;
		private var acceleration:Number = 0;
//		private var gravity:Number = 9.8;
		
		private var itemFlag:Boolean = false;
		private var _poolCandy:PoolObject;
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
		private var boosterEffectRemainSeconds:Number = 0;
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
			
			gameState = GameConstantValue.GAME_STATE_IDLE;
			
			mobileInput = new MobileInput();
			mobileInput.initialize();
			
			var physics:Box2D = new Box2D("box2d");
			physics.visible = true;
			physics.gravity = new b2Vec2(0, GameConstantValue.GRAVITY);
			add(physics);
			
			floor = new Platform("floor", {x:1440, y:748, width:2880, height:40});
			add(floor);
			
			bg = new GameBackGround("bg", {x:0, y:0, width: 1429, height:2456 });
			add(bg);


			child = new CatObject_2("cat", {peObject:"cat", registration:"topLeft", x:50, y:300, width:100, height:100});
			child.view =new Image(Assets.getAtlas().getTexture("cat_flying"));
			add(child);
			
			setting = new GameSetting();
			this.addChild(setting);
			setting.massive = child.body.GetMass();
			setting.force = 40 * child.body.GetMass();	
			setting.degree = -45;
			
			info = new Information();
			this.addChild(info);
//			angle = -70;
			candyToAnimate = new Vector.<Candy>();
			candyToAnimateLength = 0;
			tunaToAnimate = new Vector.<Tuna>();
			tunaToAnimateLength = 0;
			fishBreadToAnimate = new Vector.<FishShapedBread>();
			fishBreadToAnimateLength = 0;
			
			_poolCandy = new PoolObject(Candy, 100, 5, true);
			createCandyItemPool();
			createTunaItemPool();
			createFishBreadItemPool();
			
//			this.view.setupCamera(child, new MathVector(stage.stageWidth, stage.stageHeight), new Rectangle(0, 0, stage.stageWidth * 100, stage.stageHeight * 100), new MathVector(.25, .25));
//			this.view.camera.cameraLensHeight *= 100;
//			this.view.camera.cameraLensWidth *= 100;
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
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			tick += timeDelta;
//			if(mobileInput.screenTouched);
//			{
//				
//			}
			if(launch)
			{
				var currentVelocity:b2Vec2 = child.body.GetLinearVelocity();
				currentVelocity.x = (initForce/massive) * Math.cos(deg2rad(initDegree)) + tick * windForce * Math.cos(deg2rad(180)) / massive;
				currentVelocity.y = (initForce/massive) * Math.sin(deg2rad(initDegree)) + GameConstantValue.GRAVITY * tick + tick * windForce * Math.sin(deg2rad(180)) / massive;
				if(boosterEffectRemainSeconds > 0)
				{
					var booster:b2Vec2 = new b2Vec2();
					acceleration += 5;
					booster.x = acceleration * Math.cos(deg2rad(0));
					booster.y = acceleration * Math.sin(deg2rad(0));
					boosterEffectRemainSeconds -= 0.1;
					currentVelocity.Add(booster);
					trace("fish bread: ", acceleration, booster.x, booster.y);
				}else
				{
					acceleration = 0;
				}
				var speedX:Number = 0;
				var speedY:Number = 0;
				var tickDistance:Number = Math.sqrt((currentVelocity.x * currentVelocity.x) + (currentVelocity.y*currentVelocity.y));
				var speed:Number = Math.abs(tickDistance / tick);
				info.speed = speed;
				
				distance += currentVelocity.x;
				altitude += -(currentVelocity.y);
				
				info.distance = distance / stage.stageWidth * GameConstantValue.HORIZONTAL_MEASURE;
				info.altitude = altitude / stage.stageHeight * GameConstantValue.VERTICAL_MEASURE;
				
				bg.speedX = speedX = currentVelocity.x;
				if(currentVelocity.y < 0) //상승
				{
					if(child.y <= 300)
					{
						bg.speedY = currentVelocity.y;
						speedY = currentVelocity.y;
					}
				}else // 하강
				{
					if(child.heightBuffer < 0)
					{
						bg.speedY = currentVelocity.y;
						speedY = currentVelocity.y;
					}
					if(bg.isGround)
					{
						child.heightBuffer = 1;
					}
				}
				
				if(bg.itemFlag)
				{
					showItem();
				}
				if(child.onGround)
				{
					trace("onGround");
					launch = false;
					bg.speedX = 0;
					bg.speedY = 0;
					gameState = GameConstantValue.GAME_STATE_OVER;
				}
				animateCandy(speedX, speedY);
				animateTuna(speedX, speedY);
				animateFishBread(speedX, speedY);
				child.body.SetLinearVelocity(currentVelocity);
			}
			
			floor.x = child.x;
			
			if(CitrusEngine.getInstance().input.isDown(Keyboard.SPACE))
			{
				
				launch = true;
				gameState = GameConstantValue.GAME_STATE_PLAYING;
				tick = 0;
				distance = 0;
				altitude = 0;
				initForce = setting.force;
				initDegree = setting.degree;
				windForce = 10;
				acceleration = 0;
				massive	= setting.massive;
				
				bg.x = 0;
				bg.y = 0;
				bg.isGround = false;
				child.onGround = false;
				child.x = 50;
				
				var velocity:b2Vec2;
				velocity = child.body.GetLinearVelocity();
				velocity.x = acceleration * Math.cos(deg2rad(initDegree)) + (initForce / massive) * Math.cos(deg2rad(initDegree));
				velocity.y = acceleration * Math.sin(deg2rad(initDegree)) + (initForce / massive) * Math.sin(deg2rad(initDegree));
				child.body.SetLinearVelocity(velocity);
				
				clearItem();
				showItem();
				trace("launch", velocity.x, velocity.y);
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
				boosterEffectRemainSeconds = GameConstantValue.FISH_BREAD_SECONDS;
			}
		}
		
		
		private function showItem():void
		{
			trace("showItem");
			var loop:Boolean = true;
			var offsetX:int = 0;
			var candyCount:int = GameConstantValue.CANDY_LIKEHOOD;
			var fishBreadCount:int = GameConstantValue.FISH_BREAD_LIKEHOOD;
			var tunaCount:int = GameConstantValue.TUNA_LIKEHOOD;
			bg.itemFlag = false;
			for(var i:int = 0; i < candyCount ; ++i)
			{
				var candyToTrack:Candy = candyPool.checkOut();
				if(candyToTrack == null)
					return;
				candyToTrack.x = child.x + stage.stageWidth + Math.random() * (stage.stageWidth /2) + offsetX;
				candyToTrack.y = 50 + Math.random() * (bg.height * 0.6);
				candyToAnimate[candyToAnimateLength++] = candyToTrack;
//				trace("candy", candyToTrack.x, candyToTrack.y);
				offsetX += candyToTrack.width + Math.random() * 50;
			}
			for(i = 0; i < tunaCount ; ++i)
			{
				var tunaToTrack:Tuna = tunaPool.checkOut();
				if(tunaToTrack == null)
					return;
				tunaToTrack.x = child.x + stage.stageWidth + Math.random() * (stage.stageWidth /2) + offsetX;
				tunaToTrack.y = 50 + (bg.height * 0.6);
				tunaToAnimate[tunaToAnimateLength++] = tunaToTrack;
//				trace("tuna", tunaToTrack.x, tunaToTrack.y);
				offsetX += tunaToTrack.width + Math.random() * 50;
			}
			for(i = 0; i < fishBreadCount ; ++i)
			{
				var fishBreadToTrack:FishShapedBread = fishBreadPool.checkOut();
				if(fishBreadToTrack == null)
					return;
				fishBreadToTrack.x = child.x + stage.stageWidth + Math.random() * (stage.stageWidth /2) + offsetX;
				fishBreadToTrack.y = 50 + (bg.height * 0.6);
				fishBreadToAnimate[fishBreadToAnimateLength++] = fishBreadToTrack;
//				trace("fishBread", fishBreadToTrack.x, fishBreadToTrack.y);
				offsetX += fishBreadToTrack.width + Math.random() * 50;
			}
			
		}
		private function clearItem():void
		{
			var candy:Candy;
			for(var i:uint = 0; i < candyToAnimateLength; ++i)
				disposeItemTemporarily(i, candyToAnimate[i]);
			
		}
		
		private function animateCandy($speedX:Number, $speedY:Number):void
		{
			var candy:Candy;
			trace("coin", candyToAnimateLength);
			for(var i:uint = 0; i < candyToAnimateLength; ++i)
			{
				candy = candyToAnimate[i];
				if(candy != null)
				{
					candy.x -= Math.ceil($speedX * 0.5);
					candy.y -= Math.ceil($speedY * 0.5);
//					candy.y = candy.y 
				}
				if(candy.x < 10 || gameState == GameConstantValue.GAME_STATE_OVER)
					disposeItemTemporarily(i, candy);
			}
		}
		private function animateFishBread($speedX:Number, $speedY:Number):void
		{
			var fishBread:FishShapedBread;
			for(var i:uint = 0; i < fishBreadToAnimateLength; ++i)
			{
				fishBread = fishBreadToAnimate[i];
				if(fishBread != null)
				{
					fishBread.x -= Math.ceil($speedX  * 0.5);
					fishBread.y -= Math.ceil($speedY  * 0.5);
				}
				if(fishBread.x < 10 || gameState == GameConstantValue.GAME_STATE_OVER)
					disposeItemTemporarily(i, fishBread);
			}
		}
		private function animateTuna($speedX:Number, $speedY:Number):void
		{
			var tuna:Tuna;
			for(var i:uint = 0; i < tunaToAnimateLength; ++i)
			{
				tuna = tunaToAnimate[i];
				if(tuna != null)
				{
					tuna.x -= Math.ceil($speedX  * 0.5);
					tuna.y -= Math.ceil($speedY  * 0.5);
				}
				if(tuna.x < 10 || gameState == GameConstantValue.GAME_STATE_OVER)
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
//			remove($candy);
		}
		private function cleanTuna($tuna:Tuna):void
		{
			$tuna.x = stage.stageWidth + 100;
//			remove($tuna);
		}
		private function cleanFishBread($fishBread:FishShapedBread):void
		{
			$fishBread.x = stage.stageWidth + 100;
//			remove($fishBread);
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
			boosterEffectRemainSeconds = GameConstantValue.TUNA_BOOSTER_SECONDS;
		}
		//during five seconds give more speed 0.3 * timeDelta
		private function contactFishBread(c:b2Contact):void
		{
			trace("get fish bread");
			boosterEffectRemainSeconds = GameConstantValue.FISH_BREAD_SECONDS;
		}
		private function disposeItemTemporarily($animateId:uint, $object:Object):void
		{
			trace("dispose ", $object);
			if($object is Candy)
			{
				candyToAnimate.splice($animateId, 1);
				candyToAnimateLength--;
				candyPool.checkIn($object as Candy);
			}
			if($object is Tuna)
			{
				tunaToAnimate.splice($animateId, 1);
				tunaToAnimateLength--;
				tunaPool.checkIn($object as Tuna);
			}
			if($object is FishShapedBread)
			{
				fishBreadToAnimate.splice($animateId, 1);
				fishBreadToAnimateLength--;
				fishBreadPool.checkIn($object as FishShapedBread);
			} 
			$object.x = stage.stageWidth * 2 + $object.width * 2;
//			($object as Coin).visible = false;
		}
	}
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
*/3