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

module silhouette(){polygon([[0,0],[19,0],[19,24],[16.5,24],[16.5,28],[12,28],[12,32],[7,32],[7,28],[2.5,28],[2.5,24],[0,24]]);}
module details(){
 rect(7.3,1.4,4.4,5.3);
 for(x=[2.2,7.6,13.0],y=[8.4,12.0]) rect(x,y,3.8,2.4);
 framed(6.5,18.2,6,6,1.3);
 for(x=[6.5,8.9,11.3]){rect(x,15.6,1.2,1.4);rect(x,25.4,1.2,1.4);}
 for(y=[18.2,20.6,23.0]){rect(3.9,y,1.4,1.2);rect(13.7,y,1.4,1.2);}
}
