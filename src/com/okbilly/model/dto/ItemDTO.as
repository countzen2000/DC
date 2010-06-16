package com.okbilly.model.dto
{
	public class ItemDTO
	{
		public var key:Number;
		
		public var name:String;
		public var url:String;
		
		public function ItemDTO(data:Object)
		{
			if (!data) return;
			
			key = data.id;
			name = data.name;
			url = data.url;
		}
	}
}