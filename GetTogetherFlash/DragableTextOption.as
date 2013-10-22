package  {
	
	import flash.events.TouchEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class DragableTextOption extends QAOption {


		
		var answerTextArea : TextField;
		var answerTextFormat : TextFormat;
		
		public function DragableTextOption(gameManager : GameManager,optionText : String, positionX : int, positionY : int, correctAnswer : Boolean) {
			super(gameManager, new int(positionX), new int(positionY), correctAnswer);
			addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
	
			x = positionX;
			y = positionY;
			
			answerTextArea = new TextField();
			answerTextArea.width = 220;
			answerTextArea.height = 35;
			answerTextArea.border = true;
			answerTextArea.wordWrap = true;
			answerTextArea.background = true;
			answerTextArea.backgroundColor = 0xFFFFFF;
			
			
			answerTextFormat = new TextFormat;
			answerTextFormat.size = 25;
			answerTextFormat.align = TextFormatAlign.CENTER;
			answerTextFormat.font = "Charlemagne Std";
			answerTextFormat.bold = true;
			
			answerTextArea.defaultTextFormat = answerTextFormat;
			answerTextArea.text = optionText;
			
			addChild(answerTextArea);
			
		}
		
		function onTouchBegin(e:TouchEvent) { 
			startTouchDrag(e.touchPointID); 
			gameManager.checkAnswer(this, e.stageX, e.stageY);
		} 
 
		function onTouchEnd(e:TouchEvent) { 
			stopTouchDrag(e.touchPointID);
			gameManager.checkAnswer(this, e.stageX, e.stageY);
		}

	}
	
}
