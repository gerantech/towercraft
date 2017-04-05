package com.gerantech.towercraft.managers
{
	import com.gerantech.towercraft.models.vo.RTMFPObject;
	import com.reyco1.multiuser.MultiUserSession;
	import com.reyco1.multiuser.data.UserObject;
	import com.reyco1.multiuser.debug.Logger;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;
	
	public class RTMFPConnector extends EventDispatcher
	{

		// you can get a key from here : http://labs.adobe.com/technologies/cirrus/
		private const SERVER:String   = "rtmfp://p2p.rtmfp.net/";
		private const DEVKEY:String   = "27be92e7097e18f522e86df8-c2c11c5bb804";
		// you can get a key from here : http://labs.adobe.com/technologies/cirrus/
		private const SERVER_AND_KEY:String = SERVER + DEVKEY;
		
		private var connection:MultiUserSession;
		private var myName:String;
		public var rtmfpObject:RTMFPObject;
		private var connected:Boolean;
		
		
		public function connect(myTowers:Array):void
		{
			// create a new instance of MultiUserSession
			connection = new MultiUserSession(SERVER_AND_KEY, "multiuser/test");		
			// set the method to be executed when connected
			connection.onConnect 		= handleConnect;						
			// set the method to be executed once a user has connected
			connection.onUserAdded 		= handleUserAdded;						
			// set the method to be executed once a user has disconnected
			connection.onUserRemoved 	= handleUserRemoved;					
			// set the method to be executed when we recieve data from a user
			connection.onObjectRecieve 	= handleGetObject;						
			// my name
			myName  = "User_" + Math.round(Math.random()*100);
			
			// connect using my name and towers
			connection.connect(myName, myTowers);						
		}
		
		// method should expect a UserObject
		protected function handleConnect(user:UserObject):void					
		{
			Logger.log("I'm connected: " + user.name + ", total: " + connection.userCount); 
		}
		
		// method should expect a UserObject
		protected function handleUserAdded(user:UserObject):void				
		{
			Logger.log("User added: " + user.name + ", total users: " + connection.userCount + ", details: " + user.details);
			connected = true;
			rtmfpObject = new RTMFPObject();
			dispatchEventWith(Event.COMPLETE, false, user);
		}
		
		// method should expect a UserObject
		protected function handleUserRemoved(user:UserObject):void				
		{
			Logger.log("User disconnected: " + user.name + ", total users: " + connection.userCount);
			dispatchEventWith(Event.CLOSE, user);
		}
		
		public function send(source:Array, destination:int):void			
		{
			if(!connected)
				return;

			connection.sendObject({source:source, destination:destination});
		}
		
		protected function handleGetObject(peerID:String, data:Object):void
		{
			trace(data);
			rtmfpObject.update(data.source, data.destination);
			dispatchEventWith(Event.UPDATE, rtmfpObject);
		}		
		
		public function disconnect():void
		{
			connected = false;
			connection.close();
			dispatchEventWith(Event.CLOSE);
		}
	}
	
	
}