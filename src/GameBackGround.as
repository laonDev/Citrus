package
{
	import citrus.objects.CitrusSprite;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameBackGround extends CitrusSprite
	{
		private var _container:Sprite;
		private var bgLayer1:BGLayer;
		private var buildingLayer2:BGLayer;
		private var buildingLayer3:BGLayer;
		private var buildingLayer4:BGLayer;
		
		private var _speedX:Number = 0;
		private var _speedY:Number = 0;
		private var _gamePaused:Boolean = false;
		private var _isGround:Boolean = false;
		private var _itemFlag:Boolean = false;
		private var _stage:int;
		
		public function GameBackGround(name:String, params:Object = null)
		{
			super(name, params);
			_container = new Sprite();
			_view = _container;
			
			bgLayer1 = new BGLayer(1);
			bgLayer1.parallaxDepth = 0.5;
			_container.addChild(bgLayer1);
			
			buildingLayer4 = new BGLayer(4);
			buildingLayer4.y -= 80;
			buildingLayer4.parallaxDepth = 0.5;
			_container.addChild(buildingLayer4);
			
			buildingLayer3 = new BGLayer(3);
			buildingLayer3.y -= 50;
			buildingLayer3.parallaxDepth = 0.5;
			_container.addChild(buildingLayer3);
			
			buildingLayer2 = new BGLayer(2);
			buildingLayer2.parallaxDepth = 0.5;
			_container.addChild(buildingLayer2);
			
			
			trace(buildingLayer4.y, buildingLayer3.y, buildingLayer2.y);
			
			
		}
		
		public function get itemFlag():Boolean
		{
			return _itemFlag;
		}

		public function set itemFlag(value:Boolean):void
		{
			_itemFlag = value;
		}

		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			
			bgLayer1.x -= Math.ceil(_speedX * bgLayer1.parallaxDepth);
			bgLayer1.y -= Math.ceil(_speedY * bgLayer1.parallaxDepth);
			if(bgLayer1.x > 0) bgLayer1.x = -_ce.stage.stageWidth;
			if(bgLayer1.x < -_ce.stage.stageWidth)
			{
				bgLayer1.x = 0;
				trace("1 screen done");
				_itemFlag = true;
			}
			if(bgLayer1.y < 0)
			{
				bgLayer1.y = 0;
				_isGround = true;
			}
			
			buildingLayer2.x -= Math.ceil(_speedX * buildingLayer2.parallaxDepth);
			buildingLayer2.y -= Math.ceil(_speedY * buildingLayer2.parallaxDepth);
			if(buildingLayer2.x > 0) buildingLayer2.x = -_ce.stage.stageWidth;
			if(buildingLayer2.x < -_ce.stage.stageWidth) buildingLayer2.x = 0;
			if(buildingLayer2.y <= 0) buildingLayer2.y = 0;
			
			buildingLayer3.x -= Math.ceil(_speedX * buildingLayer3.parallaxDepth);
			buildingLayer3.y -= Math.ceil(_speedY * buildingLayer3.parallaxDepth);
			if(buildingLayer3.x > 0) buildingLayer3.x = -_ce.stage.stageWidth;
			if(buildingLayer3.x < -_ce.stage.stageWidth) buildingLayer3.x = 0;
			if(buildingLayer3.y <= -50) buildingLayer3.y = -50;
			
			buildingLayer4.x -= Math.ceil(_speedX * buildingLayer4.parallaxDepth);
			buildingLayer4.y -= Math.ceil(_speedY * buildingLayer4.parallaxDepth);
			if(buildingLayer4.x > 0) buildingLayer4.x = -_ce.stage.stageWidth;
			if(buildingLayer4.x < -_ce.stage.stageWidth) buildingLayer4.x = 0;
			if(buildingLayer4.y <= -80) buildingLayer4.y = -80;
			
			
		}
		
		public function get gamePaused():Boolean
		{
			return _gamePaused;
		}
		
		public function set gamePaused(value:Boolean):void
		{
			_gamePaused = value;
		}

		public function get speedY():Number
		{
			return _speedY;
		}

		public function set speedY(value:Number):void
		{
			_speedY = value;
		}

		public function get speedX():Number
		{
			return _speedX;
		}

		public function set speedX(value:Number):void
		{
			_speedX = value;
		}

		public function get isGround():Boolean
		{
			return _isGround;
		}

		public function set isGround(value:Boolean):void
		{
			_isGround = value;
		}
		public function get stage():int
		{
			return _stage;
		}
		
		public function set stage(value:int):void
		{
			_stage = value;
		}


	}
}