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
polygon([[0,0],[20,0],[20,29],[0,23]]);
}
module facade_recesses(){union(){
line([3,5],[14,11],1.5);
line([6,5],[6,6.6],1.3);line([11,5],[11,9.4],1.3);
rect(15,0,4,7);
ring(7,15,2.5,1.3);
disk(8,21,0.9);
path([[8,19],[8,16.5],[11,16.5],[12.7,13.5],[14,13.5]],1.3);
rect(2,21.5,3.6,1.6);rect(13.5,22,4.5,2.6);
}}
difference(){
 linear_extrude(height=15) silhouette();
 translate([0,0,13.5]) linear_extrude(height=2) facade_recesses();
}
