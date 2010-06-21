package com.okbilly.view
{
	import com.okbilly.MainFacade;
	import com.okbilly.components.Header;
	import com.okbilly.components.NavMenu;
	import com.okbilly.model.NavProxy;
	import com.okbilly.utilities.DynamicEvent;
	
	import flash.events.Event;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class NavMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "NavMediator";
		public static const MENU_CHOOSE_EVENT:String = "MenuChoosenEvent";
		
		private var _navProxy:NavProxy;
		
		public function NavMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			
		}
		
		public function build():void
		{
			_navProxy = facade.retrieveProxy(NavProxy.NAME) as NavProxy;
			if (_navProxy == null) {
				_navProxy = new NavProxy();
				facade.registerProxy(_navProxy);
			}
			
			nav.build(_navProxy.navArray);
			nav.addEventListener(MENU_CHOOSE_EVENT, onMenuItemChoosen);
		}
		
		private function onMenuItemChoosen(e:DynamicEvent):void
		{
			e.stopImmediatePropagation();
			this.sendNotification(MainFacade.MENU_SELECTED, e.data);
		}
		
		public function get nav():NavMenu
		{
			return viewComponent as NavMenu;
		}
	}
}