class Target{

    PVector position;
    float xPos;
    float yPos;
    float zPos;
    

    public Target(){

        xPos = (float)(Math.random()*500)+250;
        yPos = (float)(Math.random()*200)+100;
        zPos = 150;
        position = new PVector(xPos, yPos, zPos);
        
    }

    public void draw(){
        noStroke();
        pushMatrix();
        translate(xPos, yPos, zPos);
        fill(255, 49, 49);
        sphere(25);
        popMatrix();
    }
    
    public void changeLocation(){
      
        xPos = (float)(Math.random()*500)+250;
        yPos = (float)(Math.random()*200)+100;
        position = new PVector(xPos, yPos, zPos);
      
    
    
    
    }



}