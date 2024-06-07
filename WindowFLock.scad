length = 80;
window_frame_thickness = 20.75;
window_open_angle = 2.5;


h = 20;
pusher_width = 10;
clamp_depth = 20;
//clamp_external_width = 40;
clamp_external_width = 1.75*window_frame_thickness;
text_depth=0.75;
text_height=6;
text_padding=(pusher_width-text_height)/2;

difference(){
  cube([length,pusher_width,h]);
  translate([text_padding,text_padding,h-text_depth]){
    rotate(a=[0,0,0]) {
      linear_extrude(text_depth) {
        text(str(
          "v0.2",
          " ",
          window_open_angle,"°",
          " ",
          window_frame_thickness,"mm"
        ), text_height, "Ubuntu-Title");
      }
    }
  }
}

translate([0,pusher_width,0]){
  difference(){
    cube([clamp_external_width,clamp_depth,h]);
    translate([(clamp_external_width-window_frame_thickness)/2,0,0]){
      rotate(a=[0,window_open_angle,0])
        cube([window_frame_thickness,clamp_external_width,h*2]);
    }
  };
};