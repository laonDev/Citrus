package 
{
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class BGLayer extends Sprite
	{
		private var _layer:int;
		private var upperImage1:Image;
		private var upperImage2:Image;
		private var lowerImage1:Image;
		private var lowerImage2:Image;
		
		public function BGLayer($layer:int = 0) 
		{
			super();
			_layer = $layer;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			if(_layer == 1)
			{
				upperImage1 = new Image(Assets.getTexture("BG2"));
				upperImage2 = new Image(Assets.getTexture("BG2"));
				lowerImage1 = new Image(Assets.getTexture("BG1"));
				lowerImage2 = new Image(Assets.getTexture("BG1"));
//				upperImage1 = new Image(Assets.getTexture("Sky" + _layer));
//				upperImage2 = new Image(Assets.getTexture("Sky" + _layer));
//				lowerImage1 = new Image(Assets.getTexture("Sky" + _layer));
//				lowerImage2 = new Image(Assets.getTexture("Sky" + _layer));
			}else
			{
				trace("layer " + _layer + "need additional layer resources");
			}
			lowerImage1.x = 0;
			lowerImage1.y = stage.stageHeight - lowerImage1.height;
			upperImage1.x = 0;
			upperImage1.y = lowerImage1.y - upperImage1.height;
			
			lowerImage2.x = lowerImage2.width;
			lowerImage2.y = lowerImage1.y;
			
			upperImage2.x = lowerImage2.x;
			upperImage2.y = upperImage1.y;
			
			this.addChild(lowerImage1);
			this.addChild(upperImage1);
			this.addChild(lowerImage2);
			this.addChild(upperImage2);
		}
		
		
		public function get layer():int
		{
			return _layer;
		}

		public function set layer(value:int):void
		{
			_layer = value;
		}

	}
}