package com.gerantech.towercraft.screens
{
	import com.gerantech.towercraft.Main;
	import com.gerantech.towercraft.controls.FastList;
	
	import feathers.controls.Button;
	import feathers.controls.StackScreenNavigator;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	
	import starling.events.Event;
	
	public class MainScreen extends BaseCustomScreen
	{
		private var topList:FastList;
		public function MainScreen()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			layout = new AnchorLayout();
			
			var attackButton:Button = new Button();
			attackButton.label = "حمـــــله"
			attackButton.layoutData = new AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
			attackButton.addEventListener(Event.TRIGGERED, attackButton_triggeredHandler);
			addChild(attackButton);
			
			var deckButton:Button = new Button();
			deckButton.label = "آرایش جنگی"
			deckButton.layoutData = new AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 100);
			deckButton.addEventListener(Event.TRIGGERED, deckButton_triggeredHandler);
			addChild(deckButton);
		}
		
		private function deckButton_triggeredHandler():void
		{
			StackScreenNavigator(owner).pushScreen(Main.DECK_SCREEN);;		
		}
		private function attackButton_triggeredHandler():void
		{
			StackScreenNavigator(owner).pushScreen(Main.BATTLE_SCREEN);;		
		}		
		
	}
}