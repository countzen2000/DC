package com.okbilly.components
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Header extends Sprite
	{
		[Embed (source="./assets/header/BG.png")]
		private var BG:Class;
		
		private var _bg:Sprite;
		
		public function Header()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			_bg = new Sprite();
			_bg.addChild(new BG() as Bitmap);
			this.addChild(_bg);
		}
		
		private function onAdded(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
	}
}