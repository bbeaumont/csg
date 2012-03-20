/**
 * Created with IntelliJ IDEA.
 * User: Ben
 * Date: 19/03/12
 * Time: 23:06
 * To change this template use File | Settings | File Templates.
 */
package com.dogcatfishdish.csg.wrappers
{
	import away3d.core.base.Geometry;
	import away3d.core.base.SubGeometry;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;

	import com.dogcatfishdish.csg.CSG;
	import com.dogcatfishdish.csg.Polygon;
	import com.dogcatfishdish.csg.Polygon;
	import com.dogcatfishdish.csg.Vertex;

	import flash.geom.Vector3D;

	public class Away3DWrapper
	{
		public function Away3DWrapper()
		{
		}


		public static function toCSG(mesh:Mesh):CSG
		{
			var subGeometry:SubGeometry = mesh.geometry.subGeometries[0];
			var srcIndices:Vector.<uint> = subGeometry.indexData;
			var srcVertices:Vector.<Number> = subGeometry.vertexData;
			var srcNormals:Vector.<Number> = subGeometry.vertexNormalData;

			var polygons:Vector.<Polygon> = new Vector.<Polygon>();
			var vertices:Vector.<Vertex> = new Vector.<Vertex>();

			var px:Number, py:Number, pz:Number;
			var nx:Number, ny:Number, nz:Number;
			for (var i:int = 0, l:int = srcIndices.length, index:int = 0; i < l; ++i)
			{
				if (i%3 == 0)
				{
					polygons.push(new Polygon(vertices));
					vertices = new Vector.<Vertex>();
				}

				index = srcIndices[i]*3;
				px = srcVertices[index];
				py = srcVertices[index + 1];
				pz = srcVertices[index + 2];
				nx = srcNormals[index];
				ny = srcNormals[index + 1];
				nz = srcNormals[index + 2];
				vertices.push(new Vertex(new Vector3D(px, py, pz), new Vector3D(nx, ny, nz)));
			}

			return CSG.fromPolygons(polygons);
		}


		public static function fromCSG(csg:CSG):Geometry
		{

			var subGeometry:SubGeometry = new SubGeometry();
			subGeometry.autoDeriveVertexNormals = true;
			subGeometry.autoDeriveVertexTangents = true;

			var polygons:Vector.<Polygon> = csg.toPolygons();

			var vertices : Vector.<Number> = new Vector.<Number>();
			var indices:Vector.<uint> = new Vector.<uint>();
			var tempVertices:Vector.<Vector3D> = new Vector.<Vector3D>();

			//loop through the polygons
			for (var i:int = 0, len:int = polygons.length; i < len; ++i)
			{
				var polygon:Polygon = polygons[i];

				//loop through the geometry vertices
				for (var j:int = 0, len2:int = polygon.vertices.length; j < len2; ++j)
				{
					var vertex:Vertex = polygon.vertices[j];

					//check to see if the vertex already exists
					if(vertexAlreadyDefined(tempVertices, vertex))
					{

					}
					else
					{
						tempVertices.push(new Vector3D(vertex.position.x, vertex.position.y, vertex.position.z));
						vertices.push(vertex.position.x, vertex.position.y, vertex.position.z);
					}
				}
			}

			subGeometry.updateVertexData(vertices);
			subGeometry.updateIndexData(indices);
			var geometry:Geometry = new Geometry();
			geometry.addSubGeometry(subGeometry);
			return geometry;
		}


		private static function vertexAlreadyDefined(tempVertices:Vector.<Vector3D>, vertex:Vertex):Boolean
		{
			for (var i:int = 0, len:int = tempVertices.length; i < len; ++i)
			{
				var vector3D:Vector3D = tempVertices[i];
				if(vector3D.x == vertex.position.x && vector3D.y == vertex.position.y && vector3D.z == vertex.position.z)
					return true;
			}
			return false;
		}
	}
}
