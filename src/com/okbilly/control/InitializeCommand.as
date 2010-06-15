package com.okbilly.control
{
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
			var stage:Stage = note.getBody() as Stage;
			facade.registerMediator(new StageMediator(stage));
		}
	}
}