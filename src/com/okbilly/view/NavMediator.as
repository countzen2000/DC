package com.okbilly.view
{
	import com.okbilly.MainFacade;
	import com.okbilly.components.Header;
	import com.okbilly.components.NavMenu;
	import com.okbilly.model.NavProxy;
	import com.okbilly.model.dto.MenuDTO;
	import com.okbilly.utilities.DynamicEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.clearInterval;
	import flash.utils.setTimeout;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class NavMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "NavMediator";
		public static const MENU_CHOOSE_EVENT:String = "MenuChoosenEvent";
		public static const MENU_LOCKED_EVENT:String = "MenuLockedEvent";
		public static const MENU_UNCHOOSE_EVENT:String = "MenuUnchoosenEvent";
		
		private var _navProxy:NavProxy;
		
		private var _intervalTimer:Number;
		
		//private var _selectedNavItem:MenuDTO;
		
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
			
			nav.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			
			//nav.addEventListener(MENU_LOCKED_EVENT, onMenuItemLocked);
			//nav.addEventListener(MENU_UNCHOOSE_EVENT, onMenuItemUnchoosen);
		}
		
		/*private function onMenuItemLocked(e:DynamicEvent):void
		{
			e.stopImmediatePropagation();
			_selectedNavItem = e.data as MenuDTO;
		}
		
		private function onMenuItemUnchoosen(e:DynamicEvent):void
		{
			e.stopImmediatePropagation();
			if (_selectedNavItem == null) {
				this.sendNotification(MainFacade.MENU_UNSELECTED);
			}
		}*/
		
		private function onAddedToStage(e:Event):void
		{
			nav.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			nav.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
			nav.addEventListener(MENU_CHOOSE_EVENT, onMenuItemChoosen);
		}
		
		private function onMenuItemChoosen(e:DynamicEvent):void
		{
			if (_intervalTimer) {
				clearInterval(_intervalTimer);
			}
			e.stopImmediatePropagation();
			this.sendNotification(MainFacade.MENU_SELECTED, e.data);
			_intervalTimer = setTimeout(onTimeOutHide, 3000);
		}
		
		private function onMove(e:Event):void
		{
			if (_intervalTimer) {
				clearInterval(_intervalTimer);
			}
			_intervalTimer = setTimeout(onTimeOutHide, 3000);
		}
		
		private function onTimeOutHide():void
		{
			this.sendNotification(MainFacade.MENU_UNSELECTED);
			
		}
		
		public function get nav():NavMenu
		{
			return viewComponent as NavMenu;
		}
	}
}