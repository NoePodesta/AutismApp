package{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.LoaderInfo;
	

	
	public class ClassificationImageAnswerArea extends ClassificationAnswerArea{

		
		var content : String;
		var answerImage : Bitmap;		
		var imageLoader:Loader; 
		
		public function ClassificationImageAnswerArea(gameManager:GameManager, classificationGroup : int, imageURL: String, questionLabel : String, positionY : int){
			super(gameManager, optionName, classificationGroup, positionY);				
			this.content = questionLabel;
			imageLoader = new Loader();
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteImageLoad);
			imageLoader.load(new URLRequest(imageURL));				
		}
		
		function onCompleteImageLoad(event : Event){
			answerImage = imageLoader.content as Bitmap;
			gameManager.onOptionLoadComplete();
			
			
		}
		
		public function getQuestion() : String{
			return content;					
		}		
		
		
		public function getImage() : Bitmap{
			return answerImage;
		}
		
		
		
		
	
	}

}