package
{
	import Box2D.Common.Math.b2Vec2;
	
	import citrus.objects.platformer.box2d.Hero;
	
	public class ChildHero extends Hero
	{
		public var jumpDecceleration:Number = 0.03;
		public var _mobileInput:MobileInput;
		
		public function ChildHero(name:String, params:Object=null)
		{
			super(name, params);
			
			_mobileInput = new MobileInput();
			_mobileInput.initialize();
		}
		override public function destroy():void
		{
			_mobileInput.destroy();
			super.destroy();
		}
		override public function update(timeDelta:Number):void
		{
//			var velocity:b2Vec2 = _body.GetLinearVelocity();
			
//			if(_mobileInput.screenTouched)
//			{
//				velocity.x = 10 *Math.cos(-30);
//				velocity.y = -(10 *Math.sin(-30));
//				if(_onGround)
//				{
//					velocity.y = -jumpHeight;
//					_onGround = false;
//				}else if(velocity.y < 0)
//					velocity.y -= jumpAcceleration;
//				else
//					velocity.y -= jumpDecceleration;
//			}
//			_body.SetLinearVelocity(velocity);
			updateAnimantion();
			
		}
		
		private function updateAnimantion():void
		{
			// TODO Auto Generated method stub
			
		}
	}
}