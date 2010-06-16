package com.okbilly.utilities
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class EmbededTextField extends TextField
	{
		//Fonts
		[Embed(source="./assets/fonts/font.swf", fontFamily="Trebuchet MS")]
		public var Trebuchet:Class;
		
		[Embed(source="./assets/fonts/font.swf", fontFamily="Trebuchet MS", fontWeight="bold")]
		public var TrebuchetBold:Class;
		
		private var _format:TextFormat;
		
		public function EmbededTextField(bold:Boolean = false, size:int = 13, color:Number = 0xffffff)
		{
			super();
			
			if (bold) {
				_format = new TextFormat("Trebuchet MS", size, color, true);
			} else {
				_format = new TextFormat("Trebuchet MS", size, color, false);
			}
			this.selectable = false;
			this.defaultTextFormat = _format;
			this.embedFonts = true;
			this.autoSize = TextFieldAutoSize.LEFT;
		}
		
		public function set size(size:Number):void
		{
			_format.size = size;
			this.setTextFormat(_format);
		}
		
		public function get size():Number
		{
			return _format.size as Number;
		}
	}
}