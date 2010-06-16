package com.okbilly.components
{
	import com.okbilly.utilities.EmbededTextField;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class NavMenu extends Sprite
	{
		[Embed (source="./assets/header/NavBar.png")]
		private var NavBar:Class;
		
		private var _bg:Sprite;
		
		private var _navArrary:Array = [];
		
		public function NavMenu()
		{
			super();
			
			_bg = new Sprite();
			_bg.addChild(new NavBar() as Bitmap);
			this.addChild(_bg);
		}
		
		public function build(data:Array):void
		{
			_navArrary = data;
			
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
				
				this.addChild(temp);
			}
		}
	}
}