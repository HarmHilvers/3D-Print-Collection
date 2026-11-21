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

module silhouette(){polygon([[0,0],[19,0],[19,23],[14.5,23],[14.5,30],[9.5,34],[4.5,30],[4.5,23],[0,23]]);}
module details(){
 rect(6.8,1.4,5.4,6);
 for(x=[2.0,7.7,13.4]) rect(x,10,3.6,7);
 difference(){polygon([[5.9,28.2],[9.5,30.6],[13.1,28.2],[12.3,23.9],[9.5,21.8],[6.7,23.9]]);polygon([[7.3,27.5],[9.5,29.0],[11.7,27.5],[11.1,24.7],[9.5,23.5],[7.9,24.7]]);}
 disc(9.5,26.8,0.9);rect(8.8,24.8,1.4,2.0);
}
