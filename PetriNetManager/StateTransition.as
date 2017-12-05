package PetriNetManager {
	
	import PetriNetManager.ActionResult;
	/**
	* Класс перехода в сети Петри
	*/
	public class StateTransition {

		private var id:Number;
		var inputStates:Vector.<State> = new Vector.<State>();
		var outputStates:Vector.<State> = new Vector.<State>();
		
		/**
		* Возвращает id перехода
		*/
		public function get Id():Number {
			return id;
		}		
		
		/**
		* Конструктор
		*/
		public function StateTransition( id,outputStates:Vector.<State>,inputStates:Vector.<State>) {
			this.id = id;
			this.outputStates = outputStates;
			this.inputStates = inputStates;
		}
		
		/**
		* Возвращает true, если переход активен
		*/
		public function isActive():Boolean{
			
			for each ( var s:State in inputStates ){
				if(!s.hasMarkers())
					return false;
			}

			return true;
		}
		
		/**
		* Выполняет переход. Возвращает объект ActionResult - результат перехода
		*/
		public function executeTransition():ActionResult{
			
			var canExecute = isActive();
			if(canExecute){
				
				var s:State;
				
				for each ( s in inputStates ){
					s.decMarkers();
				}
				
				for each ( s in outputStates ){
					s.incMarkers();
				}
			}
			return new ActionResult(canExecute, this.inputStates)
					
		}
		
		/**
		* Отменяет переход
		*/
		public function redoTransition(){
				var s:State;
				
				for each ( s in inputStates ){
					s.incMarkers();
				}
				
				for each ( s in outputStates ){
					s.decMarkers();
				}
		}
		
	}
	
}
