package{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.LoaderInfo;
	
	
	public class ClassificationTextAnswerArea extends ClassificationAnswerArea{


		private var content : String;
		private var answerImage : Bitmap;
		private var imageLoader : Loader;
		
		public function ClassificationTextAnswerArea(gameManager:GameManager, classificationGroup : int, optionName: String, content : String, positionY : int){
			super(gameManager, optionName, classificationGroup, positionY);			
			this.content = content;		
			imageLoader= new Loader();
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteImageLoad);
			imageLoader.load(new URLRequest("SignsImages/QuestionMark.png"));
		}
		
	
		
		function onCompleteImageLoad(event : Event){
			answerImage = imageLoader.content as Bitmap;
			onLoadComplete();	
		}
		
		public function getQuestion() : String{
			return content;					
		}		
		
		
		public function getImage() : Bitmap{
			return answerImage;
		}
		
		
		
	
	}

}