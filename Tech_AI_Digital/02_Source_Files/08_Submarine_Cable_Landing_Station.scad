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

module silhouette(){polygon([[0,0],[19,0],[19,22],[9.5,26],[0,22]]);}
module details(){
 rect(6.8,6.8,5.4,5.2);
 for(x=[5.1,13.9]) ring(x,17.8,3.2,1.2);
 stroke([5.1,17.8],[13.9,17.8],1.2);
 for(y=[1.8,4.4]){stroke([1.6,y],[5.2,y+0.5],1.2);stroke([5.2,y+0.5],[9.5,y],1.2);stroke([9.5,y],[13.8,y+0.5],1.2);stroke([13.8,y+0.5],[17.4,y],1.2);}
}
