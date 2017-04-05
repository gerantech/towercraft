package com.gerantech.towercraft.models.towers
{
	public class BomberTower extends Tower
	{
		public function BomberTower(level:int=1)
		{
			super(level);
			type = TYPE_BOMBER;
		}
	}
}