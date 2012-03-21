package
{

	import away3d.containers.View3D;
import away3d.core.base.Geometry;
import away3d.entities.Mesh;
import away3d.lights.DirectionalLight;
import away3d.materials.ColorMaterial;
import away3d.materials.lightpickers.LightPickerBase;
import away3d.materials.lightpickers.StaticLightPicker;
import away3d.primitives.CubeGeometry;
	import away3d.primitives.PlaneGeometry;

import com.dogcatfishdish.csg.CSG;

import com.dogcatfishdish.csg.Cube;
import com.dogcatfishdish.csg.Quad;
import com.dogcatfishdish.csg.Triangle;
import com.dogcatfishdish.csg.wrappers.Away3DWrapper;

import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
import flash.geom.Vector3D;
import flash.text.TextField;

	[SWF(width="1024", height="768", frameRate="60")]
	public class CsgTest extends Sprite
	{
		private var _view:View3D = new View3D();

        public function CsgTest()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

            var directionalLight:DirectionalLight = new DirectionalLight();
            var staticLightPicker:StaticLightPicker = new StaticLightPicker([directionalLight]);
            _view.scene.addChild(directionalLight);

            var red:ColorMaterial = new ColorMaterial(0xFF0000);
            red.lightPicker = staticLightPicker;
            red.ambient = 0.8;

            var green:ColorMaterial = new ColorMaterial(0x00FF00);
            green.lightPicker = staticLightPicker;
            green.ambient = 0.8;


            // Create two overlapping quads
            var quad:CSG = new Quad(100, 100, new Vector3D(0, 0, 0));
            var geometry:Geometry = Away3DWrapper.fromCSG(quad);
            var quadMesh1:Mesh = new Mesh(geometry, red);
            quadMesh1.showBounds = true;
            quadMesh1.rotationY = 180;
            _view.scene.addChild(quadMesh1);

            var quad2:CSG = new Quad(100, 100, new Vector3D(50, 50, 0));
            var geometry2:Geometry = Away3DWrapper.fromCSG(quad2);
            var quadMesh2:Mesh = new Mesh(geometry2, red);
            quadMesh2.showBounds = true;
            quadMesh2.rotationY = 180;
            _view.scene.addChild(quadMesh2);

            _view.camera.z = -300;
            addChild(_view);
            addEventListener(Event.ENTER_FRAME, loop);
		}


		private function loop(event:Event):void
		{
			_view.render();
		}
	}
}
