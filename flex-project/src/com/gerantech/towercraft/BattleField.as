package com.gerantech.towercraft
{
	import com.gerantech.towercraft.decorators.TowerDecorator;
	import com.gerantech.towercraft.managers.DropTargets;
	import com.gerantech.towercraft.models.Player;
	import com.gerantech.towercraft.models.TowerPlace;
	import com.gerantech.towercraft.models.vo.Troop;
	
	import flash.geom.Point;
	
	import feathers.controls.LayoutGroup;
	import feathers.layout.AnchorLayout;
	
	import starling.display.Quad;
	
	public class BattleField extends LayoutGroup
	{
		public static const MODE_EDIT:int = 0;
		public static const MODE_PLAY:int = 1;
			
		public var dropTargets:DropTargets;
		public var mode:int;
		private var towerPlaces:Vector.<TowerPlace>;
		
		override protected function initialize():void
		{
			super.initialize();
			layout = new AnchorLayout();
			backgroundSkin = new Quad(1,1,1)

			var w:Number = stage.stageWidth/2;
			var h:Number = w/3*4;
			
			var leftTopGround:Ground = new Ground(0, 0, w, h);
			addChild(leftTopGround);
			
			var rightTopGround:Ground = new Ground(w*2, 0, w, h);
			rightTopGround.scaleX = -1
			addChild(rightTopGround);
			
			var leftBotGround:Ground = new Ground(0, h*2, w, h);
			leftBotGround.scaleY = -1
			addChild(leftBotGround);
			
			var rightBotGround:Ground = new Ground(w*2, h*2, w, h);
			rightBotGround.scaleX = rightBotGround.scaleY = -1
			addChild(rightBotGround);
			
			createPlaces(w, h);
		}
		
		private function createPlaces(w:Number, h:Number):void
		{
			var paddingX:Number = w/4.444444444444445;
			var paddingY:Number = h/7.6190476190476195;
			var gapX:Number = w-paddingX;
			var gapY:Number = (h-paddingY)/2;
			var cols:Number = 3;
			var rows:Number = 5;
			var len:uint = cols*rows;
			
			towerPlaces = new Vector.<TowerPlace>(len, true);
			for (var i:uint=0; i<len; i++)
			{
				towerPlaces[i] = new TowerPlace(gapX/3, i);
				towerPlaces[i].x = paddingX + gapX * (i%cols);
				towerPlaces[i].y = paddingY + gapY * Math.floor((len-i-1)/cols);
				towerPlaces[i].selectable = (i < 6 || mode==MODE_PLAY);
				towerPlaces[i].name = i;
				addChild(towerPlaces[i]);
			}
			createLinks();
		}
		
		private function createLinks():void
		{
			var links:Vector.<Point> = new Vector.<Point>();
			links.push(new Point(0, 1));
			links.push(new Point(1, 2));
			links.push(new Point(3, 4));
			links.push(new Point(4, 5));
			links.push(new Point(6, 7));
			links.push(new Point(7, 8));
			links.push(new Point(9, 10));
			links.push(new Point(10, 11));
			links.push(new Point(12, 13));
			links.push(new Point(13, 14));
			
			links.push(new Point(0, 3));
			links.push(new Point(3, 6));
			links.push(new Point(6, 9));
			links.push(new Point(9, 12));
			links.push(new Point(1, 4));
			links.push(new Point(4, 7));
			links.push(new Point(7, 10));
			links.push(new Point(10, 13));
			links.push(new Point(2, 5));
			links.push(new Point(5, 8));
			links.push(new Point(8, 11));
			links.push(new Point(11, 14));
		
			var towersLen:uint = towerPlaces.length;
			var linksLen:uint = links.length;
			for (var t:uint=0; t<towersLen; t++)
			{
				for (var l:uint=0; l<linksLen; l++)
				{
					if(t == links[l].x)
						towerPlaces[t].links.push(towerPlaces[links[l].y]);
					else if(t == links[l].y)
						towerPlaces[t].links.push(towerPlaces[links[l].x]);
				}
			}
		}		
		
		public function addDrops():void
		{
			dropTargets = new DropTargets(stage);
			for each(var t:TowerPlace in towerPlaces)
				if(t.selectable)
					dropTargets.add(t);
		}
		
		public function setTower(place:TowerPlace, towerDecorator:TowerDecorator):void
		{
			// dettach place 
			if(towerDecorator.place != null)
			{
				towerDecorator.place.towerDecorator == null;
				towerPlaces[towerPlaces.indexOf(towerDecorator.place)].towerDecorator = null;
			}
				
			place.towerDecorator = towerDecorator;

			// measure all places has tower
			var towersLen:uint = towerPlaces.length;
			for (var t:uint=0; t<towersLen; t++)
			{
				if(towerPlaces[t].towerDecorator == null)
					towerPlaces[t].towerDecorator = new TowerDecorator(Player.instance.createTower(0, Player.instance.getTowerLevel(0)));
				
				Player.instance.towerPlaces[t] = towerPlaces[t].towerDecorator.tower.type;
			}
			trace(Player.instance.towerPlaces)
		}
		
		
		public function readyForBattle():void
		{
			for(var p:uint=0; p<towerPlaces.length; p++)
			{
				towerPlaces[p].towerDecorator = new TowerDecorator(Player.instance.createTower(Player.instance.towerPlaces[p], Player.instance.getTowerLevel(Player.instance.towerPlaces[p])));
				if(p == 1)
					towerPlaces[p].tower.createEngine(Troop.TYPE_BLUE);
				else if(p == 13)
					towerPlaces[p].tower.createEngine(Troop.TYPE_RED);
				else
					towerPlaces[p].tower.createEngine(Troop.TYPE_GREY);
				
				towerPlaces[p].createArrow();
			}
		}
		
		public function getAllTowers(troopType:int):Vector.<TowerPlace>
		{
			if(troopType==-1)
				return towerPlaces;

			var ret:Vector.<TowerPlace> = new Vector.<TowerPlace>();
			for(var p:uint=0; p<towerPlaces.length; p++)
				if(towerPlaces[p].tower.troopType == troopType)
					ret.push(towerPlaces[p]);
			return ret;
		}
		
	
		public function getTower(index:int):TowerPlace
		{
			if(towerPlaces == null)
				return null;
			
			return towerPlaces[index];
		}		
	}
}

import com.gerantech.towercraft.models.Textures;

import feathers.controls.ImageLoader;

class Ground extends ImageLoader
{
	public function Ground(x:Number, y:Number, w:Number, h:Number)
	{
		maintainAspectRatio = false;
		this.x = x;
		this.y = y;
		width = w;
		height = h;
		source = Textures.get("ground");
	}
}