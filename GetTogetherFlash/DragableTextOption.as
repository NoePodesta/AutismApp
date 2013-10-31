package  {
	
	import flash.events.TouchEvent;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.net.URLRequest;

	
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class DragableTextOption extends ClassificationOption {


		
		var textArea : TextField;
		var textFormat : TextFormat;
		
		
		public function DragableTextOption(gameManager : GameManager,content : String, positionX : int, positionY : int, group : int) {
			super(gameManager, new int(positionX), new int(positionY), group);
			addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			
			
			
		
			textArea = new TextField();
			textArea.width = 220;
			textArea.height = 35;
			textArea.border = true;
			textArea.wordWrap = true;
			textArea.background = true;
			textArea.backgroundColor = 0xFFFFFF;				
			
			textFormat = new TextFormat;
			textFormat.size = 25;
			textFormat.align = TextFormatAlign.CENTER;
			textFormat.font = "Charlemagne Std";
			textFormat.bold = true;
			
			textArea.defaultTextFormat = textFormat;
			textArea.text = content;				
			
			addChild(textArea);
			onCompleteTextLoad();
			
			
			
			
		}

				
		
		function onCompleteTextLoad ():void
		{
			y = originalY;
			x = originalX;
			
			gameManager.onOptionLoadComplete();
		}
		

	}
	
}