package com.gerantech.towercraft.models.towers
{
	public class CannonTower extends Tower
	{
		public function CannonTower(level:int=1)
		{
			super(level);
			type = TYPE_CANNON;
		}
	}
}