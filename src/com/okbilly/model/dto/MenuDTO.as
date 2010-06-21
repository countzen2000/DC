package com.okbilly.model.dto
{
	public class MenuDTO
	{
		public var key:Number;
		public var name:String;
		
		public var Items:Array = [];
		
		public function MenuDTO(data:*)
		{
			if (!data) return;
			
			if (data is XML) {
				key = data.@id;
				name = data.@name;
			
				for each (var item:XML in data.item)
				{
					Items.push(new ItemDTO(item));
				}	
			} else {
				key = data.id;
				name = data.name;
			}
		}
	}
}