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
union(){rect(0,0,20,28);polygon([[7,28],[13,28],[12,33],[8,33]]);disk(10,35,3);}
}
module facade_recesses(){union(){
ring(10,20,2.3,1.3);
for(a=[0:45:315]) line([10+2*cos(a),20+2*sin(a)],[10+4*cos(a),20+4*sin(a)],1.3);
for(x=[2,15]) for(y=[11,20]) rect(x,y,3,3.5);
rect(8,0,4,6);
line([8.3,35],[11.7,35],1.3);
}}
difference(){
 linear_extrude(height=15) silhouette();
 translate([0,0,13.5]) linear_extrude(height=2) facade_recesses();
}
