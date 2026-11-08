// Building facade miniature for board games.
// Millimetres. X=width, Y=height, Z=depth.
// Print flat at Z=0; straight base at Y=0; front at Z=15.
// All recesses are blind and 1.5 mm deep. This is a solid piece.
$fn=96;
depth=15;
recess=1.5;
module rect(x,y,w,h) { translate([x,y]) square([w,h]); }
module disc(x,y,r) { translate([x,y]) circle(r=r); }
module line(a,b,w=1.4) {
    hull() { translate(a) circle(d=w); translate(b) circle(d=w); }
}
module frame(x,y,w,h,t=1.4) {
    difference() { rect(x,y,w,h); rect(x+t,y+t,w-2*t,h-2*t); }
}
module gear(x,y,r=6,inner=2.4) {
    translate([x,y]) difference() {
        polygon([for(i=[0:(r<4?15:23)]) let(n=(r<4?16:24),a=(i+1)*360/n,rr=(i%4<2?r:r-min(1.5,r*0.21))) [rr*cos(a),rr*sin(a)]]);
        circle(r=inner);
    }
}
module car(x,y,w=14,h=5) {
    translate([x,y]) union() {
        polygon([[0,0.8],[0,h*0.48],[w*0.2,h*0.48],
                 [w*0.35,h],[w*0.67,h],[w*0.82,h*0.48],
                 [w,h*0.35],[w,0.8]]);
        disc(w*0.23,0.8,1.3); disc(w*0.77,0.8,1.3);
    }
}
module recycling(x,y,r=6) {
    translate([x,y]) for(a=[0,120,240]) rotate(a) {
        line([-3.8,3.2],[1.2,3.2],1.6);
        polygon([[1.2,1.7],[4.2,3.2],[1.2,4.7]]);
    }
}
module cutface() { translate([0,0,depth-recess]) linear_extrude(height=recess+0.5) facade(); }
// All details are recessed into the same solid facade.
difference() {
    linear_extrude(height=depth) outline();
    cutface();
}


module outline() {
    polygon([[0,0],[19,0],[19,27],[13,27],[13,30],[7,30],[7,34],[0,34]]);
}
module facade() {
    rect(3,2,13,4);
    rect(6,9,7,3);
    line([9.5,12],[5,19],2.4); disc(5,19,2.2);
    line([5,19],[12.5,23.5],2.4); disc(12.5,23.5,2.2);
    line([12.5,23.5],[16,19],2.0);
    line([16,19],[13.5,16.5],1.6);
    line([16,19],[17,15.8],1.6);
    rect(1.5,28,3.5,3);
}
