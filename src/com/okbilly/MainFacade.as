package com.okbilly
{
	import com.okbilly.control.InitializeCommand;
	
	import flash.display.Stage;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	public class MainFacade extends Facade implements IFacade
	{
		//Key for Modules
		public var KEY:String = "MainFacade";
		
		public static var instance:MainFacade
		public static const INIT:String = "InitialzeCOmmand";
		public static const MENU_SELECTED:String = "MenuItemSelected"; 
		public static const DATA_READY:String = "DataReady";
		
		public function MainFacade()
		{
			super(KEY);
		}
		
		public static function getInstance(): MainFacade
		{
			if (instance == null)
			{
				instance = new MainFacade();
			}
			
			return instance as MainFacade;
		}
		
		override protected function initializeController():void
		{
			super.initializeController();
			registerCommand(INIT, InitializeCommand);
			
		}
		
		public function init( stage:Object ):void
		{
			sendNotification( INIT, stage );
		}
	}
}