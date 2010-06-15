package com.okbilly.view
{
	import com.greensock.plugins.TweenPlugin;
	import com.okbilly.components.Background;
	
	import flash.display.Stage;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class StageMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "stageMediator";
		
		//TODO holds object for background
		private var _bg:Background;
		
		public function StageMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister() : void
		{
			//TweenPlugin.activate([BlurFilterPlugin]);
			
			_bg = new Background(stage.stageWidth, stage.stageHeight);
			stage.addChild(_bg);
			
		}
		
		public function get stage():Stage
		{
			return viewComponent as Stage;
		}
	}
}