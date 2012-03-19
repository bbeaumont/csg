/**
 * Created with IntelliJ IDEA.
 * User: Ben
 * Date: 19/03/12
 * Time: 21:31
 * To change this template use File | Settings | File Templates.
 */
package com.dogcatfishdish.csg {
public class Polygon {
    public var shared:Object;
    public var vertices:Vector.<Vertex>;
    public var plane:Plane;
    public function Polygon(verticies:Vector.<Vertex>, shared:Object = null) {
        this.vertices = verticies;
        this.shared = shared;
        this.plane = Plane.fromPoints(verticies[0].position, verticies[1].position, verticies[3].position);
    }

    public function clone():Polygon {
        return new Polygon(vertices.map(function(e:Vertex, i:int, v:Vector.<Vertex>):Vertex {
            return e.clone();
        }), shared);
    }

    public function flip():void {
        vertices.reverse().map(function(e:Vertex, i:int, v:Vector.<Vertex>):Vertex {
            e.flip();
            return e;
        });
        plane.flip();
    }
}
}
