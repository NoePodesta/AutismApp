package  {
	
	import flash.display.MovieClip;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.events.MouseEvent;
	
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class EmotionGameView extends GameView{

		

		var answer : EmotionGameOption;
		
		
		var answerTextArea : TextField;
		var answerTextFormat : TextFormat;
		
			
			
		
		public function EmotionGameView(manager : EmotionGameManager, options : Array,answer : EmotionGameOption) {
			super(manager);
			this.answer = answer;
			background = new emotionGameView_mc();
			setEventListeners();
			
			answerGraphicArea = new emotionGraphicAnswer_mc; 
			answerGraphicArea.y = 115;
			answerGraphicArea.x = 1024 / 2 - answerGraphicArea.width/2;
			
			answer.x = 1024 / 2 - 72; 
			answer.y = 130;
			
			answerTextArea = new TextField();
			answerTextArea.width = 380;
			answerTextArea.height = 56;
			answerTextArea.x = 1024 / 2 - 380/2;
			answerTextArea.y = 44;
			answerTextArea.border = true;
			answerTextArea.wordWrap = true;
			answerTextArea.background = true;
			answerTextArea.backgroundColor = 0xFFFFFF;
			
			answerTextFormat = new TextFormat;
			answerTextFormat.size = 43;
			answerTextFormat.align = TextFormatAlign.CENTER;
			answerTextFormat.font = "Charlemagne Std";
			answerTextFormat.bold = true;
		
			
			answerTextArea.defaultTextFormat = answerTextFormat;
						
			background.addChild(answerGraphicArea);
			background.addChild(answerTextArea);
			addChildAt(background,0);
			addChildAt(answer,1);
			var i : int;
			for(i = 0; i<options.length;i++){
				addChildAt(options[i],1);
			}
			
			
		}
		
		
		
		
		
		
		
		public function setCorrectEmotionText(emotionName : String) : void{
			answerTextArea.text = emotionName;
		}
		
		public function startAnswerGif() : void{
			answer.startGif();
		}
		
		
		
		/*
		public function activateResult(e : TouchEvent) : void {
			manager.checkAnswer(e.currentTarget as MovieClip);
		}
		*/
		
		
	
		/*
		function crop( _x:Number, _y:Number, _width:Number, _height:Number, displayObject:DisplayObject = null):Bitmap
		{
	   
			var cropArea:Rectangle = new Rectangle( 0, 0, _width, _height );
		   var croppedBitmap:Bitmap = new Bitmap( new BitmapData( _width, _height ), PixelSnapping.ALWAYS, true );
		   croppedBitmap.bitmapData.draw( (displayObject!=null) ? displayObject : stage, new Matrix(1, 0, 0, 1, -_x, -_y) , null, null, cropArea, true );
		   return croppedBitmap
		}
		
*/
	}
	
}
