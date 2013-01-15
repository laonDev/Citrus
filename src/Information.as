package
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class Information extends Sprite
	{
		private var _distance:Number;
		private var _speed:Number;
		private var _altitude:Number;
		
		private var distanceLabel:TextField;
		private var distanceText:TextField;
		private var speedLabel:TextField;
		private var speedText:TextField;
		private var altitudeLabel:TextField;
		private var altitudeText:TextField;
		
		public function Information()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			distanceLabel = new TextField(150, 20, "Distance(m)");
			distanceLabel.x = 150;
			distanceLabel.y = 5;
			this.addChild(distanceLabel);
			
			distanceText = new TextField(150, 75, "0");
			distanceText.width = distanceLabel.width;
			distanceText.x = int(distanceLabel.x + distanceLabel.width - distanceText.width);
			distanceText.y = distanceLabel.y + distanceLabel.height;
			this.addChild(distanceText);
			
			speedLabel = new TextField(150, 20, "Speed(m/s)");
			speedLabel.x = int(distanceLabel.x + speedLabel.width - 50);
			speedLabel.y = 5;
			this.addChild(speedLabel);
			
			speedText = new TextField(150, 75, "0");
			speedText.width = speedLabel.width;
			speedText.x = int(speedLabel.x + speedLabel.width - speedText.width);
			speedText.y = speedLabel.y + speedLabel.height;
			this.addChild(speedText);
			
			altitudeLabel = new TextField(150, 20, "Altitude(m)");
			altitudeLabel.x = int(speedLabel.x + altitudeLabel.width - 50);
			altitudeLabel.y = 5;
			this.addChild(altitudeLabel);
			
			altitudeText = new TextField(150, 75, "0");
			altitudeText.width = altitudeLabel.width;
			altitudeText.x = int(altitudeLabel.x + altitudeLabel.width - altitudeText.width);
			altitudeText.y = altitudeLabel.y + altitudeLabel.height;
			this.addChild(altitudeText);
		}
		
		public function get speed():Number
		{
			return _speed;
		}

		public function set speed(value:Number):void
		{
			_speed = value;
			speedText.text = _speed.toFixed(1);
		}

		public function get distance():Number
		{
			return _distance;
		}

		public function set distance(value:Number):void
		{
			_distance = value;
			distanceText.text = _distance.toFixed(2);
		}
		
		public function get altitude():Number
		{
			return _altitude;
		}
		
		public function set altitude(value:Number):void
		{
			_altitude = value;
			if( _altitude < 0)
				_altitude = 0;
			altitudeText.text = _altitude.toFixed(2);
		}

	}
}