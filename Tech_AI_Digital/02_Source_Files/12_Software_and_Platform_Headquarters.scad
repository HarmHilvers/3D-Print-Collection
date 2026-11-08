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

module silhouette(){polygon([[0,0],[19,0],[19,23],[15,23],[15,36],[13,36],[13,38],[11,38],[11,40],[8,40],[8,38],[6,38],[6,36],[4,36],[4,23],[0,23]]);}
module details(){
 rect(5.4,1.4,8.2,5.4);
 for(x=[5.5,8.9,12.3],y=[9,13.8,18.6,23.4]) rect(x,y,2.2,3.0);
 for(x=[6.0,10.4],y=[27.8,32.2]) rr(x,y,2.6,2.6,0.6);
 rect(1.4,10,1.2,9);rect(16.4,10,1.2,9);
}
