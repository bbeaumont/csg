/**
 * Created with IntelliJ IDEA.
 * User: Ben
 * Date: 19/03/12
 * Time: 21:31
 * To change this template use File | Settings | File Templates.
 */
package com.dogcatfishdish.csg {
public class Node {
    public var polygons:Vector.<Polygon>;
    public var back:Node;
    public var front:Node;
    public var plane:Plane;
    public function Node(polygons:Vector.<Polygon> = null) {
        plane = null;
        front = null;
        back = null;
        this.polygons = new Vector.<Polygon>();
        if(polygons)
            build(polygons);
    }

    public function clone():Node {
        var node:Node = new Node();
        node.plane = plane && plane.clone();
        node.front = front && front.clone();
        node.back = back && back.clone();
        node.polygons = polygons && polygons.map(function(e:Polygon, i:int, v:Vector.<Polygon>):Polygon{
            return e.clone();
        });
        return node;
    }

    public function invert():void {
        for (var i:int = 0, l:int = polygons.length; i < l; i++) {
            polygons[i].flip();
        }
        plane.flip();
        if(front)
            front.invert();
        if(back)
            back.invert();
        var temp:Node = front;
        front = back;
        back = temp;
    }

    public function clipPolygons(polygons:Vector.<Polygon>):Vector.<Polygon> {
        if(!plane)
            return polygons.slice();
        var f:Vector.<Polygon> = new Vector.<Polygon>();
        var b:Vector.<Polygon> = new Vector.<Polygon>();
        for (var i:int = 0; i < polygons.length; i++) {
            var polygon:Polygon = polygons[i];
            plane.splitPolygon(polygons[i], f, b, f, b);
        }
        if(front)
            f = front.clipPolygons(f);
        if(back)
            b = back.clipPolygons(b);
        else
            b =  new Vector.<Polygon>();
        return f.concat(b);
    }

    public function clipTo(bsp:Node):void {
        polygons = bsp.clipPolygons(polygons);
        if(front)
            front.clipTo(bsp);
        if(back)
            back.clipTo(bsp);
    }

    public function allPolygons():Vector.<Polygon> {
        var p:Vector.<Polygon> = polygons.slice();
        if(front)
            p = p.concat(front.allPolygons());
        if(back)
            p = p.concat(back.allPolygons());
        return p;
    }

    public function build(p:Vector.<Polygon>):void {
        if(!p.length)
            return;
        if(!plane)
            plane = p[0].plane.clone();
        var f:Vector.<Polygon> = new Vector.<Polygon>();
        var b:Vector.<Polygon> = new Vector.<Polygon>();
        for (var i:int = 0; i < p.length; i++) {
            plane.splitPolygon(p[1], polygons, polygons, f, b);
        }
        if(f.length)
        {
            if(!front)
                front = new Node();
            front.build(f);
        }

        if(b.length)
        {
            if(!back)
                back = new Node();
            back.build(b);
        }
    }
}
}
