package  {
	import com.danielfreeman.madcomponents.UIList;
	import com.danielfreeman.madcomponents.Attributes;
	import flash.display.MovieClip;
	import com.danielfreeman.madcomponents.UINavigation;
	import flash.events.Event;
	import flash.events.TouchEvent;
	import com.danielfreeman.madcomponents.UIButton;
	
	public class ConversationGameView extends GameView {

		var conversationFlow : Array;
		var mainConversationList : UIList;
		
		var conversationOptions : Array;
		var currentStage : int;
		var buttons : Array;

		
		
		public function ConversationGameView(gameManager : GameManager, conversationFlow : Array, conversationOptions : Array, gameType : String, question:String) {
			super(gameManager,gameType);
			
			currentStage = 0;
			
			this.conversationFlow = conversationFlow;
			this.conversationOptions = conversationOptions;
			background.question_txt.text = question;
			createMadComponents();
		
		}
		
		
		
		
		function createMadComponents() : void{
			var attributes : Attributes = new Attributes(0,0,300,20);			

			mainConversationList = new UIList(this, <list alignV="scroll"></list>,attributes);
			mainConversationList.data = new Array(conversationFlow[0]);			
			mainConversationList.scrollEnabled = true;
			
			removeChild(mainConversationList);
	
			var rectangle : MovieClip = new emotionGraphicAnswerMask_mc;
			rectangle.x = 1024/2 - rectangle.width/2;
			rectangle.y = 96;
			
			//mainConversationList.x = 1024/2 - rectangle.width/2;
			//mainConversationList.y = 62;
			
			rectangle.addChild(mainConversationList);
			addChild(rectangle);		
			
			createButtonsForStage(currentStage);
			
		}
		
		
		function createButtonsForStage(level : int):void{
			var leftX : int = 1024/2 - 100;
			var rightX : int = 1024/2 + 100;
			buttons = new Array(conversationOptions[level].length);
			for(var i:int = 0;i<conversationOptions[level].length;i++){
				var button : ConversationGameButton;
				if(i==0){
					button = new ConversationGameButton(conversationOptions[level][i].label, conversationOptions[level][i].correctAnswer);
					button.y = 410;
					button.x = 1024/4 - button.width/2;	
				}else if(i==1){
					button = new ConversationGameButton(conversationOptions[level][i].label, conversationOptions[level][i].correctAnswer);
					button.y = 410;
					button.x = 1024/4 * 3 - button.width/2;
				}else if(i==2){
					button = new ConversationGameButton(conversationOptions[level][i].label, conversationOptions[level][i].correctAnswer);
					button.y = 560;
					button.x = 1024/4 - button.width/2;
				}else{
					button = new ConversationGameButton(conversationOptions[level][i].label, conversationOptions[level][i].correctAnswer);
					button.y = 560;
					button.x = 1024/4 * 3 - button.width/2;
				}
				addChild(button);
				button.addEventListener(TouchEvent.TOUCH_TAP, checkAnswer);
				buttons[i]=button;
			}
			
		}
		
		function checkAnswer(e : Event):void{
			(manager as ConversationGameManager).checkSentence(e.currentTarget.correctAnswer);
		}
		
		public function proceedToNextQuestion():void{
			currentStage++;
			
			for(var i : int = 0;i<buttons.length;i++){
				removeChild(buttons[i]);
			}
			createButtonsForStage(currentStage);
			var newDataArray : Array = new Array;
			for(var j : int = 0; j<=currentStage*2;j++){
				newDataArray.push(conversationFlow[j]);
			}
			mainConversationList.data = newDataArray;
			
		}
		

	}
	
}
