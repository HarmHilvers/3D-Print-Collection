from pathlib import Path
import json

ROOT = Path(__file__).resolve().parent
COMMON = '''// Building facade miniature for board games.
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
'''

MODELS = [
('01_Vehicle_Assembly_Plant', 'Vehicle_Assembly_Plant',20,36,
 'Three sawtooth roofs, a large car symbol, two loading doors and a row of tall windows.', '''
module outline() {
    polygon([[0,0],[20,0],[20,26],[13.333,36],[13.333,26],[6.667,36],[6.667,26],[0,36]]);
}
module facade() {
    rect(2,2,6,7); rect(12,2,6,7);
    car(3,12,14,5.8);
    for(x=[2,8,14]) rect(x,20,3.8,4.5);
}
'''),
('02_Battery_Cell_Factory','Battery_Cell_Factory',19,38,
 'Hall with a battery-shaped crown, a large battery symbol and three wide production panels.', '''
module outline() {
    union() {
        rect(0,0,19,28); rect(5.5,26,8,10); rect(8,34,3,4);
    }
}
module facade() {
    frame(3.5,11,12,15); rect(8,26,3,2);
    line([9.5,16],[9.5,21],1.5); line([7,18.5],[12,18.5],1.5);
    for(x=[2,7.1,12.2]) rect(x,2,3.6,6);
    rect(7,30,5,3);
}
'''),
('03_Battery_Materials_Refinery','Battery Materials Refinery',19,42,
 'Three connected silo towers with rounded tank tops, wide bands and a pipeline.', '''
module outline() {
    union() {
        rect(0,0,19,20);
        rect(0,18,5,16.5); disc(2.5,34.5,2.5);
        rect(7,18,5,21.5); disc(9.5,39.5,2.5);
        rect(14,18,5,16.5); disc(16.5,34.5,2.5);
    }
}
module facade() {
    for(x=[1.2,8.2,15.2]) {
        rect(x,24,2.6,1.4); rect(x,29,2.6,1.4);
    }
    line([3,13],[16,13],1.8);
    line([3,13],[3,18],1.8); line([16,13],[16,18],1.8);
    rect(2,2,6,7); rect(11,2,6,7);
    rect(8.2,34.5,2.6,1.4);
}
'''),
('04_Steel_and_Aluminum_Foundry','Steel and Aluminum Foundry',20,40,
 'Furnace hall with two chimneys, a wide furnace opening and a casting ladle on the facade.', '''
module outline() {
    union() { rect(0,0,20,25); rect(1,23,5,17); rect(14,23,5,12); }
}
module facade() {
    rect(3,2,14,8);
    polygon([[4,19],[10,19],[9,13],[5,13]]);
    line([10,18],[16,22],1.8);
    rect(2.2,30,2.6,1.4); rect(2.2,35,2.6,1.4);
    rect(15.2,29,2.6,1.4);
}
'''),
('05_Precision_Components_Factory','Precision_Components_Factory',19,30,
 'Compact hall with a toothed roof crown, large gear and three machine panels.', '''
module outline() {
    union() {
        rect(0,0,19,24);
        translate([9.5,24]) polygon([for(i=[0:23]) let(a=(i+1)*360/24,rr=(i%4<2?6:4.5)) [rr*cos(a),rr*sin(a)]]);
    }
}
module facade() {
    gear(9.5,16,6,2.6);
    for(x=[2,7.1,12.2]) rect(x,2,3.6,5);
    disc(9.5,26.8,1.25);
}
'''),
('06_Industrial_Robot_Factory','Industrial Robot Factory',19,34,
 'Asymmetrical hall with a large robot arm, three joints and a wide gripper.', '''
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
'''),
('07_Automotive_Design_Center','Automotive Design Center',20,32,
 'Office facade with a sloping roof, vehicle outline, wide window and central entrance.', '''
module outline() { polygon([[0,0],[20,0],[20,25],[0,32]]); }
module facade() {
    rect(7,2,6,7);
    rect(2,12,16,3.5);
    line([3,20],[17,20],1.6);
    line([3,20],[6,24],1.6); line([6,24],[12,24],1.6);
    line([12,24],[16,20],1.6);
    rect(2,3,2.4,5); rect(15.6,3,2.4,5);
}
'''),
('08_Vehicle_Testing_and_Certification_Center','Vehicle Testing and Certification Center',19,28,
 'Low testing hall with a raised gate, large check mark and two checkerboard panels.', '''
module outline() {
    union() { rect(0,0,19,22); rect(5.5,20,8,8); }
}
module facade() {
    rect(6,2,7,8);
    line([6.2,18],[8.7,15],1.8); line([8.7,15],[12.5,21],1.8);
    for(x=[1.2,14.2]) {
        rect(x,4,1.2,1.8); rect(x+2.4,7.2,1.2,1.8);
        rect(x,10.4,1.2,1.8);
    }
    rect(8,24,3,1.5);
}
'''),
('09_Hydrogen_and_Fuel_Cell_Factory','Hydrogen and Fuel Cell Factory',19,40,
 'Two rounded tank towers with horizontal bands, a connecting pipe and a large H2 symbol.', '''
module outline() {
    union() {
        rect(0,0,19,19);
        rect(0,17,7,19.5); disc(3.5,36.5,3.5);
        rect(12,17,7,19.5); disc(15.5,36.5,3.5);
    }
}
module facade() {
    for(x=[1.4,13.4]) { rect(x,24,4.2,1.5); rect(x,30,4.2,1.5); }
    line([5,9],[5,16],1.5); line([9,9],[9,16],1.5); line([5,12.5],[9,12.5],1.5);
    line([12,14],[15,14],1.6); line([15,14],[15,12],1.6);
    line([15,12],[12,9],1.6); line([12,9],[15,9],1.6);
    rect(3,2,13,3.5);
}
'''),
('10_Battery_Recycling_Plant','Battery_Recycling_Plant',19,34,
 'Stepped hall with two roof fans, recycling arrows and a battery symbol.', '''
module outline() {
    union() { rect(0,0,19,26); rect(2,24,5,10); rect(12,24,5,10); }
}
module facade() {
    translate([9.5,18]) for(a=[0,120,240]) rotate(a) {
        line([-4.4,4.5],[1.5,4.5],1.5);
        polygon([[1.5,3],[4.5,4.5],[1.5,6]]);
    }
    rect(7.5,14.8,4,4.5); rect(8.7,19.3,1.6,1.2);
    rect(2,2,6,5); rect(11,2,6,5);
    rect(3.2,28,2.6,3); rect(13.2,28,2.6,3);
}
'''),
('11_Industrial_Logistics_Center','Industrial Logistics Center',20,30,
 'Gabled warehouse with a container relief, three loading doors and railway lines.', '''
module outline() { polygon([[0,0],[20,0],[20,25],[10,30],[0,25]]); }
module facade() {
    line([2,2],[18,2],1.2); line([2,5],[18,5],1.2);
    for(x=[2,8,14]) rect(x,8,4,6);
    frame(2,18,16,6,1.4);
    for(x=[6,9.5,13]) rect(x,19.4,1.3,3.2);
}
'''),
('12_Technical_Training_Center','Technical Training Center',19,35,
 'Symmetrical school with a roof crown, open book, gear and classroom windows.', '''
module outline() { polygon([[0,0],[19,0],[19,28],[14,28],[9.5,35],[5,28],[0,28]]); }
module facade() {
    rect(7,2,5,7);
    for(x=[2,13]) rect(x,3,4,5);
    for(x=[2,13]) rect(x,11,4,4);
    polygon([[3,19],[8.1,18],[8.1,23],[3,24]]);
    polygon([[10.9,18],[16,19],[16,24],[10.9,23]]);
    gear(9.5,26.8,3.3,1.3);
}
'''),
]

def main():
    entries=[]
    for stem,name,width,height,description,body in MODELS:
        (ROOT/(stem+'.scad')).write_text(COMMON+'\n'+body,encoding='utf-8')
        entries.append(dict(name=stem[3:].replace("_"," "),filename='../01_Print_Models/STL/'+stem+'.stl',source=stem+'.scad',
                            width=width,height=height,depth=15,description=description))
    (ROOT/'manifest.json').write_text(json.dumps({'sector':'Automotive & smart manufacturing','units':'mm','models':entries},ensure_ascii=False,indent=2)+'\n',encoding='utf-8')

if __name__=='__main__': main()
