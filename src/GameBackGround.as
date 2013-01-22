package
{
	import citrus.objects.CitrusSprite;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameBackGround extends CitrusSprite
	{
		private var _container:Sprite;
		private var bgLayer1:BGLayer;
		private var _speedX:Number = 0;
		private var _speedY:Number = 0;
		private var _gamePaused:Boolean = false;
		private var _isGround:Boolean = false;
		private var _stage:int;
		
		public function GameBackGround(name:String, params:Object = null)
		{
			super(name, params);
			_container = new Sprite();
			_view = _container;
			
			bgLayer1 = new BGLayer(1);
			_container.addChild(bgLayer1);
		}

		
		
//		private function onEnterFrame(e:Event):void
//		{
//			bgLayer1.x -= _speedX;
//			if(bgLayer1.x > 0) bgLayer1.x = -stage.stageWidth;
//			if(bgLayer1.x < -stage.stageWidth) bgLayer1.x = 0;
//			
//		}
//		public function initialize():void
//		{
//			bgLayer1.x = 0;
//			bgLayer1.y =  -stage.stageHeight;
//		}
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
//			trace(bgLayer1.y, speedY);
			bgLayer1.x -= Math.ceil(_speedX);
			bgLayer1.y -= Math.ceil(_speedY);
			if(bgLayer1.x > 0) bgLayer1.x = -_ce.stage.stageWidth;
			if(bgLayer1.x < -_ce.stage.stageWidth) bgLayer1.x = 0;
//			bgLayer1.y += _speedY;
//			trace(_isGround);
//			bgLayer1.y = _speedY;
//			if(bgLayer1.y <= 0)
//			{
//				bgLayer1.y = 0;
//				_isGround = true; 
//			}else
//			{
//				_isGround = false;
//			}
//			if(bgLayer1.y < -stage
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