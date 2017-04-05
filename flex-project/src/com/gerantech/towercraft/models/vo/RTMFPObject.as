package com.gerantech.towercraft.models.vo
{
	public class RTMFPObject
	{
		public var source:Vector.<uint> = new Vector.<uint>();
		public var destination:uint;
		
		public function RTMFPObject()
		{
		}
		
		public function update(source:Object, destination:Object):void
		{
			this.source = new Vector.<uint>();
			for (var i:uint=0; i<source.length; i++)
				this.source.push(source[i]);
			this.destination = destination as uint;
		}
		
		public function toString():Object
		{
			return "from : " + source + " ,  to " + destination;
		}
	}
}