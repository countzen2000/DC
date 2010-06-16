package com.okbilly.view
{
	import com.greensock.plugins.TweenPlugin;
	import com.okbilly.components.Background;
	import com.okbilly.components.DropDown;
	import com.okbilly.components.Header;
	import com.okbilly.components.NavMenu;
	
	import flash.display.Stage;
	import flash.events.Event;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class StageMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "stageMediator";
		
		
		private var _bg:Background;
		
		public function StageMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister() : void
		{
			this.stage.addEventListener(Event.RESIZE, onResize);
			
			_bg = new Background(stage.stageWidth, stage.stageHeight);
			stage.addChild(_bg);
			
			var header:Header = (facade.retrieveMediator(HeaderMediator.NAME) as HeaderMediator).header;
			header.x = stage.stageWidth/2 - header.width/2;
			stage.addChild(header);
			
			var nav:NavMenu = (facade.retrieveMediator(NavMediator.NAME) as NavMediator).nav;
			nav.x = header.x + 200;
			nav.y = 48;
			stage.addChild(nav);
			
			var drop:DropDown = (facade.retrieveMediator(DropDownMediator.NAME) as DropDownMediator).drop;
			drop.y = 0;
			drop.x = header.x + 16;
			stage.addChildAt(drop, stage.getChildIndex(header));
			
		}
		
		public function get stage():Stage
		{
			return viewComponent as Stage;
		}
		
		private function onResize(e:Event):void
		{
			var header:Header = (facade.retrieveMediator(HeaderMediator.NAME) as HeaderMediator).header;
			header.x = stage.stageWidth/2 - header.width/2;
			
			var nav:NavMenu = (facade.retrieveMediator(NavMediator.NAME) as NavMediator).nav;
			nav.x = header.x + 200;
			
			var drop:DropDown = (facade.retrieveMediator(DropDownMediator.NAME) as DropDownMediator).drop;
			drop.x = header.x + 16;
		}
	}
}