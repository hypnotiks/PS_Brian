/*
from demo on for loops
*/

int r=255, g=255, b=255;
int xCircle=250, yCircle=250;
int radCircle = 25;
int circleStep = 2;
int xSquare = xCircle, ySquare = yCircle;
int squareWidth = 100;
int score = -1;
IntList xFireworks = new IntList();
IntList yFireworks = new IntList();

boolean upPressed = false, downPressed = false, leftPressed = false, rightPressed = false;

enum DrawState
{
  LINES, TRIANGLE, FIREWORKS, CIRCLE
};

DrawState currentState = DrawState.LINES;

void setup(){
  size(500, 500, P3D);
  background(0);
  
}


void draw(){
  background(0);
  if(currentState == DrawState.LINES)
  {
    fill(255);
    stroke(102);
    for (int y = 100; y <= height-100; y += 10) {
       for (int x = 100; x <= width-100; x += 10) {
         stroke(102);
         ellipse(x, y, 4, 4);
         stroke(r,g,b);
         line(x, y, mouseX, mouseY);
       }
    }
  }
  else if (currentState == DrawState.TRIANGLE) {
    fill(255);
    stroke(102);
    for (int y = 100; y <= height-100; y += 10) {
       for (int x = 100; x <= width-100; x += 10) {
         stroke(102);
         ellipse(x, y, 4, 4);
         stroke(r,g,b);
         //noFill();
         triangle(x, y, mouseX, mouseY, height / 2, width / 2);
       }
    }
  }
  else if (currentState == DrawState.CIRCLE) {
     if(upPressed) {
       println("up");
       yCircle -= circleStep; 
     }
     else if (downPressed) {
       yCircle += circleStep; 
     }
     
     if(leftPressed) {
       println("left");
       xCircle -= circleStep; 
     }
     else if (rightPressed) {
       xCircle += circleStep; 
     }
     
     noStroke();
     fill(r, g, b);
     ellipse(xCircle, yCircle, radCircle, radCircle);
     if(checkCollision(xCircle, yCircle))
     {
       xSquare = int(random(squareWidth / 2, width - squareWidth / 2));
       ySquare = int(random(squareWidth / 2, height - squareWidth / 2));
       score++;
       
       println("score: " + score);
     }
     
     textSize(40);
     textAlign(LEFT);
     text("score: " + score, 50, 50);
     rectMode(CENTER);
     rect(xSquare, ySquare, squareWidth, squareWidth);
  }
  else { //fireworks??
     if(checkCollision(mouseX, mouseY))
     {
       xFireworks.append(xSquare);
       yFireworks.append(ySquare);
       
       xSquare = int(random(squareWidth / 2, width - squareWidth / 2));
       ySquare = int(random(squareWidth / 2, height - squareWidth / 2));
     }
       
     for(int i=0; i<xFireworks.size(); i++)
     {
       randomizeColor();
       stroke(r,g,b);
       ellipse(xFireworks.get(i), yFireworks.get(i), 5, 5);
       float angle =TWO_PI / 8;
       for(int j=0; j<8; j++)
       {
         randomizeColor();
         stroke(r,g,b);
         strokeCap(ROUND);
         line(xFireworks.get(i), yFireworks.get(i), xFireworks.get(i)+100*sin(angle*j), yFireworks.get(i)+100*cos(angle*j));
       }
     }
     stroke(102);
     noFill();
     rect(xSquare, ySquare, squareWidth, squareWidth);
  }
}

boolean checkCollision(int x, int y)
{
  println(x + "," + x);
  println("square: " + y + "," + y);
  if((x >= xSquare - squareWidth / 2) && (x <= xSquare + squareWidth / 2))
  {
    println("x good");
    if((y >= ySquare - squareWidth / 2) && (y <= ySquare + squareWidth / 2))
    {
      println("y good");
      return true;
    }
  }
  return false;
}

void mousePressed() {
  randomizeColor();
}

void randomizeColor()
{
  r = int(random(255));
  g = int(random(255));
  b = int(random(255));
}

void keyPressed() {
  if(key == 's')
  {
    if(currentState == DrawState.LINES) {
      currentState = DrawState.TRIANGLE;
    }
    else if (currentState == DrawState.TRIANGLE) {
      currentState = DrawState.CIRCLE;
    }
    else if (currentState == DrawState.CIRCLE && key != DOWN && key != UP && key != RIGHT && key != LEFT) {
      currentState = DrawState.FIREWORKS;
    }
    else {
      currentState = DrawState.LINES; 
    }
  }
  
  if(key == CODED)
  {
     if(keyCode == UP) {
       upPressed = true;
     }
     else if (keyCode == DOWN) {
       downPressed = true;
     }
     
     if(keyCode == LEFT) {
       leftPressed = true; 
     }
     else if (keyCode == RIGHT) {
       rightPressed = true; 
     }
  }
}

void keyReleased() {
  if(key == CODED)
  {
     if(keyCode == UP) {
       upPressed = false;
     }
     else if (keyCode == DOWN) {
       downPressed = false;
     }
     
     if(keyCode == LEFT) {
       leftPressed = false; 
     }
     else if (keyCode == RIGHT) {
       rightPressed = false; 
     }
  }
}