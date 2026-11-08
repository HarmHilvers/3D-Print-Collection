// Facade game piece in mm: X width, Y height, Z depth.
// Place Z=0 flat on the build plate; all recessed details are 1.5 mm deep.
$fn=64;
module rect(x,y,w,h){translate([x,y]) square([w,h]);}
module disk(x,y,r){translate([x,y]) circle(r=r);}
module line(a,b,w=1.5){hull(){translate(a) circle(d=w);translate(b) circle(d=w);}}
module path(points,w=1.5){for(i=[0:len(points)-2]) line(points[i],points[i+1],w);}
module cross_icon(x,y,size=6,bar=1.8){union(){rect(x-size/2,y-bar/2,size,bar);rect(x-bar/2,y-size/2,bar,size);}}
module tank(x,y,w,h){union(){rect(x,y,w,h-w/2);disk(x+w/2,y+h-w/2,w/2);}}
module ring(x,y,r,w=1.3){difference(){disk(x,y,r);disk(x,y,r-w);}}

module silhouette(){
union(){rect(0,0,20,26);rect(7,26,6,5);rect(6,31,8,2);}
}
module facade_recesses(){union(){
// A solid syringe outline remains clear at small print sizes.
path([[7,15],[12,20]],3);
line([5.5,14.5],[7.5,12.5],1.4);
line([6.5,13.5],[8,15],1.4);
line([10.8,21.2],[13.2,18.8],1.4);
line([12,20],[15,23],1.4);
rect(2,0,5,6);rect(13,0,5,6);
rect(2,9,3,3.5);rect(2,16,3,3.5);
rect(8.5,27,3,2);
}}
difference(){
 linear_extrude(height=15) silhouette();
 translate([0,0,13.5]) linear_extrude(height=2) facade_recesses();
}
