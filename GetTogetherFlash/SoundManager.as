package  {
	import flash.media.Sound;
	import flash.events.Event;
	import flash.media.SoundChannel;
	
	public class SoundManager {
		
		static var channel:SoundChannel = new SoundChannel();
		static var gameJingle : Sound = new PlayingJingle();  
		static var correctSound : Sound = new RightSound();
		static var wrongSound : Sound= new WrongSound();

		public function SoundManager() {
			
			
		}
		
		private static function loopJingle(e:Event):void{
			 channel = gameJingle.play();
			 channel.addEventListener(Event.SOUND_COMPLETE, loopJingle);

		}
		
		public static function playGameJingle():void{
			channel = gameJingle.play();
			channel.addEventListener(Event.SOUND_COMPLETE, loopJingle);
		}
		
		public static function stopGameJingle():void{
			channel.stop();
			channel = null;			
		}
		
		public static function playCorrectSound():void{
			correctSound.play();
		}
		
		public static function playWrongSound():void{
			wrongSound.play();
		}
		
		

	}
	
}
