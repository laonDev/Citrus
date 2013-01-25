package
{
	import citrus.core.starling.StarlingState;
	import citrus.input.controllers.starling.VirtualButtons;
	
	public class SettingState extends StarlingState
	{
		private var setting:GameSetting;
		private var startBtn:VirtualButtons;
		
		public function SettingState()
		{
			super();
		}
		override public function initialize():void
		{
			super.initialize();
			
			var vb:VirtualButtons = new VirtualButtons("buttons",{buttonradius:40});
			vb.button1Action = "timeshift";
			vb.button1Channel = 16;
			vb.button2Action = "jump";
			
			setting = new GameSetting();
			this.addChild(setting);
			setting.massive = 6;
			setting.force = 40 * 6;	
			setting.degree = -45;
		}
	}
}