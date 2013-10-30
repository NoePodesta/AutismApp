package{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.LoaderInfo;
	

	
	public class ClassificationImageAnswerArea extends ClassificationAnswerArea{

		
		
		var answerImage : Bitmap;		
		var imageLoader:Loader; 
		
		public function ClassificationImageAnswerArea(gameManager:GameManager, classificationGroup : int, optionName: String, content : String, positionY : int){
			super(gameManager, optionName, classificationGroup, positionY);				
			
			imageLoader = new Loader();
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteImageLoad);
			imageLoader.load(new URLRequest(content));				
		}
		
		function onCompleteImageLoad(event : Event){
			answerImage = imageLoader.content as Bitmap;
			answerImage.width = 250;
			answerImage.height = 350;
			
		
			answerImage.x = display.width / 2 - answerImage.width / 2;
			answerImage.y = 25;
			addChild(answerImage);
			x = 1024/2 - width/2;
			gameManager.onOptionLoadComplete();
			
			
		}
		
		
		
	
	}

}