package {
	
	import fl.controls.listClasses.CellRenderer;
    import flash.text.TextFormat;	
	public class CustomPatientCellRenderer extends CellRenderer {
		
		public function CustomPatientCellRenderer() {
			super();
			
			var tf:TextFormat = new TextFormat();
			tf.font = "ScalaSansLf*";
			tf.size = 15;
			tf.color = 0x747070;
			
			setStyle("textFormat", tf);			
		}
		override protected function drawLayout():void {
			super.drawLayout()
			textField.y += 2;
			textField.x += 4;
		}
		
	}
}