package  {
	
	import com.danielfreeman.madcomponents.UIButton;
	import flash.display.MovieClip;
	
	public class ConversationGameButton extends MovieClip {

		
		var correctAnswer : Boolean;
		
		public function ConversationGameButton(label : String, correctAnswer : Boolean) {
			var button:UIButton = new UIButton(this, 100, 50, label, 0xCCFFCC, new <uint>[]);
			this.correctAnswer = correctAnswer;
	

		}

	}
	
}
