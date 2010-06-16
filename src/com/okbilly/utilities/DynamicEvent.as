package com.okbilly.utilities
{
	import flash.events.Event;
	
	public dynamic class DynamicEvent extends Event
	{
		public var _data:Object;
		
		public function DynamicEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, data:Object = null)
		{
			super(type, bubbles, cancelable);
			_data = data;
		}
		
		public function get data():Object
		{
			return _data;
		}
	}
}