package  {
	
	import fl.controls.ComboBox;
	import fl.data.DataProvider;
	import flash.display.MovieClip;
	public class PackageOptionPicker extends MovieClip {
		
		var packageOptions : Array;
		var cb:ComboBox;
		var packagesOptions : Array;

		public function PackageOptionPicker() {
			

			cb = new ComboBox();
		
			cb.x = 570;
			cb.y = 200;
			cb.width=270;
			cb.height=92;
			
			

			
			
			
		}
		

		function getSelectedUrl():String {
			if(cb.selectedIndex == -1){
				return packagesOptions[0].url;
			}else{
				return packagesOptions[cb.selectedIndex].url;
			}
			
		}
		
		public function setPackages(packages : Array){
			this.packagesOptions = packages;	
			var displayNames : Array = new Array();
			for(var i : int = 0;i<packagesOptions.length;i++){
				displayNames.push(packagesOptions[i].displayName);
			}
			cb.dataProvider = new DataProvider(displayNames);
			addChild(cb);
		}

	}
	
}
