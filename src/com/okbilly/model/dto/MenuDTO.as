package com.okbilly.model.dto
{
	public class MenuDTO
	{
		public var key:Number;
		public var name:String;
		
		public var Items:Array = [];
		
		public function MenuDTO(data:Object)
		{
			if (!data) return;
			
			key = data.id;
			name = data.name;
		}
	}
}