package  {
	
	public class Therapist {
		
		var id : int;
		var therapistName : String;
		var surname : String;
		var patients : Array;
		var patientsId : Array;
		var packages : Array;
		var dni : String;

		public function Therapist(id : int, therapistName : String, surname : String,patients : Array, patientsId : Array, packages : Array, dni : String){
			this.id = id;
			this.therapistName = therapistName;
			this.surname = surname;
			this.patients = patients;
			this.patientsId = patientsId;
			this.packages = packages;
			this.dni = dni;
			// constructor code
		}

	}
	
}
