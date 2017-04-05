package com.gerantech.towercraft.models.towers
{
	public class RapidTower extends CommonTower
	{		
		public function RapidTower(level:int = 1, chosenBase:int = -1)
		{
			super(level);
			type = TYPE_RAPID;
		}

		override public function get troopSpeed():Number
		{
			return 0.12 + level/18;
		}
	}
}