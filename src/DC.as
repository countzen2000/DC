package
{
	import com.greensock.plugins.BlurFilterPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.okbilly.MainFacade;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.system.Security;
	
	public class DC extends Sprite
	{
		public static var externalXML:String = "";
		public static var logoURL:String = "";
		
		public function DC()
		{
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			TweenPlugin.activate([BlurFilterPlugin]);
			
			if (this.loaderInfo.parameters.xmlURL) {
				externalXML = this.loaderInfo.parameters.xmlURL as String;
			} else {
				externalXML = "http://hwhat.com/dc/xml/sample.xml";	
			}
			
			if (this.loaderInfo.parameters.logoURL) {
				logoURL = this.loaderInfo.parameters.logoURL as String;
			} else {
				logoURL = "index.html";	
			}
			
			MainFacade.getInstance().init( this.stage );
		}
	}
}