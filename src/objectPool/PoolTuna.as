package objectPool
{
	import item.Tuna;

	public class PoolTuna
	{
		private var _minSize:int;
		private var _maxSize:int;
		public var size:int = 0;
		public var create:Function;
		public var clean:Function;
		public var length:int = 0;
		private var list:Vector.<Tuna> = new Vector.<Tuna>();
		private var disposed:Boolean = false;
		
		public function PoolTuna($create:Function, $clean:Function = null, $minSize:int = 30, $maxSize:int = 100)
		{
			create = $create;
			clean = $clean;
			minSize = $minSize;
			maxSize = $maxSize;
			
			for(var i:int = 0; i < minSize; ++i)
				add();
		}
		
		private function add():void
		{
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
		}

		public function get minSize():int
		{
			return _minSize;
		}

		public function set minSize(value:int):void
		{
			_minSize = value;
		}
		public function checkOut():Tuna
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
		public function checkIn($tuna:Tuna):void
		{
			if(clean != null)
				clean($tuna);
			list[length++] = $tuna;
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