full_length = 80;
window_frame_thickness = 20.75;
window_open_angle = 4.45;
use_on_right_side_of_window=true;

// ---------------------------------------------------------

h = 20;
pusher_width = 10;
clamp_depth = 20;
text_depth = 0.75;
text_height = 7;
jamb_bumper_height = 40;
jamb_bumper_thickness = 10;
use_angled_hole=true;
hole_dia=3;

// ---------------------------------------------------------

slope_angle = use_on_right_side_of_window ? -window_open_angle : -window_open_angle;
dir_text = use_on_right_side_of_window ? "R" : "L";
text_padding=(pusher_width-text_height)/2;
clamp_external_width=(1+abs(cos(-window_open_angle)))*window_frame_thickness;
clamp_y_offset = use_on_right_side_of_window ? pusher_width : -2*pusher_width;
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
  };

  if (use_angled_hole){
    translate([clamp_external_width/2,use_on_right_side_of_window ? pusher_width/2+hole_dia : pusher_width/2-hole_dia,-1*hole_dia]){
      rotate(a=[use_on_right_side_of_window ? 45 : -45,0,0]){
        cylinder(3*pusher_width, d=hole_dia, d=hole_dia);
      };
    };
  }
  else {
    translate([clamp_external_width/2,2*pusher_width,2*hole_dia]){
      rotate(a=[90,0,0]){
        cylinder(3*pusher_width, hole_dia, hole_dia);
      };
    };
  }
};

// jamb bumper
difference(){
  translate([full_length-jamb_bumper_thickness,0,0]){
    cube([jamb_bumper_thickness,pusher_width,jamb_bumper_height]);
  };
  translate([full_length-jamb_bumper_thickness+2,pusher_width-2,jamb_bumper_height-text_depth]){
    rotate(a=[0,0,270]) {
      linear_extrude(2*text_depth) {
        text(dir_text, text_height, "Ubuntu-Title");
      };
    };
  };
};

// clamp
translate([0,clamp_y_offset,0]){
  difference(){
    cube([clamp_external_width,clamp_depth,h]);
    rotate(a=[0,slope_angle,0]){
      translate([(clamp_external_width-window_frame_thickness)/2,0,-h]){
        cube([window_frame_thickness,clamp_external_width,h*3]);
      };
    };
    translate([text_padding,clamp_depth-text_padding,h-text_depth]){
      rotate(a=[0,0,-90]) {
        linear_extrude(text_depth) {
          text(str(
            " v0.6"
          ), ver_text_height, "Ubuntu-Title");
        };
      };
    };
  };
};
