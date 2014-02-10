package  {
	import flash.media.Sound;
	import flash.events.Event;
	import flash.media.SoundChannel;
	
	public class SoundManager {
		
		static var channel:SoundChannel = new SoundChannel();
		static var gameJingle : Sound = new PlayingJingle(); 
		static var wrongSound : Sound = new WrongSound();
		static var correctSound : Sound = new RightSound();
		static var sigueAsi : Sound= new SigueAsi();
		static var perfecto : Sound= new Perfecto();
		static var felicitaciones : Sound= new Felicitaciones();
		static var fantastico : Sound= new Fantastico();
		static var excelente : Sound= new Excelente();
		
		static var correctSounds : Array = new Array(correctSound,sigueAsi,perfecto,fantastico,excelente);

		public function SoundManager() {
			/*
			correctSounds = 
			correctSounds.push(correctSound);
			correctSounds.push(sigueAsi);
			correctSounds.push(perfecto);
			correctSounds.push(fantastico);
			correctSounds.push(excelente);
			*/
		}
		
		private static function loopJingle(e:Event):void{
			 //channel = gameJingle.play();
			 //channel.addEventListener(Event.SOUND_COMPLETE, loopJingle);

		}
		
		public static function playGameJingle():void{
			//channel = gameJingle.play();
			//channel.addEventListener(Event.SOUND_COMPLETE, loopJingle);
		}
		
		public static function stopGameJingle():void{
			channel.stop();
			channel = null;			
		}
		
		public static function playCorrectSound():void{
			var randomInteger : Number = (Math.floor(Math.random() * 5));
			correctSounds[randomInteger].play();
		}
		
		public static function playWrongSound():void{
			wrongSound.play();
		}
		
		public static function playVictorySound():void{
			felicitaciones.play();
		}
		
		

	}
	
}
