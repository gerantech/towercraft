package com.gerantech.towercraft.managers
{
	import com.gerantech.towercraft.models.TowerPlace;
	
	import flash.utils.setInterval;
	import com.gerantech.towercraft.BattleField;

	public class AIEnemy
	{
		private var battleField:BattleField;
		private var troopType:int;
		private var myTowers:Vector.<TowerPlace>;
		private var enemies:Vector.<TowerPlace>;

		private var startTower:TowerPlace;
		private var weakest:TowerPlace;
		
		public function AIEnemy(battleField:BattleField, troopType:int)
		{
			this.battleField = battleField;
			this.troopType = troopType;
			
			setInterval(updateTerritoryState, Math.random()*3000+3000);
			updateTerritoryState();
		}
		
		private function updateTerritoryState():void
		{
			myTowers = battleField.getAllTowers(troopType);
			if(myTowers.length == 0)
				return;
			
			var enemyLen:uint = myTowers.length;
			var minCapacity:uint = 1000;
			var minPopulation:uint = 1000;
			
			
			for(var i:uint=0; i<enemyLen; i++)
			{
				// find smallest 
				if(minCapacity > myTowers[i].tower.capacity)
				{
					startTower = myTowers[i]
					minCapacity = startTower.tower.capacity;
				}
				
				// find weakest of enemeis
				for(var l:uint=0; l<myTowers[i].links.length; l++)
				{
					if(myTowers[i].links[l].tower.troopType != troopType)
					{
						if(myTowers[i].links[l].tower.population<minPopulation)
						{
							weakest = myTowers[i].links[l];
							minPopulation = weakest.tower.population;
						}
					}
				}
			}
			var all:Vector.<TowerPlace> = battleField.getAllTowers(-1);
			for(i=0; i<enemyLen; i++)
				myTowers[i].fight(weakest, all);
		}
		
	}
}