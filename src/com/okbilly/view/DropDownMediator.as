package com.okbilly.view
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	import com.greensock.easing.Quad;
	import com.greensock.easing.Quint;
	import com.greensock.easing.RoughEase;
	import com.greensock.easing.Strong;
	import com.okbilly.MainFacade;
	import com.okbilly.components.DropDown;
	import com.okbilly.model.dto.MenuDTO;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class DropDownMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "DropDownMediator";
		
		public function DropDownMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			drop.addEventListener(MouseEvent.ROLL_OUT, onOut);
		}
		override public function listNotificationInterests():Array
		{
			return [
				MainFacade.MENU_SELECTED,
				MainFacade.MENU_UNSELECTED
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName()) {
				case MainFacade.MENU_SELECTED:
					if (drop.y == 125) {
						drop.hide()
						drop.y = -30;
						setTimeout(drop.build, 150, (notification.getBody() as MenuDTO).Items);
						setTimeout(showDrop, 100);
					} else {
						setTimeout(drop.build, 300, (notification.getBody() as MenuDTO).Items);
						showDrop();
					}
					break;
				case MainFacade.MENU_UNSELECTED:
					hideDrop();
					break;
			}	
		}
		
		public function showDrop():void
		{
			TweenLite.to(drop, .3, {y: 125});
			//drop.y = 125;
		}
		
		public function hideDrop():void
		{
			TweenLite.to(drop, .3, {y: -30});
			//drop.y = -30;;
		}
		
		public function get drop():DropDown
		{
			return viewComponent as DropDown
		}
		
		private function onOut(e:Event):void
		{
			this.sendNotification(MainFacade.MENU_UNSELECTED);
		}
	}
}