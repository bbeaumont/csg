/**
 * Created with IntelliJ IDEA.
 * User: Ben
 * Date: 19/03/12
 * Time: 21:41
 * To change this template use File | Settings | File Templates.
 */
package com.dogcatfishdish.csg {
import flash.geom.Vector3D;

public class Vertex {
    private var _normal:Vector3D;
    private var _position:Vector3D;
    public function Vertex(position:Vector3D, normal:Vector3D) {
        this._position = position;
        this._normal = normal;
    }

    public function clone():Vertex {
        return new Vertex(position.clone(), normal.clone());
    }

    public function flip():void {
        this.normal.scaleBy(-1);
    }

    public function interpolate(other:Vertex, t:Number):Vertex {
        var pos:Vector3D = this.position.clone();
        var nor:Vector3D = this.normal.clone();
        pos.incrementBy(other.position.subtract(pos));
        pos.scaleBy(t);
        nor.incrementBy(other.normal.subtract(nor));
        nor.scaleBy(t);
        return new Vertex(pos, nor);
    }

    public function get position():Vector3D {
        return _position;
    }

    public function set position(value:Vector3D):void {
        _position = value;
    }

    public function get normal():Vector3D {
        return _normal;
    }

    public function set normal(value:Vector3D):void {
        _normal = value;
    }
}
}
