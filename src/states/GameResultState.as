package states
{
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class GameResultState extends StarlingState
	{
//		private var _candy:int;
//		private var _tuna:int;
//		private var _fishBread:int;
		
		private var lbCandy:TextField
		private var tfCandy:TextField;
		private var lbTuna:TextField;
		private var tfTuna:TextField;
		private var lbFishBread:TextField;
		private var tfFishBread:TextField;
		private var lbDistance:TextField;
		private var tfDistance:TextField;
		private var againBtn:Button;
		
		public function GameResultState()
		{
			super();
			lbCandy = new TextField(150, 20, "Candy");
			tfCandy = new TextField(150, 20, "");
			lbTuna = new TextField(150, 20, "Tuna");
			tfTuna = new TextField(150, 20, "");
			lbDistance = new TextField(150, 20, "Distance");
			tfDistance= new TextField(150, 20, "");
			lbFishBread = new TextField(150, 20, "FishBread");
			tfFishBread = new TextField(150, 20, "");
			
		}
		override public function initialize():void
		{
			super.initialize();
			
			lbCandy.x = 150;
			lbCandy.y = 50;
			this.addChild(lbCandy);
			
			tfCandy.x = lbCandy.x + lbCandy.width;
			tfCandy.y = lbCandy.y;
			this.addChild(tfCandy);
			
			lbTuna.x = 150;
			lbTuna.y = lbCandy.y + lbCandy.height + 10;
			this.addChild(lbTuna);
			
			tfTuna.x = tfCandy.x;
			tfTuna.y = lbTuna.y;
			this.addChild(tfTuna);
			
			lbFishBread.x = 150;
			lbFishBread.y = lbTuna.y + lbTuna.height + 10;
			this.addChild(lbFishBread);
			
			tfFishBread.x = tfCandy.x;
			tfFishBread.y = lbFishBread.y;
			this.addChild(tfFishBread);
			
			lbDistance.x = 150;
			lbDistance.y = lbFishBread.y + lbFishBread.height + 10;
			this.addChild(lbDistance);
			
			tfDistance.x = tfCandy.x;
			tfDistance.y = lbDistance.y;
			this.addChild(tfDistance);
			
			againBtn = new Button(Assets.getAtlas().getTexture("cat_increase"));
			againBtn.x = 450;
			againBtn.y = 100;
			againBtn.addEventListener(Event.TRIGGERED, againClick);
			this.addChild(againBtn);
				
		}
		public function setValue($candy:int, $tuna:int, $fishBread:int, $distance:Number):void
		{
			tfCandy.text = $candy.toString();
			tfTuna.text = $tuna.toString();
			tfFishBread.text = $fishBread.toString();
			tfDistance.text = $distance.toFixed(2);
		}
		private function againClick(e:Event):void
		{
			
			CitrusEngine.getInstance().state = new GameSetting();
			this.destroy();
		}

		
	}
}