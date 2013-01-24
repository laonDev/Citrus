package {

    import Box2D.Collision.Shapes.b2PolygonShape;
    import Box2D.Common.Math.b2Vec2;
    
    import citrus.objects.Box2DPhysicsObject;
    import citrus.objects.platformer.box2d.Hero;

	/**
	 * @author Aymeric
	 * <p>This is a class created by the software http://www.physicseditor.de/</p>
	 * <p>Just select the CitrusEngine template, upload your png picture, set polygons and export.</p>
	 * <p>Be careful, the registration point is topLeft !</p>
	 * @param peObject : the name of the png file
	 */
    public class CatObject_2 extends Hero {
		
		[Inspectable(defaultValue="")]
		public var peObject:String = "";

		private var _tab:Array;
		private var _heightBuffer:Number = 0;
		public var _mobileInput:MobileInput;
		

		public function CatObject_2(name:String, params:Object = null) {

			super(name, params);
			this.jumpHeight = 2048;
			this.maxVelocity = 100;
//			_mobileInput = new MobileInput();
//			_mobileInput
		}

		public function get heightBuffer():Number
		{
			return _heightBuffer;
		}

		public function set heightBuffer(value:Number):void
		{
			_heightBuffer = value;
		}

		override public function destroy():void {

			super.destroy();
		}

		override public function update(timeDelta:Number):void 
		{
			if(this.body.GetLinearVelocity().x + this.x > 200)
				this.x = 200;
			if(this.body.GetLinearVelocity().y < 0 && this.body.GetLinearVelocity().y + this.y < 300)
			{
				this.y = 300;
				_heightBuffer += this.body.GetLinearVelocity().y;
//				trace("up",_heightBuffer, this.body.GetLinearVelocity().y);
			}
			if(this.body.GetLinearVelocity().y > 0 && _heightBuffer < 0)
			{
				this.y = 300;
				_heightBuffer += this.body.GetLinearVelocity().y;
//				this.x += this.body.GetLinearVelocity().x;
//				trace("down",_heightBuffer, this.body.GetLinearVelocity().y);
			}else
			{
//				this.body.SetLinearVelocity(new b2Vec2(this.body.GetLinearVelocity().x, 4));
//				trace("falling", this.body.GetLinearVelocity().y);
			}
			
//			var game:GameBackGround = _ce.getChildByName("bg") as GameBackGround;
//			trace(game);
//			if(this.body.GetLinearVelocity().y > 0 && _ce.getChildByName("bg")
//			if(this.body.GetLinearVelocity().y + this.y < 300)
//				this.y = 300;
			
		}
		public function set onGround(value:Boolean):void
		{
			this._onGround = value;			
		}
		override protected function defineFixture():void {
			
			super.defineFixture();
			
			_createVertices();

			_fixtureDef.density = _getDensity();
			_fixtureDef.friction = _getFriction();
			_fixtureDef.restitution = _getRestitution();
			
			for (var i:uint = 0; i < _tab.length; ++i) {
				var polygonShape:b2PolygonShape = new b2PolygonShape();
				polygonShape.SetAsArray(_tab[i]);
				_fixtureDef.shape = polygonShape;

				body.CreateFixture(_fixtureDef);
			}
		}
		
        protected function _createVertices():void {
			
			_tab = [];
			var vertices:Array= [];

			switch (peObject) {
				
				case "cat":
											
//			        vertices.push(new b2Vec2(291/_box2D.scale, 76/_box2D.scale));
//					vertices.push(new b2Vec2(321/_box2D.scale, 198/_box2D.scale));
//					vertices.push(new b2Vec2(297/_box2D.scale, 239/_box2D.scale));
//					vertices.push(new b2Vec2(209/_box2D.scale, 295/_box2D.scale));
//					vertices.push(new b2Vec2(121/_box2D.scale, 318/_box2D.scale));
//					vertices.push(new b2Vec2(81/_box2D.scale, 290/_box2D.scale));
//					vertices.push(new b2Vec2(47/_box2D.scale, 197/_box2D.scale));
//					vertices.push(new b2Vec2(125/_box2D.scale, 54/_box2D.scale));
					vertices.push(new b2Vec2(91/_box2D.scale, 33/_box2D.scale));
					vertices.push(new b2Vec2(79.2650909423828/_box2D.scale, 75.5905513763428/_box2D.scale));
					vertices.push(new b2Vec2(73/_box2D.scale, 21/_box2D.scale));
					vertices.push(new b2Vec2(87/_box2D.scale, 9/_box2D.scale));
					
					_tab.push(vertices);
					vertices = [];
					
					vertices.push(new b2Vec2(16/_box2D.scale, 49/_box2D.scale));
					vertices.push(new b2Vec2(57/_box2D.scale, 88/_box2D.scale));
					vertices.push(new b2Vec2(11/_box2D.scale, 84/_box2D.scale));
					vertices.push(new b2Vec2(6.29921245574951/_box2D.scale, 72.4409446716309/_box2D.scale));
					vertices.push(new b2Vec2(2/_box2D.scale, 49/_box2D.scale));
					
					_tab.push(vertices);
					vertices = [];
					
					vertices.push(new b2Vec2(46/_box2D.scale, 19/_box2D.scale));
					vertices.push(new b2Vec2(16/_box2D.scale, 49/_box2D.scale));
					vertices.push(new b2Vec2(28/_box2D.scale, 0/_box2D.scale));
					
					_tab.push(vertices);
					vertices = [];
					
					vertices.push(new b2Vec2(79.2650909423828/_box2D.scale, 75.5905513763428/_box2D.scale));
					vertices.push(new b2Vec2(91/_box2D.scale, 33/_box2D.scale));
					vertices.push(new b2Vec2(97/_box2D.scale, 47/_box2D.scale));
					vertices.push(new b2Vec2(94/_box2D.scale, 64/_box2D.scale));
					
					_tab.push(vertices);
					vertices = [];
					
					vertices.push(new b2Vec2(73/_box2D.scale, 21/_box2D.scale));
					vertices.push(new b2Vec2(79.2650909423828/_box2D.scale, 75.5905513763428/_box2D.scale));
					vertices.push(new b2Vec2(57/_box2D.scale, 88/_box2D.scale));
					vertices.push(new b2Vec2(16/_box2D.scale, 49/_box2D.scale));
					vertices.push(new b2Vec2(46/_box2D.scale, 19/_box2D.scale));
					
					_tab.push(vertices);
					vertices = [];
					
					vertices.push(new b2Vec2(11/_box2D.scale, 84/_box2D.scale));
					vertices.push(new b2Vec2(57/_box2D.scale, 88/_box2D.scale));
					vertices.push(new b2Vec2(26/_box2D.scale, 95/_box2D.scale));					
					_tab.push(vertices);
					
					break;
			
			}
		}

		protected function _getDensity():Number {

			switch (peObject) {
				
				case "cat":
					return 1;
					break;
			
			}

			return 1;
		}
		
		protected function _getFriction():Number {
			
			switch (peObject) {
				
				case "cat":
					return 0.6;
					break;
			
			}

			return 0.6;
		}
		
		protected function _getRestitution():Number {
			
			switch (peObject) {
				
				case "cat":
					return 0.3;
					break;
			
			}

			return 0.3;
		}
	}
}
