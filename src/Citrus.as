package
{
	import citrus.core.starling.StarlingCitrusEngine;
	
	import net.hires.debug.Stats;
	
	[SWF(width="1440", height="768", frameRate="60", backgroundColor="#cccccc")]
	public class Citrus extends StarlingCitrusEngine
	{
		private var stats:Stats;
		
		public function Citrus()
		{
			setUpStarling();
			stats = new Stats();
			addChild(stats);
			state = new GameSetting();
		}
	}
}