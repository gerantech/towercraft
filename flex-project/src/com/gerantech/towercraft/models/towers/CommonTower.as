package com.gerantech.towercraft.models.towers
{
	public class CommonTower extends Tower
	{
		
		public function CommonTower(level:int = 1, chosenBase:int = -1)
		{
			super(level);
			type = TYPE_COMMON;
		}
		
		override protected function get maxLevel():Number
		{
			return 10;
		}

		override public function get capacity():int
		{
			return 9 + level;
		}
		
		override public function get snipedPerSecond():Number
		{
			return 1 + level/10;
		}
		
		override public function get spawnPerSecond():Number
		{
			return 1.1 + level/10;
		}
		
		override public function get suicideDamage():Number
		{
			return 1.1 + level/12;
		}
		
		override public function get troopSpeed():Number
		{
			return 0.8 + level/18;
		}
	}
}