package com.okbilly.model.dto
{
	public class ItemDTO
	{
		public var key:Number;
		
		public var name:String;
		public var url:String;
		public var linkURL:String;
		
		public function ItemDTO(data:*)
		{
			if (!data) return;
			if (data is XML) {
				key = data.@id;
				name = data.@name;
				url = data.imageurl;
				linkURL = data.linkurl;
			} else {
				key = data.id;
				name = data.name;
				url = data.url;
			}
		}
	}
}