package  {
	
	import flash.display.MovieClip;
	import flash.events.TouchEvent;
	import fl.controls.ComboBox;
	import fl.data.DataProvider;
	import flash.events.Event;
	import fl.transitions.Tween;
	import fl.transitions.easing.Strong;
	
	public class TopBarView extends MovieClip{

		var topBar : MovieClip;
		var httpManager : HTTPManager;
		var patientsComboBox:ComboBox;
		var main : Main;
		var offlineDNI : String;
		var offlinePatient : String;
		
		public function TopBarView(main : Main,httpManager : HTTPManager) {
			this.httpManager = httpManager;
			this.main = main;
			httpManager.setTopBar(this);
			topBar = new topBar_mc;
			setInitialBarView();
			
			addChild(topBar);
		}
		
		private function setInitialBarView():void{
			topBar.password_txt.displayAsPassword = true;
			topBar.loginButton_mc.addEventListener(TouchEvent.TOUCH_TAP,testLogin);
			topBar.offlineLoginButton_mc.addEventListener(TouchEvent.TOUCH_TAP, startOfflineMode);
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
			setInitialBarView();
		}
		
		public function logoutOfflineMode(e : Event):void{					
			topBar.gotoAndStop(1);			
			setInitialBarView();
		}
		
		public function startBitacoraScreen(e : Event):void{
			main.startBitacoraScreen();
		}
		
		public function changeSelectedPatient(e : Event):void{
			main.changeSelectedPatient(patientsComboBox.selectedIndex);
		}
		
		public function startOfflineMode(e : Event):void{
			main.startOfflineMode();
			offlineDNI = topBar.username_offline_txt.text;
			topBar.gotoAndStop(3);
			topBar.loggedOfflineUser_txt.text = "";
			topBar.loggedOfflineUser_txt.text = offlineDNI;
			topBar.logout_mc.addEventListener(TouchEvent.TOUCH_TAP, logoutOfflineMode);
		}
		
		public function getOfflineDNI():String{
			return offlineDNI;
		}
		
		public function getOfflinePatient():String{
			return topBar.offline_patient_txt.text;
		}
		
		public function loginFailed():void{
			new Tween(topBar.loginFailed_mc, "alpha", Strong.easeOut, 1, 0, 2, true);
		}

	}
	
}
