package com.okbilly.components
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.InterpolationMethod;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	public class Background extends Sprite
	{
		private var _colors:Array = [0x10161c, 0x323232];
		
		private var _width:Number, _height:Number;
		
		public function Background(stageWidth:Number, stageHeight:Number)
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			
			_width = stageWidth;
			_height = stageHeight;
			
			drawBG();
		}
		
		private function onAdded(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			this.stage.addEventListener(Event.RESIZE, onResize);
		}
		
		private function drawBG():void
		{
			var g:Graphics;
			g = this.graphics;
			g.clear();
			var matr:Matrix = new Matrix();
			matr.createGradientBox(_width, _height, Math.PI/2, 0,0);
			g.beginGradientFill(GradientType.LINEAR, [_colors[0], _colors[1]], [1, 1], [0, 100], matr, SpreadMethod.PAD, InterpolationMethod.RGB);
			g.drawRect(0,0,_width, _height);
		}
		
		private function onResize(e:Event):void
		{
			_width = this.stage.stageWidth;
			_height = this.stage.stageHeight;
			
			drawBG();
		}
	}
}