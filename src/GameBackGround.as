package
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameBackGround extends Sprite
	{
		private var bgLayer1:BGLayer;
		private var _speedX:Number = 0;
		private var _speedY:Number = 0;
		private var _gamePaused:Boolean = false;
		private var _isGround:Boolean = false;
		
		public function GameBackGround()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			bgLayer1 = new BGLayer(1);
			this.addChild(bgLayer1);
			
//			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
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
		public function update():void
		{
//			bgLayer1.x -= _speedX;
			bgLayer1.x = _speedX;
			if(bgLayer1.x > 0) bgLayer1.x = -stage.stageWidth;
			if(bgLayer1.x < -stage.stageWidth) bgLayer1.x = 0;
//			bgLayer1.y += _speedY;
			trace(_isGround);
			bgLayer1.y = _speedY;
			if(bgLayer1.y <= 0)
			{
				bgLayer1.y = 0;
				_isGround = true; 
			}else
			{
				_isGround = false;
			}
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


	}
}