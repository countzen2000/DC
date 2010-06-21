package com.okbilly.view
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;
	import com.okbilly.MainFacade;
	import com.okbilly.components.DropDown;
	import com.okbilly.model.dto.MenuDTO;
	
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
		
		override public function listNotificationInterests():Array
		{
			return [MainFacade.MENU_SELECTED];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName()) {
				case MainFacade.MENU_SELECTED:
					if (drop.y == 125) {
						hideDrop();
					}
					drop.build((notification.getBody() as MenuDTO).Items);
					showDrop();
					break;
			}	
		}
		
		public function showDrop():void
		{
			TweenLite.to(drop, .7, {y: 125, ease:Quad.easeOut});
		}
		
		public function hideDrop():void
		{
			TweenLite.to(drop, .7, {y: 0, ease:Quad.easeOut});
		}
		
		public function get drop():DropDown
		{
			return viewComponent as DropDown
		}
	}
}