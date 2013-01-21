package
{
	import citrus.core.starling.StarlingCitrusEngine;
	
	[SWF(width="1440", height="768", frameRate="60", backgroundColor="#cccccc")]
	public class Citrus extends StarlingCitrusEngine
	{
		public function Citrus()
		{
			setUpStarling();
			state = new GameStats();
		}
	}
}