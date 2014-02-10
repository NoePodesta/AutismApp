package  {
	
	import com.danielfreeman.madcomponents.UIButton;
	import flash.display.MovieClip;
	
	public class ConversationGameButton extends MovieClip {

		
		var correctAnswer : Boolean;
		
		public function ConversationGameButton(label : String, correctAnswer : Boolean) {
			var button:ConversationButton = new ConversationButton;
			button.textContent_txt.text = label;
			button.textContent_txt.wordWrap = true;
			addChild(button);
			this.correctAnswer = correctAnswer;
		}

	}
	
}
