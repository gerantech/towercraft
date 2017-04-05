package com.gerantech.towercraft.controls.items
{
	import com.gerantech.towercraft.models.Textures;
	import com.gerantech.towercraft.models.towers.Tower;
	
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.ProgressBar;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	
	import starling.display.Quad;
	import starling.events.Event;

	public class CardItemRenderer extends BaseCustomItemRenderer
	{
		private var tower:Tower;

		private var iconDisplay:ImageLoader;
		private var labelDisplay:Label;
		private var progressbar:ProgressBar;
		
		public function CardItemRenderer()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			layout = new AnchorLayout();
			
			backgroundSkin = new Quad(1,1,0xFFFFFF)
			
			width = stage.stageWidth/4-1;
			height = stage.stageWidth/3;
			
			iconDisplay = new ImageLoader();
			iconDisplay.delayTextureCreation = true;
			iconDisplay.height = width;
			iconDisplay.layoutData = new AnchorLayoutData(6,0,16,0);
			addChild(iconDisplay);
			
			labelDisplay = new Label();
			labelDisplay.isEnabled = false;
			labelDisplay.styleNameList.add(Label.ALTERNATE_STYLE_NAME_DETAIL);
			labelDisplay.layoutData = new AnchorLayoutData(NaN,2,16,2);
			addChild(labelDisplay);
			
			progressbar = new ProgressBar();
			progressbar.layoutData = new AnchorLayoutData(NaN,1,1,1);
			addChild(progressbar);
		}
		
		override protected function commitData():void
		{
			if(_owner==null || _data==null)
				return;
			
			tower = _data as Tower;
			iconDisplay.source = Textures.get("tower-type-"+tower.type);
			labelDisplay.text = "Level " + tower.level;
			progressbar.maximum = tower.upgradeCost;
			progressbar.value = 5;
		}
		
		override public function set isSelected(value:Boolean):void
		{
			super.isSelected = value;
			if(value)
				_owner.dispatchEventWith(Event.READY, false, this);
		}
		
		
	}
}