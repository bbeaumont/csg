/**
 * Created with IntelliJ IDEA.
 * User: Ben
 * Date: 19/03/12
 * Time: 21:30
 * To change this template use File | Settings | File Templates.
 */
package com.dogcatfishdish.csg {
import flash.geom.Vector3D;

public class Plane {
    public static const EPSILON:Number = 1e-5;
    public static const COPLANAR:int = 0;
    public static const FRONT:int = 1;
    public static const BACK:int = 2;
    public static const SPANNING:int = 3;

    private var w:Number;
    private var normal:Vector3D;

    public function Plane(normal:Vector3D, w:Number) {
        this.normal = normal;
        this.w = w;
    }

    public static function fromPoints(a:Vector3D, b:Vector3D, c:Vector3D):Plane {
        var n:Vector3D = b.subtract(a).crossProduct(c.subtract(a));
        n.normalize();
        return new Plane(n, n.dotProduct(a));
    }

    public function clone():Plane {
        return new Plane(normal.clone(), w);
    }

    public function flip():void {
        normal.negate();
        w = -w;
    }

    public function splitPolygon(polygon:Polygon, coplanarFront:Vector.<Polygon>, coplanarBack:Vector.<Polygon>, front:Vector.<Polygon>, back:Vector.<Polygon>):void {
        var polygonType:int = 0;
        var types:Vector.<int> = new Vector.<int>();
        for (var i:int = 0; i < polygon.vertices.length; i++) {
            var vertex:Vertex = polygon.vertices[i];
            var t:Number = normal.dotProduct(vertex.position) - w;
            var type:int = (t < -Plane.EPSILON) ? BACK : (t > Plane.EPSILON) ? FRONT : COPLANAR;
            polygonType |= type;
            types.push(type);
        }

        switch (polygonType) {
            case COPLANAR:
                (this.normal.dotProduct(polygon.plane.normal) > 0 ? coplanarFront : coplanarBack).push(polygon);
                break;
            case FRONT:
                front.push(polygon);
                break;
            case BACK:
                back.push(polygon);
                break;
            case SPANNING:
                var f:Vector.<Vertex> = new Vector.<Vertex>();
                var b:Vector.<Vertex> = new Vector.<Vertex>();
                for (var i = 0; i < polygon.vertices.length; i++) {
                    var j = (i + 1) % polygon.vertices.length;
                    var ti = types[i], tj = types[j];
                    var vi = polygon.vertices[i], vj = polygon.vertices[j];
                    if (ti != BACK) f.push(vi);
                    if (ti != FRONT) b.push(ti != BACK ? vi.clone() : vi);
                    if ((ti | tj) == SPANNING) {
                        var t = (this.w - this.normal.dotProduct(vi.pos)) / this.normal.dotProduct(vj.pos.minus(vi.pos));
                        var v = vi.interpolate(vj, t);
                        f.push(v);
                        b.push(v.clone());
                    }
                }
                if (f.length >= 3)
                    front.push(new Polygon(f, polygon.shared));
                if (b.length >= 3)
                    back.push(new Polygon(b, polygon.shared));
                break;
        }
    }
}
}
