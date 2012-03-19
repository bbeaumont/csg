/**
 * Created with IntelliJ IDEA.
 * User: Ben
 * Date: 19/03/12
 * Time: 23:06
 * To change this template use File | Settings | File Templates.
 */
package com.dogcatfishdish.csg.wrappers {
import away3d.core.base.Geometry;
import away3d.entities.Mesh;

import com.dogcatfishdish.csg.CSG;

import com.dogcatfishdish.csg.Polygon;
import com.dogcatfishdish.csg.Vertex;

import flash.geom.Vector3D;

public class Away3DWrapper {
    public function Away3DWrapper() {
    }

    public function toCSG(mesh:Mesh, offset:Vector3D = null, rotation:Vector3D = null):CSG {

        var geometry:Geometry = mesh.geometry;
        offset = offset || new Vector3D();
        rotation = rotation || new Vector3D();
        var polygons:Vector.<Polygon> = new Vector.<Polygon>();

        var srcIndices : Vector.<uint> = geometry.subGeometries[0].indexData;
        var srcVertices : Vector.<Number> = geometry.subGeometries[0].vertexData;
        var srcNormals:Vector.<Number> = geometry.subGeometries[0].vertexNormalData;

        var len : int = srcIndices.length;
        var index : int;
        var x : Number, y : Number, z : Number;
        var a:Number, b:Number, c:Number;
        var vertices:Vector.<Vertex> = new Vector.<Vertex>();
        for (var i : int = 0; i < len; ++i) {
            if(i % 3 == 0)
            {
                polygons.push(new Polygon(vertices));
                vertices = new Vector.<Vertex>();
            }

            index = srcIndices[i]*3;
            x = srcVertices[index];
            y = srcVertices[index+1];
            z = srcVertices[index+2];
            a = srcNormals[index];
            b = srcNormals[index+1];
            c = srcNormals[index+2];
            vertices.push(new Vertex(new Vector3D(x, y, z), new Vector3D(a, b, c)));
        }

        return CSG.fromPolygons(polygons);
    }

    public function fromCSG():Mesh {
        return null;
    }

    public function getGeometryVertex():void {

    }
}
}
