package com.gerantech.towercraft
{
	import com.gerantech.towercraft.models.Player;
	import com.gerantech.towercraft.screens.BattleScreen;
	import com.gerantech.towercraft.screens.DeckScreen;
	import com.gerantech.towercraft.screens.MainScreen;
	
	import feathers.controls.Drawers;
	import feathers.controls.StackScreenNavigator;
	import feathers.controls.StackScreenNavigatorItem;
	import feathers.core.IFeathersControl;
	import feathers.motion.Slide;
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.events.Event;
	
	public class Main extends Drawers
	{
		public static const MAIN_SCREEN:String = "mainScreen";
		public static const DECK_SCREEN:String = "deckScreen";
		public static const BATTLE_SCREEN:String = "battleScreen";

		private var _navigator:StackScreenNavigator;
		
		public function Main(content:IFeathersControl=null)
		{
			new MetalWorksMobileTheme();
			super(content);
			Player.instance;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			//EmbeddedAssets.initialize();
					
			this._navigator = new StackScreenNavigator();
			this.content = this._navigator;
			
			var mainItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(MainScreen);
		//	mainItem.addPopEvent(Event.COMPLETE);
			this._navigator.addScreen(MAIN_SCREEN, mainItem);
			
			var deckItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(DeckScreen);
			deckItem.addPopEvent(Event.COMPLETE);
			this._navigator.addScreen(DECK_SCREEN, deckItem);
			
			var battleItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(BattleScreen);
			battleItem.addPopEvent(Event.COMPLETE);
			this._navigator.addScreen(BATTLE_SCREEN, battleItem);
			
			this._navigator.rootScreenID = MAIN_SCREEN;
			this._navigator.pushTransition = Slide.createSlideUpTransition();
			this._navigator.popTransition = Slide.createSlideDownTransition();
		}
	}
}