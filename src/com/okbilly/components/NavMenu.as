package com.okbilly.components
{
	import com.greensock.TweenLite;
	import com.okbilly.utilities.EmbededTextField;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	
	public class NavMenu extends Sprite
	{
		[Embed (source="./assets/header/NavBar.png")]
		private var NavBar:Class;
		
		private var _bg:Sprite;
		private var _navItemHolder:Sprite;
		
		private var _navArrary:Array = [];
		
		public function NavMenu()
		{
			super();
			
			_bg = new Sprite();
			_bg.addChild(new NavBar() as Bitmap);
			this.addChild(_bg);
			
			_navItemHolder = new Sprite();
			this.addChild(_navItemHolder);
		}
		
		public function build(data:Array):void
		{
			_navArrary = data;
			_navItemHolder.alpha = 0;
			_navItemHolder.filters = [new BlurFilter(20,0)];
			
			var previous:DisplayObject;
			for (var i:int = 0;i < _navArrary.length; i++) {
				var temp:NavItem = new NavItem(_navArrary[i]);
				if (i != _navArrary.length-1) {
					temp.addLine();
				}
				
				temp.y = 5;
				if (previous) {
					temp.x = previous.x + previous.width + 3;
				} else {
					temp.x = 5;
				}
				previous = temp;
				
				_navItemHolder.addChild(temp);
			}
			
			TweenLite.to(_navItemHolder, 1, {alpha:1, blurFilter:{blurX:0}});
		}
	}
}