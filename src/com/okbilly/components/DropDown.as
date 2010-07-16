package com.okbilly.components
{
	import com.greensock.TweenLite;
	import com.okbilly.model.dto.ItemDTO;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	
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
		
		public function hide():void
		{
			if (_items.length > 0) {
				for each (var toremove:Item in _items)
				{
					TweenLite.to(toremove, .3, {alpha:0, blurFilter:{blurX:20} });
				}
			}
			_items = [];
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
					temp.x = previous.x + previous.width + 6;	
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
import com.greensock.easing.Back;
import com.greensock.easing.Bounce;
import com.greensock.easing.Elastic;
import com.greensock.easing.Expo;
import com.okbilly.model.dto.ItemDTO;
import com.okbilly.utilities.EmbededTextField;

import flash.display.Bitmap;
import flash.display.Loader;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.external.ExternalInterface;
import flash.filters.BlurFilter;
import flash.filters.GlowFilter;
import flash.net.URLRequest;
import flash.net.navigateToURL;
import flash.system.LoaderContext;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import flashx.textLayout.formats.TextAlign;

internal class Item extends Sprite
{
	private var _data:ItemDTO;
	
	private var _text:EmbededTextField;
	private var _imageHolder:Sprite;
	private var _hitArea:Sprite;
	private var _loader:Loader;
	private var _loadingTextHolder:Sprite;
	
	private var _loadingText:EmbededTextField;
	private var _loaderHolder:Sprite;
	
	public function Item(data:ItemDTO)
	{
		_data = data;
		
		_hitArea = new Sprite();
		_hitArea.graphics.beginFill(0x123456, 0);
		_hitArea.graphics.drawRect(0,0,	118, 125);
		this.addChild(_hitArea);
		
		_text = new EmbededTextField(false, 12);
		//_text.background = true;
		//_text.backgroundColor = 0xFFFFFF;
		_text.wordWrap = true;		
		_text.text = _data.name;
		_text.setTextFormat(new TextFormat(null, null, null, null, null, null, null, null, TextAlign.CENTER));
		if (_text.textWidth > 125) {
			_text.width = 125;	
		}
		 
		
		_text.x = this.width/2 - _text.width/2;
		
		this.addChild(_text);
		
		_imageHolder = new Sprite();
		_imageHolder.graphics.beginFill(0x123456, 0);
		_imageHolder.graphics.drawRect(0,0,	125, 90);
		_imageHolder.x = this.width/2 - _imageHolder.width/2;
		_imageHolder.y = _text.y + 35;
		this.addChild(_imageHolder);
		
		_loadingText = new EmbededTextField(false, 15, 0xFFFFFF);
		_loadingText.text = "Loading....";
		_loadingTextHolder = new Sprite();
		_loadingTextHolder.addChild(_loadingText);
		_loadingText.x = -_loadingText.textWidth/2;
		_loadingText.y = -_loadingText.textHeight/2;
		
		_loadingTextHolder.x = _imageHolder.width/2;
		_loadingTextHolder.y = _imageHolder.y + _imageHolder.height/2;
		this.addChild(_loadingTextHolder);
		
		_loader = new Loader();
		_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
		_loader.load(new URLRequest(_data.url), new LoaderContext());

		this.addEventListener(MouseEvent.ROLL_OVER, onOver, true, 0, false);
		this.addEventListener(MouseEvent.ROLL_OUT, onOut, true, 0, false);
		this.addEventListener(MouseEvent.CLICK, onClick, true, 0, false);
		
		this.addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
	}
	
	private function onRemoved(e:Event):void
	{
		this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		_loader.unload();
	}
	
	private function onOver(e:Event):void
	{
		//this.filters = [new GlowFilter(0xffffff,1,3,3,1,3)];
		TweenLite.to(_loaderHolder, .3, {scaleX:1.4, scaleY:1.4, ease:Back.easeInOut});
	}
	private function onOut(e:Event):void
	{
		//this.filters = [];
		TweenLite.to(_loaderHolder, .3, {alpha:1, scaleX:1, scaleY:1, ease:Back.easeOut});
	}
	
	private function onClick(e:Event):void
	{
		if (_data.linkURL && _data.linkURL != "") {
			navigateToURL(new URLRequest(_data.linkURL), "_self");
		}
	}
	
	private function onLoaded(e:Event):void
	{		
		
		_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaded);
		while (_loader.width > 125) {
			_loader.scaleX -= .1;
			_loader.scaleY -= .1;
		}
		(_loader.content as Bitmap).smoothing = true;
		_loader.x = -_loader.width/2;
		_loader.y = -_loader.height/2;
		
		_loaderHolder = new Sprite();
		_loaderHolder.x = _loader.width/2;
		_loaderHolder.y = _loader.height/2;
		_loaderHolder.addChild(_loader);
		
		_loaderHolder.scaleX = _loaderHolder.scaleY =  0;
		
		_imageHolder.addChild(_loaderHolder);
		
		_loaderHolder.x = _imageHolder.width/2
		_loaderHolder.y = _imageHolder.height/2
		
		
		if (this.contains(_loadingText)) {
			TweenLite.to(_loadingTextHolder, .4, {scaleX:0, scaleY:0, ease:Back.easeIn});
			TweenLite.to(_loaderHolder, .4, {delay:.4, scaleX:1, scaleY:1, ease:Back.easeInOut});
		} else {
			TweenLite.to(_loaderHolder, .4, {alpha:1, scaleX:1, scaleY:1, ease:Back.easeOut});
		}
		
	}
	
	override public function get width():Number
	{
		return 125;
	}
}