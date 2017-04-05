package com.gerantech.towercraft.models.towers
{
	public class SniperTower extends CommonTower
	{
		public function SniperTower(level:int=1, chosenBase:int=-1)
		{
			super(level, chosenBase);
			type = TYPE_SNIPER;
		}
		public override function get capacity():int
		{
			return 15 + level;
		}
	}
}