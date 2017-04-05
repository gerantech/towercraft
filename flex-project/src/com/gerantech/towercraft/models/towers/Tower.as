package com.gerantech.towercraft.models.towers
{
	import flash.utils.Dictionary;
	import flash.utils.setInterval;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;

	public class Tower extends EventDispatcher
	{
		public static const TYPE_COMMON:int = 0;
		public static const TYPE_RAPID:int = 1;
		public static const TYPE_SNIPER:int = 2;
		public static const TYPE_BOMBER:int = 3;
		public static const TYPE_CANNON:int = 4;
		public static const TYPE_LAZER:int = 5;
	
		public var features:Dictionary;
		public var type:int = -1;
		
		public var troopType:int;
		public var troops:Vector.<int>;

		public function Tower(level:int = 1)
		{
			this.level = level;
			
			features = new Dictionary()
			features["capacity"] = capacity;
			features["suicideDamage"] = suicideDamage;
			features["snipedPerSecond"] = snipedPerSecond;
			features["troopSpeed"] = troopSpeed;
			features["spawnPerSecond"] = spawnPerSecond;
		}
		

		private var _level:uint = 1;
		public function get level():uint
		{
			return _level;
		}
		public function set level(value:uint):void
		{
			_level = Math.max(1, Math.min(maxLevel, value));
		}

		protected function get maxLevel():Number
		{
			return 10;
		}
		public function get capacity():int
		{
			return 10;
		}
		public function get suicideDamage():Number
		{
			return 2.2;
		}
		public function get snipedPerSecond():Number
		{
			return 2.2;
		}
		public function get troopSpeed():Number
		{
			return 0.9;
		}
		public function get spawnPerSecond():Number
		{
			return 1.0;
		}
		
		public function get upgradeCost():uint
		{
			return 10 * Math.pow(2, level) / 2;
		}
	
		
		public function createEngine(troopType:uint):void
		{
			this.troopType = troopType;
			troops = new Vector.<int>();
			for(var i:uint=0; i<capacity; i++)
				troops.push(troopType);
			
			updateView(true);
			setInterval(calculatePopulation, spawnPerSecond*1000);
		}
		
		private function calculatePopulation():void
		{
			if(population < capacity)
				troops.push(troopType);
			else if(population > capacity)
				troops.pop();
			
			updateView();
		}
		
		private function updateView(force:Boolean=false):void
		{
			if(population == 0)
				return;
			
			var isForce:Boolean = troops[0] != troopType || force;
			if(isForce)
				troopType = troops[0];
			
			dispatchEventWith(Event.UPDATE, false, isForce);
		}
		
		public function popTroop():void
		{
			troops.pop();
			updateView();
		}
		public function pushTroops(len:uint, troopType:int):void
		{
			var _population:uint = population;
			if(troopType == this.troopType || _population==0)
			{
				for(var i:uint=0; i<len; i++)
					troops.push(troopType);
			}
			else
			{
				if(len >= _population)
				{
					troops.splice(0, _population);
					for(i=0; i<len-_population; i++)
						troops.push(troopType);
				}
				else
				{
					for(i=0; i<len; i++)
						troops.pop();
				}
			}
			if(population == 0)
				troops.push(troopType);
			updateView();
		}
		
		public function get population():uint
		{
			return troops.length;
		}
	}
}