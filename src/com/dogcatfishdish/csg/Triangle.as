/**
 * Created with IntelliJ IDEA.
 * User: Ben
 * Date: 21/03/12
 * Time: 21:30
 * To change this template use File | Settings | File Templates.
 */
package com.dogcatfishdish.csg {
import flash.geom.Vector3D;

public class Triangle extends CSG {
    public function Triangle() {

        var verticies:Vector.<Vertex> = new Vector.<Vertex>();
        var vertex1:Vertex = new Vertex(new Vector3D(0, 0, 0), new Vector3D(0, 1, 0));
        var vertex2:Vertex = new Vertex(new Vector3D(100, 0, 0), new Vector3D(0, 1, 0));
        var vertex3:Vertex = new Vertex(new Vector3D(0, 100, 0), new Vector3D(0, 1, 0));
//        var vertex4:Vertex = new Vertex(new Vector3D(0, 100, 0), new Vector3D(0, 1, 0));
//        var vertex5:Vertex = new Vertex(new Vector3D(0, 100, 0), new Vector3D(0, 1, 0));
//        var vertex6:Vertex = new Vertex(new Vector3D(0, 100, 0), new Vector3D(0, 1, 0));
        verticies.push(vertex1, vertex2, vertex3);
        var polygon:Polygon = new Polygon(verticies);
        var polys:Vector.<Polygon> = new Vector.<Polygon>();
        polys.push(polygon);
        super(polys);
    }
}
}
