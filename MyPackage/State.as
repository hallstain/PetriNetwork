package  MyPackage{
	
	public class State {

		var markersCount: Number;
		var id: Number;
		
		public function get id():Number {
			return id;
		}
		
		public function State(id, markersCount) {
			this.id = id;
			this.markersCount = markersCount;
		}
		public function hasMarkers():Boolean {
			return markersCount > 0;
		}
		public function getMarkers():Number {
			return markersCount;
		}
		public function decMarkers():void {
			this.markersCount--;
		}
		public function incMarkers():void {
			this.markersCount++;
		}

	}
	
}
