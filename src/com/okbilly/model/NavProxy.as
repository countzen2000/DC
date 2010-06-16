package com.okbilly.model
{
	import com.okbilly.model.dto.ItemDTO;
	import com.okbilly.model.dto.MenuDTO;
	
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	public class NavProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "NavProxy";
		
		private var _mainArray:Array = [
			new MenuDTO({id:1, name:"ALL CEREMIC"}),
			new MenuDTO({id:1, name:"PFM/FULL CAST"}),
			new MenuDTO({id:1, name:"IMPLANTS"}),
			new MenuDTO({id:1, name:"SNORING/SLEEP APENA"}),
			new MenuDTO({id:1, name:"DENTURES, RPDs/OTHER"}),
			new MenuDTO({id:1, name:"DIAGNOSTIC WAX UP/PROVISIONS"}),
			new MenuDTO({id:1, name:"COMPOSITES"})
		];
		
		private var testData:Array = 
			[
				new ItemDTO({id: 1, name:"Cement Retained Crowns",url:"http://hwhat.com/dc/images/1.png"}),
				new ItemDTO({id: 2, name:"Screw Retained Crowns",url:"http://hwhat.com/dc/images/2.png"}),
				new ItemDTO({id: 3, name:"Overdentures",url:"http://hwhat.com/dc/images/3.png"}),
				new ItemDTO({id: 4, name:"CAD/CAM Milled Bars",url:"http://hwhat.com/dc/images/4.png"}),
				new ItemDTO({id: 5, name:"Surgical CT Guides",url:"http://hwhat.com/dc/images/5.png"}),
				new ItemDTO({id: 6, name:"Conventional Surgical Guides",url:"http://hwhat.com/dc/images/6.png"}),
				new ItemDTO({id: 7, name:"TBD",url:"http://hwhat.com/dc/images/7.png"}),
				new ItemDTO({id: 8, name:"TBD-2",url:"http://hwhat.com/dc/images/8.png"})
				]
		
		public function NavProxy()
		{
			super(NAME, null);
			buildData();
		}
		
		//for testing
		private function buildData():void
		{
			for each (var item:MenuDTO in _mainArray) {
				var random:Number = Math.round(Math.random() * 5)+2
				for (var i:int = 0; i < random; i++) {
					var random2:Number = Math.round(Math.random() * 6)+1
					item.Items.push(testData[random2]);
				}
			}
		}
		
		public function get navArray():Array
		{
			return _mainArray;
		}
	}
}