package com.gerantech.towercraft.models
{
	import com.gerantech.towercraft.models.vo.Troop;
	import com.gerantech.towercraft.models.towers.BomberTower;
	import com.gerantech.towercraft.models.towers.CannonTower;
	import com.gerantech.towercraft.models.towers.CommonTower;
	import com.gerantech.towercraft.models.towers.LazerTower;
	import com.gerantech.towercraft.models.towers.RapidTower;
	import com.gerantech.towercraft.models.towers.SniperTower;
	import com.gerantech.towercraft.models.towers.Tower;

	public class Player
	{
		[Embed(source = "../assets/texts/player-data.json", mimeType="application/octet-stream")]
		private static const JSONCLASS:Class;

		
		public var name:String = "ManJav";
		public var xp:uint = 1;
		public var point:uint = 1;
		public var troopType:uint = Troop.TYPE_BLUE;
		public var towers:Vector.<Tower>;
		public var towerPlaces:Vector.<int>;
		private static var _instance:Player;
		
		public function Player()
		{
			var data:Object = JSON.parse(new JSONCLASS());
			
			// create towers
			towers = new Vector.<Tower>();
			for each(var t:Object in data.towers)
				towers.push(createTower(t.type, t.level));
			
			towerPlaces = new Vector.<int>();
			for each(var tb:Object in data.towerPlaces)
				towerPlaces.push(tb);
		}
		
		public function createTower(type:int, level:int):Tower
		{
			switch(type)
			{
				case 0: return (new CommonTower(level));
				case 1: return (new RapidTower(level));
				case 2: return (new SniperTower(level));
				case 3: return (new BomberTower(level));
				case 4: return (new CannonTower(level));
				case 5: return (new LazerTower(level));
			}
			return null;
		}

		public function getTowerLevel(type:int):int
		{
			for(var t:uint=0; t<towers.length; t++)
				if(towers[t].type == type)
					return towers[t].level;
			return -1;
		}
		
		public static function get instance():Player
		{
			if(_instance == null)
				_instance = new Player();
			return _instance;
		}
	}
}