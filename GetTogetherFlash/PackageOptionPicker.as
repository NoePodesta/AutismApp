package  {
	
	import fl.controls.ComboBox;
	import fl.data.DataProvider;
	import flash.text.TextFormat;
	import flash.display.MovieClip;
	public class PackageOptionPicker extends MovieClip {
		
		var packageOptions : Array;
		var cb:ComboBox;
		var tf:TextFormat;
		var packagesOptions : Array;

		public function PackageOptionPicker() {
			
			
			tf = new TextFormat();
			tf.font = "ScalaSansLf*";
			tf.size = 25;
			tf.color = 0x747070;

			cb = new ComboBox();
			
		
			cb.x = 510;
			cb.y = 265;
			cb.width=300;
			cb.height=40;
			
			

			
			
			
		}
		

		function getSelectedUrl():String {
			if(cb.selectedIndex == -1){
				return packagesOptions[0].url;
			}else{
				return packagesOptions[cb.selectedIndex].url;
			}
			
		}
		
		function getSelectedPackageName():String{
			if(cb.selectedIndex == -1){
				return packagesOptions[0].displayName;
			}else{
				return packagesOptions[cb.selectedIndex].displayName;
			}
		}
		
		public function setPackages(packages : Array){
			this.packagesOptions = packages;	
			var displayNames : Array = new Array();
			for(var i : int = 0;i<packagesOptions.length;i++){
				displayNames.push(packagesOptions[i].displayName);
			}
			cb.dataProvider = new DataProvider(displayNames);
			cb.textField.setStyle("textFormat", tf);
			cb.dropdown.rowHeight = 30;
			cb.dropdown.setStyle("cellRenderer", CustomCellRenderer);
			addChild(cb);
		}

	}
	
}
