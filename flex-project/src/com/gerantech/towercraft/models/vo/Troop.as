package com.gerantech.towercraft.models.vo
{
	import com.gerantech.towercraft.models.Textures;
	import com.gerantech.towercraft.models.TowerPlace;
	
	import flash.utils.setTimeout;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class Troop extends Image
	{
		public static const TYPE_GREY:uint = 0xe2e2e2;
		public static const TYPE_BLUE:uint = 0x0000FF;
		public static const TYPE_RED:uint = 0xFF0000;
		
		
		public var type:uint;
		public var path:Vector.<TowerPlace>;
		
		
		public function Troop(type:uint, path:Vector.<TowerPlace>)
		{
			var txt:String = "troop";
			if(type == TYPE_BLUE)
				txt += "-b";
			else if(type == Troop.TYPE_RED)
				txt += "-r";
			
			super(Textures.get(txt));
			alignPivot();
			
			this.type = type;
			touchable = false;
			this.path = new Vector.<TowerPlace>();
			for (var p:uint=0; p<path.length; p++)
				this.path.push(path[p]);
				
			/*beginFill(type);
			drawCircle(0, 0, 12);
			endFill();*/
		}
		
		public function rush():Boolean
		{
			var destination:TowerPlace = path.shift();
			if(destination == null)
			{
				removeFromParent(true);
				//trace("fine", type);
				return false;
			}
			
			Starling.juggler.tween(this, 0.5, {x:destination.x, y:destination.y, onComplete:onTroopArrived, onCompleteArgs:[destination]});
			return true;
		}
		private function onTroopArrived(destination:TowerPlace):void
		{
			destination.tower.pushTroops(1, type);
			setTimeout(destination.rush, 200, this, 0);
		}
	}
}