package objectPool
{
	import item.Candy;

	public class PoolCandy
	{
		private var _minSize:int;
		private var _maxSize:int;
		public var size:int = 0;
		public var create:Function;
		public var clean:Function;
		public var length:int = 0;
		private var list:Vector.<Candy> = new Vector.<Candy>();
		private var disposed:Boolean = false;
		
		public function PoolCandy($create:Function, $clean:Function = null, $minSize:int = 50, $maxSize:int = 200)
		{
			create = $create;
			clean = $clean;
			minSize = $minSize;
			maxSize = $maxSize;
			
			for(var i:int = 0; i < minSize; ++i) add();
			
		}
		
		private function add():void
		{
			// TODO Auto Generated method stub
			list[length++] = create();
			size++;
		}
		
		public function get maxSize():int
		{
			return _maxSize;
		}

		public function set maxSize(value:int):void
		{
			_maxSize = value;
			if(_maxSize < list.length) list.splice(_maxSize, 1);
			size = list.length;
			if(_maxSize < _minSize) _minSize = _maxSize;
		}

		public function get minSize():int
		{
			return _minSize;
		}

		public function set minSize(value:int):void
		{
			_minSize = value;
			if(_minSize > _maxSize) _maxSize = _minSize;
			if(_minSize < list.length) list.splice(_maxSize, 1);
			size = list.length;
		}

		public function checkOut():Candy
		{
			if(length == 0)
				if(size < maxSize)
				{
					size++;
					return create();
				}else
				{
					return null;
				}
			return list[--length];
		}
		public function checkIn($candy:Candy):void
		{
			if(clean != null)
				clean($candy);
			list[length++] = $candy;
		}
		public function dispose():void
		{
			if(dispose)
				return;
			disposed = true;
			
			create = null;
			clean = null;
			list = null;
		}
		
	}
}