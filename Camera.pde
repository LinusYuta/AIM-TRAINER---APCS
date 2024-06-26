//https://forum.processing.org/two/discussion/3744/moving-camera.html
//https://behreajj.medium.com/cameras-in-processing-2d-and-3d-dc45fd03662c

class Camera {

  
  PVector position;
  PVector velocityX;
  PVector velocityZ;
  PVector direction;

  float dirX = 0;
  float dirY = 0;
  float dirZ = 0;

  float bobValue = 0;
  

  Camera(float x, float y, float z) {
    position = new PVector(x, y, z);
    velocityX = new PVector(0, 0, 0);
    velocityZ = new PVector(0, 0, 0);
  }

  void move(){

      pushMatrix();
      translate(position.x, position.y, position.z);

      rotateY(mouseX*-0.01);
      translate(150, 0 ,0);

      dirX = modelX(0,0,0);
      dirY = modelY(0,0,0);
      dirZ = modelZ(0,0,0);
      
      //rotateX(mouseY*-0.01);

      popMatrix();
      
      direction = new PVector(dirX, dirY, dirZ);
      

      //dirY = map(mouseY, 0, height, 0, height);
      dirY = mouseY;
      camera(position.x, position.y, position.z, dirX, dirY, dirZ, 0, 1, 0);
      


      fill(0);
      //block(dirX, dirY, dirZ, 1);

      


      if (keyPressed){
          if (key == 'w' || key == 'a' || key == 's' || key =='d'){
              if (bobValue == 0){
                  bobValue = 1;
              }

              bobValue *= -1;

              /*
              if (bobValue < 6 && bobValue >= 1){
                  bobValue++;
              }
              if (bobValue == 6){
                  bobValue = -1;
              }
              if (bobValue > -4 && bobValue <= -1){
                  bobValue--;
              }
              if (bobValue == -4){
                  bobValue = 1;
              } */
              
          }

          if (key =='w'){
              PVector moveTo = new PVector(dirX, position.y, dirZ);
              PVector accel = PVector.sub(moveTo, position);
              accel.setMag(5);

              velocityX.add(accel);
              velocityX.limit(10);

              position.add(velocityX);

          }
          if (key =='s'){
              PVector moveTo = new PVector(dirX, position.y, dirZ);
              PVector accel = PVector.sub(moveTo, position);
              accel.setMag(5);

              velocityX.sub(accel);
              velocityX.limit(10);

              position.add(velocityX);

          }
          if (key =='a'){
            
            
              pushMatrix();
              translate(position.x, position.y, position.z);
              rotateY((mouseX*-0.01)+radians(90));
              translate(100,0,0);
              

              float tempDirX = modelX(0,0,0);
              float tempDirY = modelY(0,0,0);
              float tempDirZ = modelZ(0,0,0);

              popMatrix(); 
              
 
              
              
              //block(tempDirX, tempDirY, tempDirZ, 100);
            

              PVector temp = new PVector(tempDirX, position.y, tempDirZ);
              PVector accel = PVector.sub(temp, position);
              
      
              accel.setMag(-5);

              velocityZ.sub(accel);
              velocityZ.limit(10);
              

              position.add(velocityZ);



          }
          if (key =='d'){
              pushMatrix();
              translate(position.x, position.y, position.z);
              rotateY((mouseX*-0.01)+radians(90));
              translate(100,0,0);
              

              float tempDirX = modelX(0,0,0);
              float tempDirY = modelY(0,0,0);
              float tempDirZ = modelZ(0,0,0);

              popMatrix(); 

              
              block(tempDirX, tempDirY, tempDirZ, 100);
            

              PVector temp = new PVector(tempDirX, position.y, tempDirZ);
              PVector accel = PVector.sub(temp, position);
              
      
              accel.setMag(5);

              velocityZ.sub(accel);
              velocityZ.limit(10);
              

              position.add(velocityZ);

          }
         
      }

      if(bobValue > 0){
          cameraShake(1);
      }
      if(bobValue < 0){
          cameraShake(-1);
      }
      
  }

  void hud(){
    
    hint(DISABLE_DEPTH_TEST);
    camera();
    lights();
    noStroke();
    fill(0);
    square(width/2, height/2, 5);
    //noFill();
    //rect(85, 85, 40, 25);
    fill(255);
    textSize(20);
    text("Hits: " + hitCount, 30, 30);
    text("Misses: " + missCount, 30, 60);
    
    if (hitCount > 0 || missCount > 0){
      text("Accuracy: " + (Math.round(100*(hitCount / (hitCount + missCount)))) + "%", 30, 90);
    }
    
    text("FPS: " + Math.round(frameRate), width - 100, 30);

    if (gameOn){
        text("Time: " + (30 - elapsed), width/2 - 50, 30);
    }

    text("Scores", width - 100, 90);
    text("__________", width - 120, 100);

    for (int i = 0; i < scoreList.size(); i++) {
        Score s = scoreList.get(i);
        text("H: " + (int)s.hits + " A: " + (int)s.accuracy + " %", width - 120, 100 + (1 + i)*30);

        
    }
    
    
    hint(ENABLE_DEPTH_TEST);
    camera(position.x, position.y, position.z, dirX, dirY, dirZ, 0, 1, 0);
      
  }

  void moveTo(float x, float y, float z){
      position = new PVector (x, y, z);
  }

  void faceTowards(float x, float y, float z){
      dirX = x;
      dirY = y;
      dirZ = z;
  }
  
  void cameraShake(float s){
      PVector shake = new PVector(0, s, 0);
      position.add(shake);

  
  }

}