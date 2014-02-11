package  {
	
	import flash.net.SharedObject;
	
	public class SaveManager {

		var mainManager : Main;
		var httpManager : HTTPManager;
		
		public function SaveManager(mainManager : Main, httpManager : HTTPManager) {
			this.mainManager = mainManager;
			this.httpManager = httpManager;
		}
		
		public function addLocalResult(gameType : String, resultColector : ResultColector, offlineTherapist : String, offlinePatient : String){

			var offlineRecord: Object = new Object();
			offlineRecord.gameType = gameType;
			offlineRecord.therapistId = offlineTherapist;
			offlineRecord.patientId = offlinePatient;
			offlineRecord.correctAnswers = resultColector.correctAnswers;
			offlineRecord.wrongAnswers = resultColector.wrongAnswers;
			offlineRecord.packageUsed = resultColector.packageUsed;
			offlineRecord.currentDate = resultColector.currentDate;
			
			// Get the shared object.
			var so:SharedObject = SharedObject.getLocal("getTogether");
			
			if(so.data.offlineRecords == null){
				so.data.offlineRecords = new Array();
			}
			
			so.data.offlineRecords.push(offlineRecord);
		
			// And flush our changes.
			so.flush();
			
			mainManager.destroyGame();
			
		}
		
		public function addLocalBitacora(bitacora : String, offlineTherapist : String, offlinePatient : String){

			var offlineRecord: Object = new Object();
			offlineRecord.gameType = GameType.BITACORA;
			offlineRecord.therapistId = offlineTherapist;
			offlineRecord.patientId = offlinePatient;
			offlineRecord.bitacoraText = bitacora;

			offlineRecord.currentDate = new Date().toLocaleString();
			
			// Get the shared object.
			var so:SharedObject = SharedObject.getLocal("getTogether");
			
			if(so.data.offlineRecords == null){
				so.data.offlineRecords = new Array();
			}
			
			so.data.offlineRecords.push(offlineRecord);
		
			// And flush our changes.
			so.flush();
			
			
		}
		
		public function getOfflineResults(dniTherapist : String):Array{
			// Get the shared object.
			var so:SharedObject = SharedObject.getLocal("getTogether");
			
			var therapistOfflineRecords : Array = new Array();
			if(so.data.offlineRecords != null){
				for(var i:int = 0;i<so.data.offlineRecords.length;i++){
					if(so.data.offlineRecords[i].therapistId == dniTherapist){
						therapistOfflineRecords.push(so.data.offlineRecords[i]);						
					}
				}	
			}
			
			
			
			return therapistOfflineRecords;
		}
		
		public function removeOfflineRecords(dniTherapist : String):void{
			var so:SharedObject = SharedObject.getLocal("getTogether");
			
			for(var i:int = 0;i<so.data.offlineRecords.length;i++){
				if(so.data.offlineRecords[i].therapistId == dniTherapist){
					httpManager.sendOfflineRecord(so.data.offlineRecords[i]);
					delete(so.data.offlineRecords[i]);
				}
			}	
			so.flush();
		}

	}
	
}
