package PetriNetManager{
	
	/**
	* Класс состояния сети Петри
	*/
	public class State {

		var markersCount: Number;
		private var id: Number;
		
		/**
		* Возвращает id состояния
		*/
		public function get Id():Number {
			return id;
		}
		
		/**
		* Конструктор
		*/
		public function State(id, markersCount) {
			this.id = id;
			this.markersCount = markersCount;
		}
		
		/**
		* Возвращает true, если количество маркеров у состояния > 0
		*/
		public function hasMarkers():Boolean {
			return markersCount > 0;
		}
		
		/**
		* Возвращает количество маркеров у состояния
		*/
		public function getMarkers():Number {
			return markersCount;
		}
		
		/**
		* Уменьшает количество маркеров состояния на 1
		*/
		public function decMarkers():void {
			this.markersCount--;
		}
		
		/**
		* Увеличивает количество маркеров состояния на 1
		*/
		public function incMarkers():void {
			this.markersCount++;
		}

	}
	
}
