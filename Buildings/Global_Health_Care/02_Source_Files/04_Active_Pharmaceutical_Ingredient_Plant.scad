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
union(){rect(0,0,20,23);tank(1,23,5,8);tank(7.5,23,5,12);tank(14,23,5,6);}
}
module facade_recesses(){union(){
disk(6,17,1.5);disk(10,20,1.5);disk(14,16,1.5);
line([6,17],[10,20],1.4);line([10,20],[14,16],1.4);
rect(2,0,6,7);rect(11,0,6,7);
for(x=[2,15]) rect(x,10,3,3);
line([3.5,25],[3.5,28],1.3);line([10,25],[10,32],1.3);line([16.5,25],[16.5,27],1.3);
}}
difference(){
 linear_extrude(height=15) silhouette();
 translate([0,0,13.5]) linear_extrude(height=2) facade_recesses();
}
