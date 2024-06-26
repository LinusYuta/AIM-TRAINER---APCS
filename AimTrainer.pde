import java.util.ArrayList;
import processing.sound.*;

Camera newCam;
PImage img;
PShape enviro;
SoundFile gunShot;

public Target tar1;
public ArrayList<Bullet> bulletList = new ArrayList<Bullet>();
public double hitCount = 0;
public double missCount = 0;
public ArrayList<Score> scoreList = new ArrayList<Score>();
boolean gameOn = false;
public long startTime = System.currentTimeMillis();
public long elapsed = 0;




void setup() {
  size(1300, 700, P3D);
  newCam = new Camera(500, 300, 700);
  tar1 = new Target();
  lights();
  img = loadImage("sky3.jpg");
  enviro = createShape(SPHERE, 3000);
  enviro.setTexture(img);
  enviro.setStrokeWeight(0);
  gunShot = new SoundFile(this, "gunShot1.mp3");
}

void draw() {

    

    noCursor();
    background(0);
    //camera(mouseX, mouseY, (height/2) / tan(PI/6), mouseX, mouseY, 0, 0, 2, 0);
    
    /*
    noStroke();
    fill(255, 49, 49);
    pushMatrix();
    translate(1000,0,0);
    sphere(50);
    popMatrix(); */

    tar1.draw();

    fill(0);
    //block(0, 0, 0, 100);
    
    fill(90, 90, 90);
    //fill(255);
    stroke(0);
    strokeWeight(2);
    
    for (int z = 0; z < 10; z++ ) {
        for (int x = 0; x < 10; x++) {
        block(x*100, 500, z*100, 100);
        }
    }
    
    for (int y= 0; y < 5; y++ ) {
        for (int x = 0; x < 10; x++) {
        block(x*100, 500 - y*100, 0, 100);
        }
    } 

    shape(enviro);
    newCam.move();

    //newCam.shoot();
    /*

    for (int i = 0; i < bulletList.size(); i++) {
        Bullet selected = bulletList.get(i);
        selected.move();
        boolean collided = selected.checkCollision(tar1);
        if (collided){
          tar1.changeLocation();
        
        }
        PVector distance = PVector.sub(newCam.position, selected.bulPos);
        if (distance.mag() > 1200){
            bulletList.remove(i);
        }
        
    } */

    elapsed = (System.currentTimeMillis() - startTime) / 1000;
    if (gameOn){
        if (elapsed >= 30){
            
            double acc = 0;

            if (hitCount > 0 || missCount > 0){
                acc = Math.round(100*(hitCount / (hitCount + missCount)));
            }

            Score newScore = new Score(hitCount, missCount, acc);
            scoreList.add(newScore);

            hitCount = 0;
            missCount = 0;
            elapsed = 0;
            gameOn = false;

        } 
    }

    newCam.hud();

    
}

void mousePressed(){

    //Bullet newBullet = new Bullet(newCam.position);
    Bullet newBullet = new Bullet();
    PVector moveTowards = new PVector(newCam.dirX, newCam.dirY, newCam.dirZ);
    PVector bulletVel = PVector.sub(moveTowards, newCam.position);
    bulletVel.setMag(25);
    newBullet.setVel(bulletVel);
    //bulletList.add(newBullet);
    
    boolean didCollide = false;

    for (int i = 0; i <= 40; i++) {
       newBullet.move();
       boolean collided = newBullet.checkCollision(tar1);
       
       if (collided){
          tar1.changeLocation();
          hitCount++;
          didCollide = true;
        
         }  
        
    }
    
    if (!didCollide){
      missCount++;
    
    }
    
    gunShot.play();
    


}

void keyPressed(){
    if (key == 'r'){
        if (!gameOn){
            gameOn = true; 
            startTime = System.currentTimeMillis();
            newCam.moveTo(500, 300, 700);
            hitCount = 0;
            missCount = 0;

        }
    }
    
}


void keyReleased(){
    if (key == 'w' || key == 'a' || key == 's' || key =='d'){
        newCam.bobValue = 0;
    }
}


//

void block(float x, float y, float z, float s){
    pushMatrix();
    translate(x, y, z);
    box(s);
    popMatrix();

}
