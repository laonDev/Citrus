package item
{
	import citrus.objects.platformer.box2d.Coin;
	
	public class Candy extends Coin
	{
		public function Candy(name:String, params:Object=null)
		{
			super(name, params);
		}
		override public function update(timeDelta:Number):void
		{
			
		}
	}
}