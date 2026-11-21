// Building miniatures — Tech, AI & Digital
// Units: millimetres. X = width; Y = facade height; Z = depth.
// Print flat on the back at Z=0. Front Z=15; recesses are 1.5 mm deep.
$fn=96;
depth=15;
recess=1.5;
module rect(x,y,w,h) { translate([x,y]) square([w,h]); }
module disc(x,y,r) { translate([x,y]) circle(r=r); }
module rr(x,y,w,h,r=1) { hull() for(a=[x+r,x+w-r],b=[y+r,y+h-r]) disc(a,b,r); }
module stroke(a,b,w=1.4) { hull() {disc(a[0],a[1],w/2);disc(b[0],b[1],w/2);} }
module ring(x,y,r,w=1.4) { difference(){disc(x,y,r);disc(x,y,r-w);} }
module framed(x,y,w,h,t=1.4) { difference(){rect(x,y,w,h);rect(x+t,y+t,w-2*t,h-2*t);} }
module arrow(a,b,w=1.5) { v=b-a; u=v/norm(v); n=[-u[1],u[0]]; tip=b; neck=b-u*2.8; stroke(a,neck,w); polygon([tip,neck+n*1.9,neck-n*1.9]); }
module building(){difference(){linear_extrude(height=depth) silhouette();translate([0,0,depth-recess]) linear_extrude(height=recess+0.2) details();}}
building();

module silhouette(){union(){rect(0,0,19,22);for(x=[3.2,9.5,15.8]){rect(x-3.2,20,6.4,3.8);disc(x,23.8,3.2);}}}
module details(){
 for(x=[1.4,7.3,13.2]) rect(x,1.4,4.4,7);
 rect(1.4,12,4.4,3);rect(13.2,12,4.4,3);
 ring(9.5,18,3.0,1.3);
 stroke([7.3,11.9],[8.7,10.6],1.2);stroke([8.7,10.6],[11.4,13.1],1.2);
}
