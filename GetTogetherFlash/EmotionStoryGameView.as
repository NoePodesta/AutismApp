package  {
	import flash.display.MovieClip;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.LoaderInfo;
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import flash.geom.Rectangle;
	
	public class EmotionStoryGameView extends GameView {
		
		var storyTextArea : TextField;
		var storyTextFormat : TextFormat;

		public function EmotionStoryGameView(manager : EmotionStoryGameManager, graphicOptions : Array) {
			super(manager);
			background = new cognitionGameView_mc();
			setEventListeners();
			
			storyTextArea = new TextField; 
			storyTextArea.width = 500;
			storyTextArea.height = 300;
			storyTextArea.y = 115;
			storyTextArea.x = 1024 / 2 - storyTextArea.width/2;
			
			storyTextArea.border = true;
			storyTextArea.wordWrap = true;
			storyTextArea.background = true;
			storyTextArea.backgroundColor = 0xFFFFFF;
			
			storyTextFormat = new TextFormat;
			storyTextFormat.size = 50;
			storyTextFormat.align = TextFormatAlign.CENTER;
			storyTextFormat.font = "Charlemagne Std";
			storyTextFormat.bold = true;
			
			storyTextArea.defaultTextFormat = storyTextFormat;
			storyTextArea.text = "Juani y Noe estan haciendo la tesis. Como se sienten ellos?"
			
			
		
			
			addChild(background);
			background.addChild(storyTextArea);
			
			var i : int;
			for(i = 0; i<graphicOptions.length;i++){
				addChildAt(graphicOptions[i],1);
			}
			(manager as EmotionStoryGameManager).loadComplete();
			
		}
		
		override public function getAnswerBoundaries() : Rectangle{
			return storyTextArea.getRect(this) as Rectangle;
		}
		
	
	}
	
}
