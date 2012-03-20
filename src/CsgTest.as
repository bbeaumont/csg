package
{

	import away3d.containers.View3D;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PlaneGeometry;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.TextField;

	[SWF(width="1024", height="768", frameRate="60")]
	public class CsgTest extends Sprite
	{
		private var _view:View3D = new View3D();


		private var _plane:Mesh = new Mesh(new PlaneGeometry(), new ColorMaterial(0xFF0000));


		public function CsgTest()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			var textField:TextField = new TextField();
			textField.text = "Hello, World";
			addChild(textField);

			var cube:Mesh = new Mesh(new CubeGeometry(), new ColorMaterial(0xFF0000));
			_view.scene.addChild(cube);

			_view.camera.z = -300;
			this.addChild(_view);
			_view.scene.addChild(_plane);
			addEventListener(Event.ENTER_FRAME, enterFrameHandler)
		}


		private function enterFrameHandler(event:Event):void
		{
			_plane.rotationY += 0.5;
			_view.render();
		}
	}
}
