full_length = 80;
window_frame_thickness = 20.75;
window_open_angle = 4.45;

// ---------------------------------------------------------

h = 20;
pusher_width = 10;
clamp_depth = 20;
text_depth = 0.75;
text_height = 7;
frame_bumper_height = 40;
frame_bumper_thickness = 10;

// ---------------------------------------------------------

text_padding=(pusher_width-text_height)/2;
clamp_external_width = 1.75*window_frame_thickness;
clamp_external_width=(1+abs(cos(-window_open_angle)))*window_frame_thickness;

ver_text_height=(clamp_external_width-window_frame_thickness)/4;
ver_text_padding=ver_text_height/2;

// very dirty equivalient to "%f.02"
function fmt_num(x) = str(
  floor(round(x*100)/100),
  ".",
  round(abs(x)*100)%100 > 9 
    ? round(abs(x)*100)%100
    : str("0", round(abs(x)*100)%100)
); 

// pusher
difference(){
  cube([full_length,pusher_width,h]);
  translate([text_padding,text_padding,h-text_depth]){
    rotate(a=[0,0,0]) {
      linear_extrude(2*text_depth) {
        text(str(
          fmt_num(window_open_angle),"°",
          " ",
          fmt_num(window_frame_thickness),"mm"
        ), text_height, "Ubuntu-Title");
      };
    };
  }
};

// frame bumper
translate([full_length-frame_bumper_thickness,0,0]){
  cube([frame_bumper_thickness,pusher_width,frame_bumper_height]);
};

// clamp
translate([0,pusher_width,0]){
  difference(){
    cube([clamp_external_width,clamp_depth,h]);
    rotate(a=[0,-window_open_angle,0]){
      translate([(clamp_external_width-window_frame_thickness)/2,0,-h]){
        cube([window_frame_thickness,clamp_external_width,h*3]);
      };
    };
    translate([text_padding,clamp_depth-text_padding,h-text_depth]){
      rotate(a=[0,0,-90]) {
        linear_extrude(text_depth) {
          text(str(
            "v0.4"
          ), ver_text_height, "Ubuntu-Title");
        };
      };
    };
  };
};
