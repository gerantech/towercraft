package com.gerantech.towercraft.controls.popups
{
	import com.gerantech.towercraft.controls.items.FeatureItemRenderer;
	import com.gerantech.towercraft.models.Textures;
	import com.gerantech.towercraft.models.towers.Tower;
	
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.HorizontalLayoutData;
	import feathers.layout.TiledRowsLayout;
	import feathers.layout.VerticalAlign;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;
	
	import starling.display.Quad;
	import starling.events.Event;

	public class TowerDetailsPopup extends BasePopUp
	{
		private var imageDisplay:ImageLoader;
		private var titleDisplay:Label;
		private var featureList:List;
		
		public var tower:Tower;
		private var buttonBar:LayoutGroup;
		
		override protected function initialize():void
		{
			super.initialize();
			width = stage.stageWidth*0.96;
			height = stage.stageHeight*0.6;

			var vlayout:VerticalLayout = new VerticalLayout();
			vlayout.horizontalAlign = VerticalAlign.JUSTIFY;
			vlayout.gap = vlayout.padding = 10;
			layout = vlayout;
			
			backgroundSkin = new Quad(1,1,0xFFFFFF);
			
			// header ----
			var header:LayoutGroup = new LayoutGroup();
			header.layout = new HorizontalLayout();;
			header.layoutData = new VerticalLayoutData(100, 30);
			header.height = width/2
			addChild(header);
			
			imageDisplay = new ImageLoader();
			imageDisplay.layoutData = new HorizontalLayoutData(10, 100);
			imageDisplay.source = Textures.get("tower_type_"+tower.type);
			header.addChild(imageDisplay);
			
			titleDisplay = new Label();
			titleDisplay.styleNameList.add(Label.ALTERNATE_STYLE_NAME_HEADING);
			titleDisplay.text = "Tower "+tower.type;
			titleDisplay.layoutData = new HorizontalLayoutData(90, 100);
			header.addChild(titleDisplay);
			
			// features ----
			var featureLayout:TiledRowsLayout = new TiledRowsLayout();
			featureLayout.useSquareTiles = false;
			featureLayout.requestedColumnCount = 2;
			
			var features:Array = new Array(); 
			for (var k:String in tower.features)
				features.push({key:k, value:tower.features[k]});
				
			featureList = new List();
			featureList.layoutData = new VerticalLayoutData(100, 100);
			featureList.layout = featureLayout;
			featureList.itemRendererFactory = function ():IListItemRenderer
			{
				return new FeatureItemRenderer();
			}
			featureList.dataProvider = new ListCollection(features);
			addChild(featureList);
			
			// buttons ----
			var buttonsLayout:HorizontalLayout = new HorizontalLayout();
			buttonsLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			buttonsLayout.gap = 10;
			
			buttonBar = new LayoutGroup();
			buttonBar.height = 32;
			buttonBar.layout = buttonsLayout;
			addChild(buttonBar);
			
			var selectButton:Button = new Button();
			selectButton.label = "Select";
			selectButton.addEventListener(Event.TRIGGERED, selectButton_triggeredHandler);
			buttonBar.addChild(selectButton);

			var upgradeButton:Button = new Button();
			upgradeButton.addEventListener(Event.TRIGGERED, upgradeButton_triggeredHandler);
			upgradeButton.label = "Upgrade";
			buttonBar.addChild(upgradeButton);
		}
		
		private function upgradeButton_triggeredHandler():void
		{
			dispatchEventWith(Event.UPDATE, false, tower);
			close();
		}
		
		private function selectButton_triggeredHandler():void
		{
			dispatchEventWith(Event.SELECT, false, tower);
			close();
		}		
		
	}
}