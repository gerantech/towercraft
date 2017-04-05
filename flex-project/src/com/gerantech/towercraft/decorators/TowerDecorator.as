package com.gerantech.towercraft.decorators
{
	import com.gerantech.towercraft.models.Textures;
	import com.gerantech.towercraft.models.TowerPlace;
	import com.gerantech.towercraft.models.towers.Tower;
	import com.gerantech.towercraft.models.vo.Troop;
	
	import flash.utils.setTimeout;
	
	import feathers.controls.Label;
	import feathers.controls.text.BitmapFontTextRenderer;
	import feathers.text.BitmapFontTextFormat;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.filters.ColorMatrixFilter;
	import starling.text.TextField;
	import starling.text.TextFormat;
	
	public class TowerDecorator extends Sprite
	{
		public var tower:Tower;
		private var imageDisplay:Image;
		public var place:TowerPlace;

		private var cmf:ColorMatrixFilter;
		private var populationIndicator:BitmapFontTextRenderer;
		
		public function TowerDecorator(tower:Tower)
		{
			this.tower = tower;
			tower.addEventListener(Event.UPDATE, tower_updateHandler);
			imageDisplay = new Image(Textures.get("tower-type-"+tower.type));
			imageDisplay.touchable = false;
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			alignPivot();
		}
		
		private function tower_updateHandler(event:Event):void
		{
			populationIndicator.text = tower.population+"/"+tower.capacity;
			
			if(!event.data)
				return;
			
			var txt:String = "tower-type-"+tower.type;
			if(tower.troopType == Troop.TYPE_BLUE)
				txt += "-b";
			else if(tower.troopType == Troop.TYPE_RED)
				txt += "-r";
			
			imageDisplay.texture = Textures.get(txt)
			//cmf = new ColorMatrixFilter();
			//cmf.tint(tower.troopType, 0.8);
		//	imageDisplay.filter = cmf;
		}
		
		private function addedToStageHandler():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			imageDisplay.pivotX = imageDisplay.width/2
			imageDisplay.pivotY = imageDisplay.height - imageDisplay.width*0.4;
			imageDisplay.width = stage.stageWidth/6;
			imageDisplay.scaleY = imageDisplay.scaleX;
			imageDisplay.x = parent.x;
			imageDisplay.y = parent.y;
			parent.parent.addChild(imageDisplay);
			
			/*var tf:TextFormat = new TextFormat("font", imageDisplay.width/5);
			tf.bold = true;*/
			
			populationIndicator = new BitmapFontTextRenderer();//imageDisplay.width, imageDisplay.width/2, "");
			populationIndicator.textFormat = new BitmapFontTextFormat(Textures.getFont(), 12, 0)
			populationIndicator.touchable = false;
			populationIndicator.pivotX = populationIndicator.width/2
			populationIndicator.width = imageDisplay.width;
			populationIndicator.height = imageDisplay.width/2;
			populationIndicator.x = parent.x;
			populationIndicator.y = parent.y + imageDisplay.width/3;
			//populationIndicator.format.font = "fontName";

			//parent.parent.addChild(populationIndicator);
			setTimeout(parent.parent.addChild, 100, populationIndicator);
		}
	}
}