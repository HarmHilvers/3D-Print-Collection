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
polygon([[0,0],[20,0],[20,27],[10,35],[0,27]]);
}
module facade_recesses(){union(){
// Separate pages leave a strong central fold.
polygon([[3.5,18.5],[3.5,25],[9.3,23.5],[9.3,17]]);
polygon([[10.7,17],[10.7,23.5],[16.5,25],[16.5,18.5]]);
cross_icon(10,29,4,1.3);
for(x=[2,8,14]) for(y=[8,12.5]) rect(x,y,4,2.5);
rect(8,0,4,5.5);
}}
difference(){
 linear_extrude(height=15) silhouette();
 translate([0,0,13.5]) linear_extrude(height=2) facade_recesses();
}
