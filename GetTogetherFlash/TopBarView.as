package  {
	
	import flash.display.MovieClip;
	import flash.events.TouchEvent;
	import fl.controls.ComboBox;
	import fl.data.DataProvider;
	import flash.events.Event;
	
	public class TopBarView extends MovieClip{

		var topBar : MovieClip;
		var httpManager : HTTPManager;
		var patientsComboBox:ComboBox;
		var main : Main;
		
		public function TopBarView(main : Main,httpManager : HTTPManager) {
			this.httpManager = httpManager;
			this.main = main;
			httpManager.setTopBar(this);
			topBar = new topBar_mc;
			topBar.loginButton_mc.addEventListener(TouchEvent.TOUCH_TAP,testLogin);
			addChild(topBar);
		}
		
		public function testLogin(e : TouchEvent):void{
			httpManager.testLogin(topBar.username_txt.text, topBar.password_txt.text);
		}
		
		public function testConnection(e : TouchEvent):void{
			httpManager.testConnection();
		}
		
		public function loggedIn(result : String):void{
			topBar.gotoAndStop(2);
			topBar.logout_mc.addEventListener(TouchEvent.TOUCH_TAP, logout);
			topBar.startBitacora_mc.addEventListener(TouchEvent.TOUCH_TAP, startBitacoraScreen);
			topBar.loggedUser_txt.text = "";
			topBar.loggedUser_txt.text = result;
		}
		
		public function setPatients(patients : Array):void{
			patientsComboBox = new ComboBox();
			patientsComboBox.dataProvider = new DataProvider(patients);
			patientsComboBox.x = 870;
			patientsComboBox.y = 35;	
			patientsComboBox.addEventListener(Event.CHANGE,changeSelectedPatient);
			addChild(patientsComboBox);
		}
		
		public function logout(e : Event):void{
			main.logoutTherapist();
			removeChild(patientsComboBox);
			topBar.gotoAndStop(1);
			
			topBar.loginButton_mc.addEventListener(TouchEvent.TOUCH_TAP,testLogin);
		}
		
		public function startBitacoraScreen(e : Event):void{
			main.startBitacoraScreen();
		}
		
		public function changeSelectedPatient(e : Event):void{
			main.changeSelectedPatient(patientsComboBox.selectedIndex);
		}

	}
	
}
