package com.gerantech.towercraft.screens
{
	import com.gerantech.towercraft.BattleField;
	import com.gerantech.towercraft.controls.Devider;
	import com.gerantech.towercraft.controls.FastList;
	import com.gerantech.towercraft.controls.items.CardItemRenderer;
	import com.gerantech.towercraft.controls.popups.TowerDetailsPopup;
	import com.gerantech.towercraft.decorators.TowerDecorator;
	import com.gerantech.towercraft.models.Player;
	import com.gerantech.towercraft.models.TowerPlace;
	import com.gerantech.towercraft.models.towers.Tower;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.PopUpManager;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.TiledRowsLayout;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class DeckScreen extends BaseCustomScreen
	{
		private var battleField:BattleField;
		
		private var deckLayout:TiledRowsLayout;
		private var deckList:FastList;
		private var draggableTower:TowerDecorator;
		private var editOverlay:LayoutGroup;
		private var selectedCardBounds:Rectangle;
		private var dragFrom:int;
		
		override protected function initialize():void
		{
			super.initialize();
			layout = new AnchorLayout();
			
			battleField = new BattleField();
			battleField.layoutData = new AnchorLayoutData(stage.width/3,0,NaN,0);
			addChild(battleField);

			editOverlay = new Devider();
			editOverlay.layout = new AnchorLayout();
			editOverlay.layoutData = new AnchorLayoutData(0, 0, stage.width/3*2, 0);
			addChild(editOverlay);
			
			deckLayout = new TiledRowsLayout();
			deckLayout.useSquareTiles = false;
			deckLayout.gap = 1
			
			deckList = new FastList();
			deckList.layout = deckLayout;
			deckList.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			
			deckList.scrollBarDisplayMode = List.SCROLL_BAR_DISPLAY_MODE_NONE;
			//deckList.snapToPages = true;
			//deckList.pageHeight = 200
			deckList.itemRendererFactory = function ():IListItemRenderer
			{
				return new CardItemRenderer();
			}
			deckList.dataProvider = new ListCollection(Player.instance.towers);
			deckList.addEventListener(Event.READY, deckList_changeHandler);
			editOverlay.addChild(deckList);
			
			addEventListener(TouchEvent.TOUCH, touchHandler);
			addEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, transitionInCompleteHandler);
		}
		
		private function transitionInCompleteHandler():void
		{
			removeEventListener(FeathersEventType.TRANSITION_IN_COMPLETE, transitionInCompleteHandler);
			battleField.addDrops();
		}
		
		private function deckList_changeHandler(event:Event):void
		{
			selectedCardBounds = CardItemRenderer(event.data).getBounds(stage);
			
			var details:TowerDetailsPopup = new TowerDetailsPopup();
			details.tower = deckList.selectedItem as Tower;
			details.addEventListener(Event.CLOSE, details_closeHandler);
			details.addEventListener(Event.SELECT, details_selectHandler);
			PopUpManager.addPopUp(details);
			function details_closeHandler():void
			{
				if(PopUpManager.isPopUp(details))
					PopUpManager.removePopUp(details);
			}
			deckList.selectedIndex = -1;
		}
		
		private function details_selectHandler(event:Event):void
		{
			deckList.visible = false;
			var dt:TowerDecorator = new TowerDecorator(event.data as Tower);
			//dt.x = width/2;
			//dt.y = editOverlay.height/2;
			editOverlay.addChild(dt);
			
			dt.x = selectedCardBounds.x+selectedCardBounds.width/2;
			dt.y = selectedCardBounds.y+selectedCardBounds.height/2;
			Starling.juggler.tween(dt, 0.6, {x:width/2, y:editOverlay.height/2, transition: Transitions.EASE_OUT_BACK});
		}
		
		private function touchHandler(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this);
			if(touch == null)
				return;
			
			if(touch.phase == TouchPhase.BEGAN)
			{
				dragFrom = -1;
				if(touch.target.parent is TowerDecorator)
				{
					draggableTower = touch.target.parent as TowerDecorator;
					dragFrom = 0;
				}
				else if(touch.target is TowerPlace)
				{
					draggableTower = TowerPlace(touch.target).towerDecorator;
					dragFrom = 1;
				}
				
				if(draggableTower != null)
					editOverlay.addChild(draggableTower);
			}
			else if(draggableTower != null)
			{
				if(touch.phase == TouchPhase.MOVED)
				{
					draggableTower.x = touch.globalX;
					draggableTower.y = touch.globalY;
				}
				else if(touch.phase == TouchPhase.ENDED)
				{
					var dest:DisplayObject = battleField.dropTargets.contain(touch.globalX, touch.globalY);
					if(dest is TowerPlace)
					{
						var place:TowerPlace = dest as TowerPlace;
						battleField.setTower(place, draggableTower);
						deckList.visible = true;
						draggableTower = null;
						return;
					}
					if(dragFrom == 0)
					{
						draggableTower.x = width/2;
						draggableTower.y = editOverlay.height/2;
					}
					else if(dragFrom == 1)
					{
						battleField.setTower(draggableTower.place, draggableTower);
					}
					draggableTower = null;
				}
			}
		}
		
	}
}