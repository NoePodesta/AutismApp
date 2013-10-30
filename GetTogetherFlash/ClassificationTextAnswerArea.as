package{
	
	import flash.display.MovieClip;
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class ClassificationTextAnswerArea extends ClassificationAnswerArea{

		
		
		var textArea : TextField;
		var textFormat : TextFormat;
		
		public function ClassificationTextAnswerArea(gameManager:GameManager, classificationGroup : int, optionName: String, content : String, positionY : int){
			super(gameManager, optionName, classificationGroup, positionY);			
						
			
			
			textArea = new TextField; 
			textArea.width = 500;
			textArea.height = 300;
			
			textArea.border = true;
			textArea.wordWrap = true;
			textArea.background = true;
			textArea.backgroundColor = 0xFFFFFF;
			
			textFormat = new TextFormat;
			textFormat.size = 50;
			textFormat.align = TextFormatAlign.CENTER;
			textFormat.font = "Charlemagne Std";
			textFormat.bold = true;
			
			textArea.defaultTextFormat = textFormat;
			textArea.text = content;
			
			display.x = textArea.width / 2 - display.width/2;
			
			addChild(textArea);
					
			
			
			x = 1024/2 - width/2;
			
		}
		
		
		
	
	}

}