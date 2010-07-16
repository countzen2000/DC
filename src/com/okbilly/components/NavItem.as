package com.okbilly.components {
	
	
	import com.okbilly.model.dto.MenuDTO;
	import com.okbilly.utilities.DynamicEvent;
	import com.okbilly.utilities.EmbededTextField;
	import com.okbilly.view.NavMediator;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	internal class NavItem extends Sprite
	{
		private var _data:MenuDTO;
		
		private var _text:EmbededTextField;
		private var _line:Sprite;
		private var _hitArea:Sprite;
		
		public function NavItem(data:MenuDTO)
		{
			_data = data;
			
			_text = new EmbededTextField(false, 12);
			_text.text = data.name;
			this.addChild(_text);
			
			_hitArea = new Sprite();
			_hitArea.graphics.beginFill(0x123456, 0);
			_hitArea.graphics.drawRect(0,0,_text.width, _text.height);
			this.addChildAt(_hitArea, 0);
			
			this.useHandCursor = this.buttonMode = true;
			this.addEventListener(MouseEvent.ROLL_OVER, onOver);
			this.addEventListener(MouseEvent.ROLL_OUT, onOut);
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		public function addLine():void
		{
			if (!_line) {_line = new Sprite(); this.addChild(_line);}
			var g:Graphics = _line.graphics;
			g.clear();
			g.lineStyle(0, 0xFFFFFF);
			g.moveTo(_text.textWidth + 6, 4);
			g.lineTo(_text.textWidth + 6, _text.textHeight);
		}
		
		public function removeLine():void
		{
			if (_line) {
				_line.graphics.clear();
			}
		}
		private function onOver(e:Event):void
		{
			_text.filters = [new GlowFilter(0xffffff,1,3,3,1,3)];
		}
		private function onOut(e:Event):void
		{
			_text.filters = [];
		}
		
		private function onClick(e:Event):void
		{
			this.dispatchEvent(new DynamicEvent(NavMediator.MENU_CHOOSE_EVENT, true, true, _data));
		}
		
		
		public function get key():Number
		{
			return _data.key;
		}
	}
}