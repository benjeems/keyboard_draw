// Project created simply to learn some of the import/export and control structures in processing.
// Ben Reardon. March 2011. http://dataviz.com.au
// Draw a keyboard from csv data file. Take input from a text file, highlight and smudge pressed keys, 
// display scrolling lines, make typewriter sounds through mimim library.
// Terrrible coding follows:

import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
String [] book;
String[] lines;
String [] word;
char this_letter;
int letter_number=0;
int index = 0;
int scale = 3;
PFont key_FONT;
int line_number = 0; 
int position_i=0;
int x = 25*scale; 
int last_rec_x = 0; 
int last_rec_y = 0;
int last_rec_w=0;
int last_rec_h=0;
int found = 0;
int stop_drawing=0;
int smudge_fill=240;
int smudge_fill_opacity=100;
int smudge_stroke=111;
int smudge_stroke_opacity=230;
int smudge_size = 10;
int smudge_variance = 2;
int display_line=10;
int x_display = 25*scale;
Minim minim;
AudioSnippet snip;

void setup() {
  size(335*scale,200*scale);  
  background(#F0F0F0);
  stroke(0);
  frameRate(30);
  fill(0);
  //draw the display screen
  roundrect(25*scale,20, (310-25)*scale, 240,15);
  draw_keyboard();
  //book = loadStrings("keyboard_draw1.txt");
  //book = loadStrings("tiger_blood_man.txt");
  book = loadStrings("keyboard_draw1.txt");
  key_FONT = loadFont("Courier-14.vlw");
  fill(#00FF4E);
  textFont(key_FONT, 14);
  textAlign(LEFT);
  fill (0,0);
  stroke (210);
}
 
void draw() {

    fill (0,0);
    stroke (210);
    rect (last_rec_x, last_rec_y, last_rec_w, last_rec_h); // unhighlight the last key pressed
    rect(25*scale-3, 158*scale-3, 40*scale+6, 15*scale+6); // unhighlight the SHIFT key everytime
    rect(279*scale-3, 139*scale-3, 31*scale+6, 15*scale+6); // unhighlight the return key everytime
    fill(#00FF4E);

    if (line_number == book.length) {
             noLoop();
             stop_drawing=1;
             found = 1;
             text(book[book.length-1], 25*scale, 260);
             line_number=0; // to satisfy out of bounds on the next if statement. OMG messy! like tiger blood
    }

    if (book[line_number].length() == 0 && stop_drawing == 0 ) { //LOOK FOR EMPTY LINES
              found=1;
              stroke(0);
              fill (0,0);
              rect(279*scale-3, 139*scale-3, 31*scale+6, 15*scale+6); //PRESS RETURN
              last_rec_x = 279*scale-3; last_rec_y = 139*scale-3; last_rec_w=31*scale+6; last_rec_h=15*scale+6;
              fill (smudge_fill, smudge_fill_opacity);
              stroke (smudge_stroke, smudge_stroke_opacity);
              ellipse((279+15+25*random(-.5,.5))*scale, (139+15/2+7*random(-0.5,0.5))*scale , smudge_size+smudge_variance*random(-1,1), smudge_size+smudge_variance*random(-1,1));
              line_number=line_number+1;
              //minim = new Minim(this);
               //snip = minim.loadSnippet("kerching.wav");
               //snip.play();
               //delay(100);
     }
    else { 
                   if (line_number != book.length && stop_drawing ==0  ) {
                        fill(0); 
                        roundrect(25*scale,20, (310-25)*scale, 240,15); //blank out all but the lower part of the screen only if its not the last line of the book
                        this_letter = book[line_number].charAt(position_i);
                        key_FONT = loadFont("Courier-14.vlw");
                        fill(#00FF4E);
                        textFont(key_FONT, 14);
                        textAlign(LEFT);
                        x_display=25*scale;
                        for (int i = 0; i < position_i+1 && i <  108; i = i+1) { 
                            text(book[line_number].charAt(i),x_display,260);  
                            x_display = x_display+8; 
                        } 
                    }
              
                ////NOW DO THE SCROLLED LINES IN THE DISPLAY
                fill(#00FF4E);
                if (line_number > 0 && stop_drawing == 0) {
                  text(book[line_number-1], 25*scale, 260-(20*1));
                  paintover();
                    if (line_number > 1) {
                      text(book[line_number-2], 25*scale, 260-(20*2));
                      paintover();
                        if (line_number>2) {
                          text(book[line_number-3], 25*scale, 260-(20*3));
                          paintover();
                            if (line_number>3) {
                              text(book[line_number-4], 25*scale, 260-(20*4));
                              paintover();
                              if (line_number>4) {
                                text(book[line_number-5], 25*scale, 260-(20*5));
                                paintover();
                                if (line_number>5) {
                                  text(book[line_number-6], 25*scale, 260-(20*6));
                                  paintover();
                                   if (line_number >6) {           
                                     text(book[line_number-7], 25*scale, 260-(20*7));
                                     paintover();
                                     if (line_number>7) {
                                        text(book[line_number-8], 25*scale, 260-(20*8));
                                        paintover();
                                        if (line_number >8) {
                                          text(book[line_number-9], 25*scale, 260-(20*9));
                                          paintover();
                                          if (line_number > 10) {
                                            text(book[line_number-10], 25*scale, 260-(20*10));
                                            paintover();
                                            if (line_number > 11) {
                                               text(book[line_number-11], 25*scale, 260-(20*11));
                                               paintover();
                                            }
                                          }
                                        }
                                     }
                                   }
                                }
                              }
                            }
                         }
                      }
                   }      
                                
              if (position_i < (book[line_number].length()-1)) {
                  position_i=position_i+1;
                  x=x+8;
              }
              else { // WE REACHED THE END OF THE LINE
                  position_i=0;
                  line_number=line_number+1;
                  x=25*scale;
                  stroke(0);
                  fill (0,0);
                  rect(279*scale-3, 139*scale-3, 31*scale+6, 15*scale+6); //PRESS RETURN
                  last_rec_x = 279*scale-3; last_rec_y = 139*scale-3; last_rec_w=31*scale+6; last_rec_h=15*scale+6;
                  fill (smudge_fill, smudge_fill_opacity);
                  stroke (smudge_stroke, smudge_stroke_opacity);
                  ellipse((279+15+25*random(-.5,.5))*scale, (139+15/2+7*random(-0.5,0.5))*scale , smudge_size+smudge_variance*random(-1,1), smudge_size+smudge_variance*random(-1,1));
                   //minim = new Minim(this);
                   //snip = minim.loadSnippet("kerching.wav");
                    //play the file
                   //snip.play();
                   //delay(100);
                   found = 1;   
              }
           
              int index=1;
              int found=0;
              // SPECIAL CASE OF THE SPACE BAR
              if (Character.toString(this_letter).equals(" ")) {
                  found=1;
                  stroke(0);
                  fill (0,0);
                  rect(109*scale-3, 177*scale-3, 96*scale+6, 15*scale+6); //PRESS SPACE!!
                  last_rec_x = 109*scale-3; last_rec_y = 177*scale-3; last_rec_w=96*scale+6; last_rec_h=15*scale+6;
                  fill (smudge_fill, smudge_fill_opacity);
                  stroke (smudge_stroke, smudge_stroke_opacity);
                  ellipse((109+96/2+96/2*random(-.5,.5))*scale, (177+15/2+15/2*random(-0.5,0.5))*scale , smudge_size+smudge_variance*random(-1,1), smudge_size+smudge_variance*random(-1,1));
                   //minim = new Minim(this);
                   //snip = minim.loadSnippet("space_bar.wav");
                   ////snip.play();  
              }  
           
              while (index < lines.length && found == 0 ) {     
                  String[] pieces = split(lines[index], '\t');
                  String key_NAME = pieces[1].toLowerCase(); //assume its a lower case (will be more common)
                  if (Character.toString(this_letter).equals(key_NAME)) {
                      int key_X = int(pieces[4]);
                      int key_Y = int(pieces[6]);            
                      int key_W = int(pieces[7]);
                      int key_H = int(pieces[8]);
                      //make the box edge highlight
                      stroke(0);
                      fill (0,0);
                      rect((key_X*scale)-3, (key_Y*scale)-3, (key_W*scale)+6, (key_H*scale+6));
                      last_rec_x = key_X*scale-3; last_rec_y = key_Y*scale-3; last_rec_w=key_W*scale+6; last_rec_h=key_H*scale+6;
                      fill (smudge_fill, smudge_fill_opacity);
                      stroke (smudge_stroke, smudge_stroke_opacity);
                      ellipse((key_X+key_W/2+key_W/2*random(-.5,.5))*scale, (key_Y+key_H/2+key_H/2*random(-0.5,0.5))*scale , smudge_size+smudge_variance*random(-1,1), smudge_size+smudge_variance*random(-1,1));
                      found=1; 
                      //minim = new Minim(this);
                      //snip = minim.loadSnippet("click_typewriter.wav");
                      ////snip.play();
                   }
             index=index+1;  //MOVE ONTO THE NEXT LINE IN THE KEYBOARD DEFINITION           
             } //END OF lower CASE WHILE LOOP
          
                
             //If not found, search for upper case matches
              index=1;
              while (index < lines.length && found == 0) {
                  String[] pieces = split(lines[index], '\t');
                  String key_NAME = pieces[1]; //This time don't convert to LC
                  if (Character.toString(this_letter).equals(key_NAME)) {
                      int key_X = int(pieces[4]);
                      int key_Y = int(pieces[6]);
                      int key_W = int(pieces[7]);
                      int key_H = int(pieces[8]);
                      //make the box edge highlight
                      stroke(0);
                      fill (0,0);
                      rect(25*scale-3, 158*scale-3, 40*scale+6, 15*scale+6); //PRESS SHIFT!!
                      rect(key_X*scale-3, key_Y*scale-3, key_W*scale+6, key_H*scale+6);
                      last_rec_x = key_X*scale-3; last_rec_y = key_Y*scale-3; last_rec_w=key_W*scale+6; last_rec_h=key_H*scale+6;
                      fill (smudge_fill, smudge_fill_opacity);
                      stroke (smudge_stroke, smudge_stroke_opacity);
                      ellipse((25+40/2+40/2*random(-.5,.5))*scale, (158+15/2+15/2*random(-0.5,0.5))*scale , smudge_size+smudge_variance*random(-1,1), smudge_size+smudge_variance*random(-1,1)); //SHIFT
                      ellipse((key_X+key_W/2+key_W/2*random(-.5,.5))*scale, (key_Y+key_H/2+key_H/2*random(-0.5,0.5))*scale , smudge_size+smudge_variance*random(-1,1), smudge_size+smudge_variance*random(-1,1));
                      found=1; 
                      //minim = new Minim(this);
                      //snip = minim.loadSnippet("click_typewriter.wav");
                      ////snip.play(); 
                   }
               index=index+1;  //MOVE ONTO THE NEXT LINE IN THE KEYBOARD DEFINITION           
               } //END OF UPPERCASE WHILE LOOP
               
              //if still not found, look through to see if it is an alt character 
              index=1;
              while (index <  lines.length && found == 0) {
                  String[] pieces = split(lines[index], '\t');
                  String key_NAME = pieces[3]; //get the alternate character this time
                  if (Character.toString(this_letter).equals(key_NAME)) {
                      int key_X = int(pieces[4]);
                      int key_Y = int(pieces[6]);
                      int key_W = int(pieces[7]);
                      int key_H = int(pieces[8]);
                      //make the box edge highlight
                      stroke(0);
                      fill (0,0);
                      rect(25*scale-3, 158*scale-3, 40*scale+6, 15*scale+6); //PRESS SHIFT!!
                      rect(key_X*scale-3, key_Y*scale-3, key_W*scale+6, key_H*scale+6);
                      last_rec_x = key_X*scale-3; last_rec_y = key_Y*scale-3; last_rec_w=key_W*scale+6; last_rec_h=key_H*scale+6;
                      fill (smudge_fill, smudge_fill_opacity);
                      stroke (smudge_stroke, smudge_stroke_opacity);
                      ellipse((25+40/2+40/2*random(-.5,.5))*scale, (158+15/2+15/2*random(-0.5,0.5))*scale , smudge_size+smudge_variance*random(-1,1), smudge_size+smudge_variance*random(-1,1)); //SHIFT
                      ellipse((key_X+key_W/2+key_W/2*random(-.5,.5))*scale, (key_Y+key_H/2+key_H/2*random(-0.5,0.5))*scale , smudge_size+smudge_variance*random(-1,1), smudge_size+smudge_variance*random(-1,1));      
                      found=1;  
                      //minim = new Minim(this);
                       //snip = minim.loadSnippet("click_typewriter.wav");
                       ////snip.play();
                   }
                   index=index+1;  //MOVE ONTO THE NEXT LINE IN THE KEYBOARD DEFINITION           
               } //END OF alt WHILE LOOP

    } ///END OF THE EMPTY LINE FINDER IF STATEMENT

} //END OF void draw


////////////////////////THIS PART JUST DRAWS THE KEYBOARD
void draw_keyboard() {
 lines = loadStrings("keyboard_definition.txt");

  while (index < lines.length) {
    String[] pieces = split(lines[index], '\t');
    
      int key_ID = int(pieces[0]);
      String key_NAME = pieces[1];
      int key_HAS_ALT = int(pieces[2]);
      String key_ALT = pieces[3];  
      int key_X = int(pieces[4]);
      int key_Y = int(pieces[6]);
      int key_W = int(pieces[7]);
      int key_H = int(pieces[8]);
      int key_JUSTIFICATION = int(pieces[9]);
      int key_ROW = int(pieces[10]);
   
      fill (255);     
      roundrect(key_X*scale, key_Y*scale, key_W*scale, key_H*scale, 6);
     
      rect(key_X*scale, key_Y*scale, key_W*scale, key_H*scale);
      stroke(255);
      fill(0, 102, 128); 
   
      if (key_HAS_ALT == 0) {
       //Print the keys without any alternate 
         switch(key_JUSTIFICATION) { 
              case 1:
                key_FONT = loadFont("CenturyGothic-11.vlw");
                textFont(key_FONT, 11);
                textAlign(LEFT);
                text (key_NAME,(key_X+1)*scale, (key_Y+key_H-2)*scale); // print in the left bottom of the key
              break;
              
              case 2:
                key_FONT = loadFont("CenturyGothic-12.vlw");
                textFont(key_FONT, 12);
                textAlign(CENTER, CENTER);
                text (key_NAME,(key_X+key_W/2)*scale+3, (key_Y+key_H-1)*scale); // print in the bottom (was center) middle of the key
              break;
              
              case 3:
                key_FONT = loadFont("CenturyGothic-11.vlw");
                textFont(key_FONT, 11);
                textAlign(RIGHT);
                text (key_NAME,(key_X+key_W-1)*scale, (key_Y+key_H)*scale+3); // print in the right bottom of the key
              break;  
          }
     }  
    else {
              switch(key_JUSTIFICATION) { 
                
              case 1:
                key_FONT = loadFont("CenturyGothic-11.vlw");
                textFont(key_FONT, 11);
                textAlign(LEFT);
                text (key_NAME,(key_X+1)*scale, (key_Y+key_H-2)*scale); // print the main char in the left bottom of the key
                text (key_ALT,(key_X+1)*scale, (key_Y+key_H-10)*scale); // print the alt char in the left top of the key
              break;
              
              case 2:
                key_FONT = loadFont("CenturyGothic-12.vlw");
                textFont(key_FONT, 12);
                textAlign(CENTER);
                text (key_NAME,(key_X+key_W/2+1)*scale, (key_Y+key_H)*scale+1); // print the main char in the center bottom of the key
                text (key_ALT,(key_X+key_W/2+1)*scale, (key_Y)*scale+9); // print the alt char in the center top of the key
              break;
              
              case 3:
                key_FONT = loadFont("CenturyGothic-11.vlw");
                textFont(key_FONT, 11);
                textAlign(RIGHT);
                text (key_NAME,(key_X+key_W-1)*scale, (key_Y+key_H)*scale+1); // print the main char in the right bottom of the key
                text (key_ALT,(key_X+key_W-1)*scale, (key_Y)*scale+9); // print the alt char in the right top of the key
              break; 
              } 
    }
    //increase index to step through to next key in the keyboard definition file
    index = index + 1;
  }   
}  

void paintover() {
  fill(#F0F0F0);
  stroke(#F0F0F0);
  rect((310)*scale+7,0,335*scale,200*scale); //paint over the text that scrolls off the right of the display
  fill(#00FF4E); //change back to green
}

//This draws the keys with the rounded edge
void roundrect(int x, int y, int w, int h, int r) {
 noStroke();
 rectMode(CORNER);
 int  ax, ay, hr;
 ax=x+w-1;
 ay=y+h-1;
 hr = r/2;
 rect(x, y, w, h);
 arc(x, y, r, r, radians(180.0), radians(270.0));
 arc(ax, y, r,r, radians(270.0), radians(360.0));
 arc(x, ay, r,r, radians(90.0), radians(180.0));
 arc(ax, ay, r,r, radians(0.0), radians(90.0));
 rect(x, y-hr, w, hr);
 rect(x-hr, y, hr, h);
 rect(x, y+h, w, hr);
 rect(x+w,y,hr, h);
}
// Project created simply to learn some of the import/export and control structures in processing.
// Ben Reardon. March 2011. http://dataviz.com.au
// Draw a keyboard from csv data file: 2. Take input from a text file, highlight and smudge pressed keys, display scrolling lines, make typewriter sounds.
