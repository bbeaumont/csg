/**
 * Created with IntelliJ IDEA.
 * User: Ben
 * Date: 19/03/12
 * Time: 21:26
 * To change this template use File | Settings | File Templates.
 */
package com.dogcatfishdish.csg {
public class CSG {
    public var polygons:Vector.<Polygon> = new Vector.<Polygon>();
    public function CSG() {
    }

    public static function fromPolygons(polygons:Vector.<Polygon>):CSG {
        var csg:CSG = new CSG();
        csg.polygons = polygons;
        return csg;
    }

    public function clone():CSG {
        var csg:CSG = new CSG();
        csg.polygons = this.polygons.map(function(e:Polygon, i:int,  v:Vector.<Polygon>):Polygon{
            return e.clone();
        });
        return csg;
    }

    public function toPolygons():Vector.<Polygon> {
        return this.polygons;
    }

    public function union(csg:CSG):CSG {
        var a:Node = new Node(clone().polygons);
        var b:Node = new Node(csg.clone().polygons);
        a.clipTo(b);
        b.clipTo(a);
        b.invert();
        b.clipTo(a);
        b.invert();
        a.build(b.allPolygons());
        return CSG.fromPolygons(a.allPolygons());
    }

    public function subtract(csg:CSG):CSG {
        var a:Node = new Node(clone().polygons);
        var b:Node = new Node(csg.clone().polygons);
        a.invert();
        a.clipTo(b);
        b.clipTo(a);
        b.invert();
        b.clipTo(a);
        b.invert();
        a.build(b.allPolygons());
        a.invert();
        return CSG.fromPolygons(a.allPolygons());
    }

    public function intersect(csg:CSG):CSG {
        var a:Node = new Node(clone().polygons);
        var b:Node = new Node(csg.clone().polygons);
        a.invert();
        b.clipTo(a);
        b.invert();
        a.clipTo(b);
        b.clipTo(a);
        a.build(b.allPolygons());
        a.invert();
        return CSG.fromPolygons(a.allPolygons());
    }

    public function inverse(csg:CSG):CSG {
        var csg:CSG = clone();
        csg.polygons.map(function(e:Polygon, i:int, v:Vector.<Polygon>):Polygon {
            e.flip();
            return e;
        });
        return csg;
    }
}
}
