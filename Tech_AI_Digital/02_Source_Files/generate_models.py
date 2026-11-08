from pathlib import Path
import json
D=Path(__file__).parent
COMMON='''// Building miniatures — Tech, AI & Digital
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
'''
MODELS=[
('AI_Research_Center',19,35,'Domed facade with three connected network nodes and horizontal windows.', '''module silhouette(){union(){rect(0,0,19,28.5);rect(4.5,27,10,3);disc(9.5,30,5);}}
module details(){
 rect(7.3,1.4,4.4,5.8);
 for(y=[9,14,19]) rect(2.2,y,14.6,2.4);
 stroke([6.4,28],[12.6,28]);stroke([6.4,28],[9.5,32]);stroke([12.6,28],[9.5,32]);
 for(p=[[6.4,28],[12.6,28],[9.5,32]]) disc(p[0],p[1],1.0);
}'''),
('Chip_Design_Center',19,32,'Stepped office with a large chip symbol and six large windows.', '''module silhouette(){polygon([[0,0],[19,0],[19,24],[16.5,24],[16.5,28],[12,28],[12,32],[7,32],[7,28],[2.5,28],[2.5,24],[0,24]]);}
module details(){
 rect(7.3,1.4,4.4,5.3);
 for(x=[2.2,7.6,13.0],y=[8.4,12.0]) rect(x,y,3.8,2.4);
 framed(6.5,18.2,6,6,1.3);
 for(x=[6.5,8.9,11.3]){rect(x,15.6,1.2,1.4);rect(x,25.4,1.2,1.4);}
 for(y=[18.2,20.6,23.0]){rect(3.9,y,1.4,1.2);rect(13.7,y,1.4,1.2);}
}'''),
('Semiconductor_Fabrication_Plant',20,29,'Three sawtooth roofs, a filter tower, two grilles and three loading doors.', '''module silhouette(){union(){polygon([[0,0],[20,0],[20,21],[15,25],[15,21],[10,25],[10,21],[5,25],[5,21],[0,21]]);rect(0,19,4,10);}}
module details(){
 for(x=[1.5,7.6,13.7]) rect(x,1.5,4.8,5.6);
 for(x=[4.2,11.7]) for(y=[10,13.0,16.0]) rect(x,y,4.8,1.5);
 rect(1.3,22,1.4,4.5);
}'''),
('Chip_Packaging_and_Testing_Plant',19,27,'Three rounded testing halls with a circular check mark on the central hall.', '''module silhouette(){union(){rect(0,0,19,22);for(x=[3.2,9.5,15.8]){rect(x-3.2,20,6.4,3.8);disc(x,23.8,3.2);}}}
module details(){
 for(x=[1.4,7.3,13.2]) rect(x,1.4,4.4,7);
 rect(1.4,12,4.4,3);rect(13.2,12,4.4,3);
 ring(9.5,18,3.0,1.3);
 stroke([7.3,11.9],[8.7,10.6],1.2);stroke([8.7,10.6],[11.4,13.1],1.2);
}'''),
('Data_Center',19,33,'Enclosed server facade with two rooftop coolers and a lightning symbol.', '''module silhouette(){union(){rect(0,0,19,27);rect(1.5,27,6,6);rect(11.5,27,6,6);}}
module details(){
 rect(7.3,1.4,4.4,4.6);
 for(x=[1.6,7.5,13.4],y=[8,11.9,15.8]) rect(x,y,4,2.5);
 polygon([[9.1,25.5],[6.8,21.5],[9.0,21.5],[8.4,19.5],[12.1,23.0],[9.8,23.0],[11.0,25.5]]);
 for(x=[3.0,13.0]) for(y=[28.5,30.8]) rect(x,y,3,1.2);
}'''),
('Cybersecurity_Center',19,34,'Shield-shaped crown, keyhole, sturdy entrance and three tall windows.', '''module silhouette(){polygon([[0,0],[19,0],[19,23],[14.5,23],[14.5,30],[9.5,34],[4.5,30],[4.5,23],[0,23]]);}
module details(){
 rect(6.8,1.4,5.4,6);
 for(x=[2.0,7.7,13.4]) rect(x,10,3.6,7);
 difference(){polygon([[5.9,28.2],[9.5,30.6],[13.1,28.2],[12.3,23.9],[9.5,21.8],[6.7,23.9]]);polygon([[7.3,27.5],[9.5,29.0],[11.7,27.5],[11.1,24.7],[9.5,23.5],[7.9,24.7]]);}
 disc(9.5,26.8,0.9);rect(8.8,24.8,1.4,2.0);
}'''),
('Telecommunications_Hub',19,41,'Wide communications mast, two signal arcs and three tall windows.', '''module silhouette(){union(){rect(0,0,19,25);rect(2,23,15,8);rect(8,29,3,10);rect(7,38.5,5,2.5);}}
module details(){
 rect(7.3,1.4,4.4,5.6);
 for(x=[2.2,7.7,13.2]) rect(x,10,3.6,8);
 intersection(){ring(9.5,24,5.7,1.3);rect(3.5,24,12,6);}
 intersection(){ring(9.5,24,3.1,1.3);rect(6.2,24,6.6,3.2);}
 rect(8.8,21,1.4,2.8);
}'''),
('Submarine_Cable_Landing_Station',19,26,'Low coastal facade with two cable reels, connecting cable and waves.', '''module silhouette(){polygon([[0,0],[19,0],[19,22],[9.5,26],[0,22]]);}
module details(){
 rect(6.8,6.8,5.4,5.2);
 for(x=[5.1,13.9]) ring(x,17.8,3.2,1.2);
 stroke([5.1,17.8],[13.9,17.8],1.2);
 for(y=[1.8,4.4]){stroke([1.6,y],[5.2,y+0.5],1.2);stroke([5.2,y+0.5],[9.5,y],1.2);stroke([9.5,y],[13.8,y+0.5],1.2);stroke([13.8,y+0.5],[17.4,y],1.2);}
}'''),
('Electronics_Factory',20,30,'Asymmetrical loading hall and taller right-hand section with a smartphone icon.', '''module silhouette(){polygon([[0,0],[20,0],[20,30],[10.5,30],[10.5,24],[5,24],[5,21],[0,21]]);}
module details(){
 rect(1.4,1.4,6.7,6.0);rect(10,1.4,8.5,6.0);
 for(x=[1.4,6.0,10.6,15.2]) rect(x,10,3.2,2.6);
 framed(11.8,16.5,6.8,11.8,1.3);
 rect(13.3,21.6,3.8,4.0);
 disc(15.2,19.7,0.7);
 rect(1.4,16.5,6.7,2.7);
}'''),
('Digital_Skills_Academy',19,34,'School with a stepped central facade, keyboard and two rows of windows.', '''module silhouette(){polygon([[0,0],[19,0],[19,25],[16,25],[16,28],[13,28],[13,31],[11,31],[11,34],[8,34],[8,31],[6,31],[6,28],[3,28],[3,25],[0,25]]);}
module details(){
 rect(7.3,1.4,4.4,5.6);
 for(x=[1.4,5.7,10.0,14.3],y=[9,13.8]) rect(x,y,3.0,3.0);
 for(x=[5.0,8.4,11.8],y=[20.0,23.4]) rect(x,y,2.2,2.2);
 rect(8.8,28.5,1.4,2.7);
}'''),
('Electronics_Recycling_Center',20,28,'Arched recycling hall with three arrows and three sorting bins.', '''module silhouette(){union(){rect(0,0,20,18);intersection(){disc(10,18,10);rect(0,18,20,10);}}}
module details(){
 for(x=[1.4,7.7,14.0]) rect(x,1.4,4.6,5.4);
 arrow([6.6,12.4],[13.8,12.4],1.4);
 arrow([14.3,14.4],[10.8,21.0],1.4);
 arrow([8.7,20.3],[5.3,14.0],1.4);
}'''),
('Software_and_Platform_Headquarters',19,40,'Tall office tower with low side wings and four app tiles.', '''module silhouette(){polygon([[0,0],[19,0],[19,23],[15,23],[15,36],[13,36],[13,38],[11,38],[11,40],[8,40],[8,38],[6,38],[6,36],[4,36],[4,23],[0,23]]);}
module details(){
 rect(5.4,1.4,8.2,5.4);
 for(x=[5.5,8.9,12.3],y=[9,13.8,18.6,23.4]) rect(x,y,2.2,3.0);
 for(x=[6.0,10.4],y=[27.8,32.2]) rr(x,y,2.6,2.6,0.6);
 rect(1.4,10,1.2,9);rect(16.4,10,1.2,9);
}'''),
]
manifest=[]
for i,(name,w,h,desc,body) in enumerate(MODELS,1):
 stem=f'{i:02d}_{name}'
 (D/f'{stem}.scad').write_text(COMMON+'\n'+body+'\n',encoding='utf-8')
 manifest.append(dict(name=name.replace('_',' '),filename=f'../01_Print_Models/STL/{stem}.stl',source=f'{stem}.scad',width=w,height=h,depth=15,description=desc))
(D/'manifest.json').write_text(json.dumps(dict(sector='Tech, AI & digital',units='mm',front_recess=1.5,models=manifest),indent=2,ensure_ascii=False)+'\n')
print('Created',len(MODELS),'SCAD sources')
