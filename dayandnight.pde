/*
Name : Peadar Ó Raifeartaigh
 Student Number: 20104299
 The piece represents a grid of suns and moons moving from day to night.
 The colour palette and shapes revolve around this day/night sky idea.
 */

float cloudXcoord = 200;
float cloudYcoord = 100;
boolean leftBounce = false;
color grass = color(119, 166, 58);
color day = color(119, 207, 202);
color night = color(33, 65, 114);
color sun = color(242, 135, 5);
color moon = color(242, 199, 119);
float angle = PI;
float angle2 = PI;
int gridCols = 16;
int gridRows = 9;
int boxWidth = (width/gridCols);
float grassXCoord = 10;
float grassYCoord = 720;
int row = 0;
int col = 0;
int j = 1;

void setup()
{
  size(1280, 720);
  surface.setLocation(0, 0); //to set location top left screen
  noStroke();
  mouseClicked();
}

void draw()
{
  mouseDragged();
  mousePressed(1);
  bounceCloud(2, 30);
  sunToMoon(4);
  fill(255);
  displayStudentInfo(25, 35);
  {
    for (int row=1; row < 32; row++)
    {
      for (int column=1; column < 18; column++)
      {
        spinStar(row*10, col*5, 0.01, 4);
      }
    }
  }
}


/*
Spinning stars function
 Somewhat buggy - see notes
 */
void spinStar(float transX, float transY, float spinSpeed, float triCoord)
{
  if ((mouseX>width*0.75) && (keyPressed))
  {
    if (key == 's' || key == 'S')
    {
      noStroke();
      translate(transX, transY);
      //clockwise triangle
      rotate(angle);
      fill(moon);
      // minus numbers are to spin round translate centre axis, not from corner
      triangle(-triCoord, triCoord, 0, -triCoord, triCoord, triCoord);
      angle += spinSpeed;
      //anticlockwise triangle
      rotate(angle2);
      fill(moon);
      triangle(-triCoord, triCoord, 0, -triCoord, triCoord, triCoord);
      //*2 as otherwise the two rotate values appear to cancel each other?
      angle2 -= (spinSpeed*2);
    }
  }
}

//function for cloud moving back and forth.
void bounceCloud(float speed, float size)
{
  fill(moon);
  circle(cloudXcoord, (cloudYcoord), size);
  circle((cloudXcoord-(size/2)), (cloudYcoord+(size/2)), size);
  circle(cloudXcoord+(size/2), (cloudYcoord+(size/2)), size);
  circle(cloudXcoord, (cloudYcoord+(size/2)), size);
  circle(cloudXcoord-(size/2), (cloudYcoord+(size/2)), size);
  circle(cloudXcoord+(size/2), (cloudYcoord+(size/2)), size);

  if ((mouseX<=width/2)&&(mouseY<=height/2))
  {
    if (cloudXcoord == width-size)
    {
      leftBounce = true;
    }
    if (cloudXcoord == size)
    {
      leftBounce = false;
    }

    if (!leftBounce)
    {
      cloudXcoord += speed;
    } else
    {
      cloudXcoord -= speed;
    }
  }
}

//print display as PNG with right click
void mouseClicked()
{
  if (mouseButton == RIGHT)
  {
    saveAsPNG();
  }
}

void saveAsPNG()
{
  save("dayandnight.PNG");
}

/*
Displays student ID and name
 Using some string methods
 */

void displayStudentInfo(int randRange1, int randRange2)
{
  int i = 0;
  int xCoord = width/32;
  float yCoord = width/32;
  String forename = "peadar";
  String surname = " ó raifeartaigh";
  String studentNumInfo = "student number: 20104299";
  String studentNum = studentNumInfo.substring(16, 24); //substring method
  String fullName = forename.concat(surname); //concat method

  //student number display
  while (i < studentNum.length()) //length method
  {
    textSize(random(randRange1, randRange2));
    text(studentNum.charAt(i), xCoord, (height-10)); //charAt  method
    xCoord += 80;
    i++;
  }

  //Student name display
  if (fullName.startsWith("pea")) //startswith  method
  {
    textSize(35);
    text(fullName.toUpperCase(), boxWidth+40, yCoord); //touppercase method
  }
}

//grass growing method
void mousePressed(float growSpeed)
{
  for (int column = 0; column < 32; column++)
  {
    circle(column*(width/32)+grassXCoord, grassYCoord, 20);
    if (mouseButton == LEFT)
    {
      fill(grass);
      grassXCoord += random(-1, 1);
      grassYCoord -= growSpeed*0.15;
    }
  }
}

/*Drag mouseX to change from col day to col night.
 hard number vals (col day-col night diff/width)
 with the gradient going to col night from left to right */
void mouseDragged()
{
  float r = 119;
  float g = 207;
  float b = 202;
  if ((r>=33) && (g>=65) && (b>=114))
  {
    r -= mouseX*0.090625;
    g -= mouseX*0.1109375;
    b -= mouseX*0.06875;
    background(r, g, b);
  }
  if (mouseX>(width/2))
  {
    background(night);
  }
}

/* grid of suns and
 moons */
void sunToMoon(int size)
{
  for (int column = 0; column < gridCols; column++)
  {
    for (int row = 0; row < gridRows; row++)
    {
      if (mouseX<=((width/2)-40))
      {
        fill(day);
        circle(column*(width/gridCols)+10, row*(height/gridRows)+(boxWidth/2), width/(size*gridCols));
        fill(sun);
        circle(column*(width/gridCols)+boxWidth, row*(height/gridRows)+(boxWidth/2), width/(size*gridCols));
      } else if ((mouseX<(width/2.1)) && (mouseX>((width/2)-(boxWidth/2))))
      {
        fill(moon);
        circle(column*(mouseX/gridCols), row*(height/gridRows)+(boxWidth/2), width/(size*gridCols));
        fill(sun);
        circle((column*((width/gridCols)-(mouseX/gridCols))), row*(height/gridRows)+(boxWidth/2), width/(size*gridCols));
      } else
      {
        fill(moon);
        circle(column*(width/gridCols)+boxWidth, row*(height/gridRows)+(boxWidth/2), width/(size*gridCols));
        fill(night);
        circle(column*(width/gridCols)+(boxWidth-10), row*(height/gridRows)+(boxWidth/2), width/(size*gridCols));
      }
    }
  }
}
