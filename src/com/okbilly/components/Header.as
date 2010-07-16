package com.okbilly.components
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	public class Header extends Sprite
	{
		[Embed (source="./assets/header/BG.png")]
		private var BG:Class;
		
		private var _bg:Sprite;
		
		private var _hitArea:Sprite;
		
		public function Header()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			_bg = new Sprite();
			_bg.addChild(new BG() as Bitmap);
			this.addChild(_bg);
			
			_hitArea = new Sprite();
			_hitArea.useHandCursor = _hitArea.buttonMode = true;
			_hitArea.addEventListener(MouseEvent.CLICK, onClick);
			_hitArea.graphics.beginFill(0x123456, 0);
			_hitArea.graphics.drawRect(0, 0, 170, 100);
			_hitArea.x = 20;
			_hitArea.y = 10;
			this.addChild(_hitArea);
		}
		
		private function onAdded(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onClick(e:Event):void
		{
			navigateToURL(new URLRequest(DC.logoURL));
		}
	}
}