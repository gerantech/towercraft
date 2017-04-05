package com.gerantech.towercraft.controls.items
{
	import feathers.controls.Label;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	public class FeatureItemRenderer extends BaseCustomItemRenderer
	{
		private var titleDisplay:Label;
		
		override protected function initialize():void
		{
			super.initialize();
			layout = new AnchorLayout();
			height = 32;
			
			titleDisplay = new Label();
			titleDisplay.layoutData = new AnchorLayoutData(0,0,0,0);
			addChild(titleDisplay);
		}
		
		override protected function commitData():void
		{
			if(_owner==null || _data==null)
				return;
			
			width = _owner.width/2;
			titleDisplay.text = _data["key"] + ": " + Number(_data["value"]).toFixed(2)
		}
		
	}
}