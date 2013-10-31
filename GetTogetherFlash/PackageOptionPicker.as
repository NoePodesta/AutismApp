package  {
	
	import fl.controls.ComboBox;
	import fl.data.DataProvider;
	import flash.display.MovieClip;
	public class PackageOptionPicker extends MovieClip {
		
		var packageOptions : Array;
		var cb:ComboBox;

		public function PackageOptionPicker(packageOptions : Array) {
			this.packageOptions = packageOptions;
			
			var dataProvider : Array = new Array(packageOptions.length);
			
			for(var i : int = 0;i<dataProvider.length;i++){
				dataProvider[i] = packageOptions[i].displayName;
			}
			
			cb = new ComboBox();
			cb.dataProvider = new DataProvider(dataProvider);
			cb.x = 570;
			cb.y = 200;
			cb.width=270;
			cb.height=92;
			addChild(cb);
			

			
			
			
		}
		

		function getSelectedUrl():String {
			if(cb.selectedIndex == -1){
				return packageOptions[0].url;
			}else{
				return packageOptions[cb.selectedIndex].url;
			}
			
		}

	}
	
}
