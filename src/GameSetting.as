package
{
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import citrus.core.starling.StarlingState;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameSetting extends StarlingState
	{
		private const LABEL_X:int = 150;
		private const LABEL_Y:int = 220;
		private const TEXT_X:int = 150;
		private const TEXT_Y:int = 275;
		//massive
		private var _massive:int;
		//degree
		private var _degree:int; 
		//force
		private var _force:int;
		//gravity
		private var _gravity:Number;
		
		//textfields
		private var massiveLabel:TextField;
		private var massiveText:TextField;
		private var degreeLabel:TextField;
		private var degreeText:TextField;
		private var forceLabel:TextField;
		private var forceText:TextField;
		private var gravityLabel:TextField;
		private var gravityText:TextField;
		
		public function GameSetting()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			massiveLabel = new TextField();
			massiveLabel.x = 150;
			massiveLabel.y = 220;
			massiveLabel.text = "Massive(kg)";
			Starling.current.nativeOverlay.addChild(massiveLabel);
			
			massiveText = new TextField();
			massiveText.x = 250;
			massiveText.y = 220;
			massiveText.height = 20;
			massiveText.border = true;
			massiveText.type = TextFieldType.INPUT;
			Starling.current.nativeOverlay.addChild(massiveText);
			
			degreeLabel = new TextField();
			degreeLabel.x = 150;
			degreeLabel.y = 275;
			degreeLabel.text = "Degree";
			Starling.current.nativeOverlay.addChild(degreeLabel);
			
			degreeText = new TextField();
			degreeText.x = 250;
			degreeText.y = 275;
			degreeText.height = 20;
			degreeText.border = true;
			degreeText.type = TextFieldType.INPUT;
			Starling.current.nativeOverlay.addChild(degreeText);
			
			forceLabel = new TextField();
			forceLabel.x = 350;
			forceLabel.y = 220;
			forceLabel.text = "Force(F*t)";
			Starling.current.nativeOverlay.addChild(forceLabel);
			
			forceText = new TextField();
			forceText.x = 450;
			forceText.y = 220;
			forceText.height = 20;
			forceText.border = true;
			forceText.type = TextFieldType.INPUT;
			Starling.current.nativeOverlay.addChild(forceText);
			
//			gravityLabel = new TextField();
//			gravityLabel.x = 350;
//			gravityLabel.y = 275;
//			gravityLabel.text = "Gravity";
//			Starling.current.nativeOverlay.addChild(gravityLabel);
//			
//			gravityText = new TextField();
//			gravityText.x = 450;
//			gravityText.y = 275;
//			gravityText.height = 20;
//			gravityText.border = true;
//			gravityText.type = TextFieldType.INPUT;
//			Starling.current.nativeOverlay.addChild(gravityText);
			
			
		}
		public function temporaryDipose():void
		{
			trace(Starling.current.nativeOverlay.y);
			setView(-300, false);			
		}
		
		override public function initialize():void
		{
			setView(0, true);
		}
		private function setView($nativeOverayY:int, $visible:Boolean):void
		{
//			TweenLite.to(Starling.current.nativeOverlay, 1.5, {y:$nativeOverayY, onComplete:this.tweenComplete, onCompleteParams:[$visible]});
			Starling.current.nativeOverlay.visible = $visible;
		}
		public function tweenComplete($visible:Boolean):void
		{
			Starling.current.nativeOverlay.visible = $visible;
		}
		public function get massive():int
		{
			_massive = int(massiveText.text);
			return _massive;
		}

		public function set massive(value:int):void
		{
			_massive = value;
			massiveText.text = _massive.toString();
		}

		public function get degree():int
		{
			_degree = int(degreeText.text);
			return _degree;
		}

		public function set degree(value:int):void
		{
			_degree = value;
			degreeText.text = _degree.toString();
		}

		public function get force():int
		{
			_force = int(forceText.text);
			return _force;
		}

		public function set force(value:int):void
		{
			_force = value;
			forceText.text = _force.toString();
		}

		public function get gravity():Number
		{
			_gravity = int(gravityText.text);
			return _gravity;
		}

		public function set gravity(value:Number):void
		{
			_gravity = value;
			gravityText.text = _gravity.toString();
		}

	}
}