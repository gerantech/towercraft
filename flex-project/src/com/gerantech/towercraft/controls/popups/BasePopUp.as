package com.gerantech.towercraft.controls.popups
{
	import flash.ui.Keyboard;
	
	import mx.resources.ResourceManager;
	
	import feathers.controls.LayoutGroup;
	
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	
	public class BasePopUp extends LayoutGroup
	{
		public var closable:Boolean = true;

		override protected function initialize():void
		{
			super.initialize();
			
			autoSizeMode = LayoutGroup.AUTO_SIZE_MODE_STAGE; 
			stage_resizeHandler(null);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, stage_keyUpHandler);	 
			addEventListener(Event.REMOVED_FROM_STAGE, removeFromStageHandler);
		}
		
		private function removeFromStageHandler(event:Event):void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, stage_keyUpHandler);
		}
		
		private function stage_keyUpHandler(event:KeyboardEvent):void
		{
			if(!closable)
				return;
			if(event.keyCode==Keyboard.BACK)
			{
				//stage.removeEventListener(KeyboardEvent.KEY_DOWN, stage_keyUpHandler);
				event.preventDefault();
				close();
			}
		}
		
		protected function loc(str:String, parameters:Array=null, locale:String=null):String
		{
			return ResourceManager.getInstance().getString("loc", str, parameters, locale);
		}
		
		public function close():void
		{
			dispatchEventWith(Event.CLOSE);
		}		
	}
}