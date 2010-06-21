package com.okbilly.control
{
	import com.okbilly.components.DropDown;
	import com.okbilly.components.Header;
	import com.okbilly.components.NavMenu;
	import com.okbilly.model.NavProxy;
	import com.okbilly.view.DropDownMediator;
	import com.okbilly.view.HeaderMediator;
	import com.okbilly.view.NavMediator;
	import com.okbilly.view.StageMediator;
	
	import flash.display.Stage;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class InitializeCommand extends SimpleCommand implements ICommand
	{
		public function InitializeCommand()
		{
			trace ("Initialize Command!");
		}
		
		override public function execute (note:INotification):void
		{
			facade.registerProxy(new NavProxy());
			
			var header:Header = new Header();
			var headerMediator:HeaderMediator = new HeaderMediator(header);
			facade.registerMediator(headerMediator);
			
			facade.registerMediator(new NavMediator(new NavMenu()));
			
			var dropDown:DropDown = new DropDown();
			facade.registerMediator(new DropDownMediator(dropDown));
			
			var stage:Stage = note.getBody() as Stage;
			facade.registerMediator(new StageMediator(stage));
			
			
		}
	}
}