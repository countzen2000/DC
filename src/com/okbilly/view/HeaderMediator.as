package com.okbilly.view
{
	import com.okbilly.components.Header;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class HeaderMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "HeaderMediator";
		
		public function HeaderMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			
		}
		
		public function get header():Header
		{
			return viewComponent as Header;
		}
	}
}