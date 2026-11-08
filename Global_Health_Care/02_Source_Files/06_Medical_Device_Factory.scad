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
union(){rect(0,0,20,25);rect(7,25,13,3);rect(14,28,6,4);}
}
module facade_recesses(){union(){
difference(){rect(4,14,12,9);path([[3.8,18],[7,18],[8.5,20.5],[10,16.5],[11.5,19],[13,18],[16.2,18]],1.3);}
rect(5,0,10,7);
rect(1.5,25-5,1.2,3);rect(8.8,25,2.5,1.5);rect(15.8,28.5,2.4,1.6);
rect(2,10,4,1.5);rect(14,10,4,1.5);
}}
difference(){
 linear_extrude(height=15) silhouette();
 translate([0,0,13.5]) linear_extrude(height=2) facade_recesses();
}
