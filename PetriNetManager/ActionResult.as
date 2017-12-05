package PetriNetManager {
	/**
	* Класс, представляющий собой результат выполнения перехода
	*/
	public class ActionResult {

		var successed:Boolean;
		var inputStates:Vector.<State> = new Vector.<State>();
		
		/**
		* Конструктор
		*/
		public function ActionResult( successed, inputStates:Vector.<State> ) {
			this.successed = successed;
			this.inputStates = inputStates;
		}
		
		/**
		* Возвращает true, если переход был выполнен успешно
		*/
		public function isSuccessed():Boolean{
			return successed;
		}
		
		/**
		* Возвращает массив входных состояний для перехода. Используйте его для того, чтобы вывести список состояний, в которых отсутствуют маркеры - в случае, если переход не был выполнен
		*/
		public function getInputStates():Vector.<State>{
			return inputStates;
		}

	}
	
}
