package {

    import Box2DAS.Collision.Shapes.b2PolygonShape;
	import Box2DAS.Common.V2;

	import com.citrusengine.objects.PhysicsObject;

	/**
	 * @author Aymeric
	 * <p>This is a class created by the software http://www.physicseditor.de/</p>
	 * <p>Just select the CitrusEngine template, upload your png picture, set polygons and export.</p>
	 * <p>Be careful, the registration point is topLeft !</p>
	 * @param peObject : the name of the png file
	 */
    public class PhysicsEditorObjects extends PhysicsObject {
		
		[Inspectable(defaultValue="")]
		public var peObject:String = "";

		private var _tab:Array;

		public function PhysicsEditorObjects(name:String, params:Object = null) {

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
				polygonShape.Set(_tab[i]);
				_fixtureDef.shape = polygonShape;

				body.CreateFixture(_fixtureDef);
			}
		}
		
        protected function _createVertices():void {
			
			_tab = [];
			var vertices:Vector.<V2> = new Vector.<V2>();

			switch (peObject) {
				
				case "cat":
											
			        vertices.push(new V2(91/_box2D.scale, 33/_box2D.scale));
					vertices.push(new V2(79.2650909423828/_box2D.scale, 75.5905513763428/_box2D.scale));
					vertices.push(new V2(73/_box2D.scale, 21/_box2D.scale));
					vertices.push(new V2(87/_box2D.scale, 9/_box2D.scale));
					
					_tab.push(vertices);
					vertices = new Vector.<V2>();
											
			        vertices.push(new V2(16/_box2D.scale, 49/_box2D.scale));
					vertices.push(new V2(57/_box2D.scale, 88/_box2D.scale));
					vertices.push(new V2(11/_box2D.scale, 84/_box2D.scale));
					vertices.push(new V2(6.29921245574951/_box2D.scale, 72.4409446716309/_box2D.scale));
					vertices.push(new V2(2/_box2D.scale, 49/_box2D.scale));
					
					_tab.push(vertices);
					vertices = new Vector.<V2>();
											
			        vertices.push(new V2(46/_box2D.scale, 19/_box2D.scale));
					vertices.push(new V2(16/_box2D.scale, 49/_box2D.scale));
					vertices.push(new V2(28/_box2D.scale, 0/_box2D.scale));
					
					_tab.push(vertices);
					vertices = new Vector.<V2>();
											
			        vertices.push(new V2(79.2650909423828/_box2D.scale, 75.5905513763428/_box2D.scale));
					vertices.push(new V2(91/_box2D.scale, 33/_box2D.scale));
					vertices.push(new V2(97/_box2D.scale, 47/_box2D.scale));
					vertices.push(new V2(94/_box2D.scale, 64/_box2D.scale));
					
					_tab.push(vertices);
					vertices = new Vector.<V2>();
											
			        vertices.push(new V2(73/_box2D.scale, 21/_box2D.scale));
					vertices.push(new V2(79.2650909423828/_box2D.scale, 75.5905513763428/_box2D.scale));
					vertices.push(new V2(57/_box2D.scale, 88/_box2D.scale));
					vertices.push(new V2(16/_box2D.scale, 49/_box2D.scale));
					vertices.push(new V2(46/_box2D.scale, 19/_box2D.scale));
					
					_tab.push(vertices);
					vertices = new Vector.<V2>();
											
			        vertices.push(new V2(11/_box2D.scale, 84/_box2D.scale));
					vertices.push(new V2(57/_box2D.scale, 88/_box2D.scale));
					vertices.push(new V2(26/_box2D.scale, 95/_box2D.scale));
					
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
