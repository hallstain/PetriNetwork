package  MyPackage {
	import flash.events.MouseEvent;
	public class SceneManager {
		
		
		var tree:Vector.<Node> = new Vector.<Node>();
		var initialScene;

		public function SceneManager(node:Node, scene) {
			
			tree.push(node);
			initialScene = scene;
		}
		public function initilizeScene(){
		
			var curNode:Node = tree[0];
			curNode.Marker.addEventListener(MouseEvent.CLICK, clickHandler(tree));	
			initialScene.visible = true;
	
		}
		function clickHandler(tree:Vector.<Node>):Function {
			return function(e:MouseEvent):void {
			trace("Clicked button: " + e.target.name + " " + tree.length );
			changeScene(e.target,initialScene);
			};
		}
		
		


		public function changeScene(initializer,oldScene){
			
			var newScene = tree[0].NextState;
			
			oldScene.visible = false;
			newScene.visible = true;
			initializer.removeEventListener(MouseEvent.CLICK, clickHandler);
	
		}


	}
	
}
