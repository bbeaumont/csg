/**
 * Created with IntelliJ IDEA.
 * User: Ben
 * Date: 19/03/12
 * Time: 21:29
 * To change this template use File | Settings | File Templates.
 */
package com.dogcatfishdish.csg {
import flash.geom.Vector3D;

public class Cube extends CSG {

    public function Cube(width:Number, height:Number, depth:Number, center:Vector3D) {

        var data:Array = [
                        [[0, 4, 6, 2], [-1, 0, 0]],
                        [[1, 3, 7, 5], [+1, 0, 0]],
                        [[0, 1, 5, 4], [0, -1, 0]],
                        [[2, 6, 7, 3], [0, +1, 0]],
                        [[0, 2, 3, 1], [0, 0, -1]],
                        [[4, 5, 7, 6], [0, 0, +1]]];

        var polys:Vector.<Polygon> = new Vector.<Polygon>();

        for each (var array:Array in data) {

            var positions:Array = array[0];
            var normals:Array = array[1];
            var normal:Vector3D = new Vector3D(normals[0], normals[1], normals[2]);
            var verticies:Vector.<Vertex> = new Vector.<Vertex>();

            for (var i:int = 0; i < positions.length; i++) {
                var pos:int = positions[i];
                var pos2:Vector3D = new Vector3D(
                    center.x + width * (2 * (pos & 1) - 1),
                    center.y + height * (2 * (pos & 2) - 1),
                    center.z + depth * (2 * (pos & 4) - 1)
                );
                verticies.push(new Vertex(pos2, normal));
            }
            var poly:Polygon = new Polygon(verticies);
        }

        super(polys);
    }
}
}
