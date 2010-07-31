package com.okbilly.components {
	
	
	import com.okbilly.model.dto.MenuDTO;
	import com.okbilly.utilities.DynamicEvent;
	import com.okbilly.utilities.EmbededTextField;
	import com.okbilly.view.NavMediator;
	
	import flash.display.Bitmap;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.InterpolationMethod;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	
	internal class NavItem extends Sprite
	{
		[Embed (source="./assets/nav/splitter.png")]
		private var Line:Class;
		
		private var _data:MenuDTO;
		
		private var _text:EmbededTextField;
		private var _line:Sprite;
		private var _hitArea:Sprite;
		private var _overview:Sprite;
		
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
			
			_overview = new Sprite();
			var matr:Matrix = new Matrix();
			matr.createGradientBox(_text.width, _text.height, Math.PI/2, 0,0);
			_overview.graphics.beginGradientFill(GradientType.LINEAR, [0x674d14, 0xc89b35], [1, 1], [0, 100], matr, SpreadMethod.PAD, InterpolationMethod.RGB);
			_overview.graphics.drawRect(-2,-5,_text.width+4, _text.height+8);
			
			this.useHandCursor = this.buttonMode = true;
			this.addEventListener(MouseEvent.ROLL_OVER, onOver);
			this.addEventListener(MouseEvent.ROLL_OUT, onOut);
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		public function addLine():void
		{
			if (!_line) {
				_line = new Sprite();
				_line.addChild(new Line() as Bitmap);
				this.addChild(_line);
			}
			/*
			var g:Graphics = _line.graphics;
			g.clear();
			g.lineStyle(0, 0xFFFFFF);
			g.moveTo(_text.textWidth + 6, 4);
			g.lineTo(_text.textWidth + 6, _text.textHeight);
			*/
			_line.x = _text.textWidth +4;
			_line.y -= 2;
		}
		
		public function removeLine():void
		{
			if (_line) {
				//_line.graphics.clear();
				_line.removeChildAt(0);
			}
		}
		private function onOver(e:Event):void
		{
			//_text.filters = [new GlowFilter(0xffffff,1,3,3,1,3)];
			this.addChildAt(_overview, 0);
			this.dispatchEvent(new DynamicEvent(NavMediator.MENU_CHOOSE_EVENT, true, true, _data));
		}
		private function onOut(e:Event):void
		{
			//_text.filters = [];
			this.removeChild(_overview);
			this.dispatchEvent(new DynamicEvent(NavMediator.MENU_UNCHOOSE_EVENT, true, true));
		}
		
		private function onClick(e:Event):void
		{
			this.dispatchEvent(new DynamicEvent(NavMediator.MENU_LOCKED_EVENT, true, true, _data));
		}
		
		
		public function get key():Number
		{
			return _data.key;
		}
	}
}