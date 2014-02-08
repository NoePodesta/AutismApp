package  {
	
	import com.danielfreeman.madcomponents.UIButton;
	import flash.display.MovieClip;
	
	public class ConversationGameButton extends MovieClip {

		
		var correctAnswer : Boolean;
		
		public function ConversationGameButton(label : String, correctAnswer : Boolean) {
			var button:ConversationButton = new ConversationButton;
			button.textContent_txt.text = label;
			addChild(button);
			this.correctAnswer = correctAnswer;
		}

	}
	
}
