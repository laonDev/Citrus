package {

    import Box2D.Collision.Shapes.b2PolygonShape;
    import Box2D.Common.Math.b2Vec2;
    
    import citrus.objects.platformer.box2d.Crate;

	/**
	 * @author Aymeric
	 * <p>This is a class created by the software http://www.physicseditor.de/</p>
	 * <p>Just select the CitrusEngine template, upload your png picture, set polygons and export.</p>
	 * <p>Be careful, the registration point is topLeft !</p>
	 * @param peObject : the name of the png file
	 */
    public class CatObject extends Crate {
		
		[Inspectable(defaultValue="")]
		public var peObject:String = "";

		private var _tab:Array;

		public function CatObject(name:String, params:Object = null) {

			super(name, params);
		}

		override public function destroy():void {

			super.destroy();
		}

		override public function update(timeDelta:Number):void {

			super.update(timeDelta);
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
			var vertices:Array = [];

			switch (peObject) {
				
				case "cat":
											
			        vertices.push(new b2Vec2(299.5/_box2D.scale, 143/_box2D.scale));
					vertices.push(new b2Vec2(250/_box2D.scale, 110.5/_box2D.scale));
					vertices.push(new b2Vec2(290/_box2D.scale, 71.5/_box2D.scale));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(new b2Vec2(114.5/_box2D.scale, 307/_box2D.scale));
					vertices.push(new b2Vec2(122/_box2D.scale, 303.5/_box2D.scale));
					vertices.push(new b2Vec2(202.5/_box2D.scale, 273/_box2D.scale));
					vertices.push(new b2Vec2(190/_box2D.scale, 285.5/_box2D.scale));
					vertices.push(new b2Vec2(167/_box2D.scale, 304.5/_box2D.scale));
					vertices.push(new b2Vec2(134/_box2D.scale, 312.5/_box2D.scale));
					vertices.push(new b2Vec2(119/_box2D.scale, 313.5/_box2D.scale));
					vertices.push(new b2Vec2(115/_box2D.scale, 311.5/_box2D.scale));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(new b2Vec2(79.5/_box2D.scale, 279/_box2D.scale));
					vertices.push(new b2Vec2(92/_box2D.scale, 274.5/_box2D.scale));
					vertices.push(new b2Vec2(109.5/_box2D.scale, 287/_box2D.scale));
					vertices.push(new b2Vec2(88/_box2D.scale, 288.5/_box2D.scale));
					vertices.push(new b2Vec2(83/_box2D.scale, 287.5/_box2D.scale));
					vertices.push(new b2Vec2(79/_box2D.scale, 284.5/_box2D.scale));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(new b2Vec2(214.5/_box2D.scale, 294/_box2D.scale));
					vertices.push(new b2Vec2(211/_box2D.scale, 295.5/_box2D.scale));
					vertices.push(new b2Vec2(204/_box2D.scale, 294.5/_box2D.scale));
					vertices.push(new b2Vec2(195.5/_box2D.scale, 286/_box2D.scale));
					vertices.push(new b2Vec2(202.5/_box2D.scale, 273/_box2D.scale));
					vertices.push(new b2Vec2(216/_box2D.scale, 283.5/_box2D.scale));
					vertices.push(new b2Vec2(217.5/_box2D.scale, 290/_box2D.scale));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(new b2Vec2(75/_box2D.scale, 237.5/_box2D.scale));
					vertices.push(new b2Vec2(92/_box2D.scale, 274.5/_box2D.scale));
					vertices.push(new b2Vec2(76/_box2D.scale, 268.5/_box2D.scale));
					vertices.push(new b2Vec2(65.5/_box2D.scale, 258/_box2D.scale));
					vertices.push(new b2Vec2(63.5/_box2D.scale, 253/_box2D.scale));
					vertices.push(new b2Vec2(63.5/_box2D.scale, 244/_box2D.scale));
					vertices.push(new b2Vec2(67.5/_box2D.scale, 239/_box2D.scale));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(new b2Vec2(140.5/_box2D.scale, 64/_box2D.scale));
					vertices.push(new b2Vec2(140.5/_box2D.scale, 65/_box2D.scale));
					vertices.push(new b2Vec2(123/_box2D.scale, 301.5/_box2D.scale));
					vertices.push(new b2Vec2(97/_box2D.scale, 203.5/_box2D.scale));
					vertices.push(new b2Vec2(102.5/_box2D.scale, 156/_box2D.scale));
					vertices.push(new b2Vec2(125.5/_box2D.scale, 50/_box2D.scale));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(new b2Vec2(75/_box2D.scale, 237.5/_box2D.scale));
					vertices.push(new b2Vec2(97/_box2D.scale, 203.5/_box2D.scale));
					vertices.push(new b2Vec2(109.5/_box2D.scale, 287/_box2D.scale));
					vertices.push(new b2Vec2(92/_box2D.scale, 274.5/_box2D.scale));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(new b2Vec2(109.5/_box2D.scale, 287/_box2D.scale));
					vertices.push(new b2Vec2(97/_box2D.scale, 203.5/_box2D.scale));
					vertices.push(new b2Vec2(123/_box2D.scale, 301.5/_box2D.scale));
					vertices.push(new b2Vec2(115/_box2D.scale, 295.5/_box2D.scale));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(new b2Vec2(190/_box2D.scale, 285.5/_box2D.scale));
					vertices.push(new b2Vec2(202.5/_box2D.scale, 273/_box2D.scale));
					vertices.push(new b2Vec2(195.5/_box2D.scale, 286/_box2D.scale));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(new b2Vec2(73/_box2D.scale, 193.5/_box2D.scale));
					vertices.push(new b2Vec2(84/_box2D.scale, 196.5/_box2D.scale));
					vertices.push(new b2Vec2(62.5/_box2D.scale, 206/_box2D.scale));
					vertices.push(new b2Vec2(51/_box2D.scale, 196.5/_box2D.scale));
					vertices.push(new b2Vec2(49.5/_box2D.scale, 193/_box2D.scale));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(new b2Vec2(84/_box2D.scale, 196.5/_box2D.scale));
					vertices.push(new b2Vec2(97/_box2D.scale, 203.5/_box2D.scale));
					vertices.push(new b2Vec2(75/_box2D.scale, 237.5/_box2D.scale));
					vertices.push(new b2Vec2(69.5/_box2D.scale, 227/_box2D.scale));
					vertices.push(new b2Vec2(62.5/_box2D.scale, 206/_box2D.scale));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(new b2Vec2(167/_box2D.scale, 304.5/_box2D.scale));
					vertices.push(new b2Vec2(190/_box2D.scale, 285.5/_box2D.scale));
					vertices.push(new b2Vec2(179.5/_box2D.scale, 297/_box2D.scale));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(new b2Vec2(312.5/_box2D.scale, 210/_box2D.scale));
					vertices.push(new b2Vec2(305.5/_box2D.scale, 224/_box2D.scale));
					vertices.push(new b2Vec2(299.5/_box2D.scale, 232/_box2D.scale));
					vertices.push(new b2Vec2(203/_box2D.scale, 270.5/_box2D.scale));
					vertices.push(new b2Vec2(250/_box2D.scale, 110.5/_box2D.scale));
					vertices.push(new b2Vec2(312.5/_box2D.scale, 164/_box2D.scale));
					vertices.push(new b2Vec2(315.5/_box2D.scale, 175/_box2D.scale));
					vertices.push(new b2Vec2(316.5/_box2D.scale, 192/_box2D.scale));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(new b2Vec2(102.5/_box2D.scale, 156/_box2D.scale));
					vertices.push(new b2Vec2(97/_box2D.scale, 203.5/_box2D.scale));
					vertices.push(new b2Vec2(95.5/_box2D.scale, 192/_box2D.scale));
					vertices.push(new b2Vec2(96.5/_box2D.scale, 175/_box2D.scale));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(new b2Vec2(312.5/_box2D.scale, 164/_box2D.scale));
					vertices.push(new b2Vec2(250/_box2D.scale, 110.5/_box2D.scale));
					vertices.push(new b2Vec2(299.5/_box2D.scale, 143/_box2D.scale));
					vertices.push(new b2Vec2(306.5/_box2D.scale, 152/_box2D.scale));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(new b2Vec2(264/_box2D.scale, 258.5/_box2D.scale));
					vertices.push(new b2Vec2(245/_box2D.scale, 265.5/_box2D.scale));
					vertices.push(new b2Vec2(226/_box2D.scale, 269.5/_box2D.scale));
					vertices.push(new b2Vec2(203/_box2D.scale, 270.5/_box2D.scale));
					vertices.push(new b2Vec2(299.5/_box2D.scale, 232/_box2D.scale));
					vertices.push(new b2Vec2(280/_box2D.scale, 249.5/_box2D.scale));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(new b2Vec2(248/_box2D.scale, 110.5/_box2D.scale));
					vertices.push(new b2Vec2(123/_box2D.scale, 301.5/_box2D.scale));
					vertices.push(new b2Vec2(180.5/_box2D.scale, 106/_box2D.scale));
					vertices.push(new b2Vec2(210/_box2D.scale, 103.5/_box2D.scale));
					vertices.push(new b2Vec2(230/_box2D.scale, 105.5/_box2D.scale));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(new b2Vec2(122/_box2D.scale, 303.5/_box2D.scale));
					vertices.push(new b2Vec2(203/_box2D.scale, 270.5/_box2D.scale));
					vertices.push(new b2Vec2(202.5/_box2D.scale, 273/_box2D.scale));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(new b2Vec2(122/_box2D.scale, 303.5/_box2D.scale));
					vertices.push(new b2Vec2(123/_box2D.scale, 301.5/_box2D.scale));
					vertices.push(new b2Vec2(248/_box2D.scale, 110.5/_box2D.scale));
					vertices.push(new b2Vec2(250/_box2D.scale, 110.5/_box2D.scale));
					vertices.push(new b2Vec2(203/_box2D.scale, 270.5/_box2D.scale));
					
					_tab.push(vertices);
					vertices = [];
											
			        vertices.push(new b2Vec2(123/_box2D.scale, 301.5/_box2D.scale));
					vertices.push(new b2Vec2(140.5/_box2D.scale, 65/_box2D.scale));
					vertices.push(new b2Vec2(180.5/_box2D.scale, 106/_box2D.scale));
					
					_tab.push(vertices);
					
					break;
			
			}
		}

		protected function _getDensity():Number {

			switch (peObject) {
				
				case "cat":
					return 2;
					break;
			
			}

			return 1;
		}
		
		protected function _getFriction():Number {
			
			switch (peObject) {
				
				case "cat":
					return 0;
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
