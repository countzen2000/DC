package com.okbilly.components
{
	import com.okbilly.model.dto.ItemDTO;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class DropDown extends Sprite
	{
		[Embed (source="./assets/dropdown/BG.png")]
		private var BG:Class;
		
		private var _bg:Sprite;
		private var _items:Array= [];
		
		public function DropDown()
		{
			super();
			
			_bg = new Sprite();
			_bg.addChild(new BG() as Bitmap);
			this.addChild(_bg);
		}
		
		public function build(data:Array):void
		{
			if (_items.length > 0) {
				for each (var toremove:Item in _items)
				{
					this.removeChild(toremove);
				}
			}
			_items = [];
			
			var previous:DisplayObject;
			
			for each (var item:ItemDTO in data) {
				var temp:Item = new Item(item);
				
				if (previous) {
					temp.x = previous.x + previous.width + 12;	
				} else {
					temp.x = 20;
				}
				temp.y = 18;
				previous = temp;				
				this.addChild(temp);
				_items.push(temp);
			}
			
			
		}
	}
}
import com.greensock.TweenLite;
import com.okbilly.model.dto.ItemDTO;
import com.okbilly.utilities.EmbededTextField;

import flash.display.Loader;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.BlurFilter;
import flash.filters.GlowFilter;
import flash.net.URLRequest;
import flash.system.LoaderContext;
import flash.text.TextFieldAutoSize;

internal class Item extends Sprite
{
	private var _data:ItemDTO;
	
	private var _text:EmbededTextField;
	private var _imageHolder:Sprite;
	private var _hitArea:Sprite;
	private var _loader:Loader;
	
	private var _loadingText:EmbededTextField;
	
	public function Item(data:ItemDTO)
	{
		_data = data;
		
		_hitArea = new Sprite();
		_hitArea.graphics.beginFill(0x123456, 0);
		_hitArea.graphics.drawRect(0,0,	118, 125);
		this.addChild(_hitArea);
		
		_text = new EmbededTextField(false, 12);
		_text.text = _data.name;
		_text.autoSize = TextFieldAutoSize.CENTER;
		_text.width = 125;
		_text.multiline = _text.wordWrap = true;
		
		_text.x = this.width/2 - _text.textWidth/2;
		this.addChild(_text);
		
		_imageHolder = new Sprite();
		_imageHolder.graphics.beginFill(0x123456, 0);
		_imageHolder.graphics.drawRect(0,0,	90, 90);
		_imageHolder.x = this.width/2 - _imageHolder.width/2;
		_imageHolder.y = _text.y + 35;
		this.addChild(_imageHolder);
		
		_loadingText = new EmbededTextField(false, 10, 0xFFFFFF);
		_loadingText.text = "Loading...";
		_loadingText.x = this.width/2 - _loadingText.textWidth/2;
		_loadingText.y = _imageHolder.y + _imageHolder.height/2 - _loadingText.height/2;
		this.addChild(_loadingText);
		
		_loader = new Loader();
		_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
		_loader.load(new URLRequest(_data.url), new LoaderContext());
	
		this.addEventListener(MouseEvent.ROLL_OVER, onOver);
		this.addEventListener(MouseEvent.ROLL_OUT, onOut);
	}
	
	private function onOver(e:Event):void
	{
		this.filters = [new GlowFilter(0xffffff,1,3,3,1,3)];
	}
	private function onOut(e:Event):void
	{
		this.filters = [];
	}
	
	private function onLoaded(e:Event):void
	{
		if (this.contains(_loadingText)) {
			TweenLite.to(_loadingText, .5, {alpha:0, blurFilter:{blurX:20}});
		}
		_loader.alpha = 0;
		_loader.filters = [new BlurFilter(20, 0)];
		_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaded);
		_imageHolder.addChild(_loader);
		_loader.x = _imageHolder.width/2 - _loader.width/2;
		_loader.y = _imageHolder.height/2 - _loader.height/2;
		
		TweenLite.to(_loader, .5, {alpha:1, blurFilter:{blurX:0}});
	}
}