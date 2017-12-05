package  PetriNetManager{
	import flash.events.Event;
	import PetriNetManager.State;
	
	/**
	* Класс события обновления состояния менеджера сети Петри
	*/
	public class StatesUpdateEventHandler extends Event
	{
		public static const STATES_UPDATE_EVENT:String = "statesUpdateEvent"; 

		var params:Vector.<State>;		
		
		/**
		* Возвращает состояния сети Петри
		*/
		public function get States(): Vector.<State>{
			return params;
		}
		
		/**
		* Конструктор
		*/
		public function StatesUpdateEventHandler($type:String, $params:Vector.<State>, $bubbles:Boolean = false, $cancelable:Boolean = false)
		{
			super($type, $bubbles, $cancelable);
			this.params = $params;
		}

		/**
		* Переопределенный метод clone для клонирования объекта события
		*/
		public override function clone():Event
		{
			return new StatesUpdateEventHandler(type, this.params, bubbles, cancelable);
		}
	}
}
