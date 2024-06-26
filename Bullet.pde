class Bullet {

    PVector bulVel;
    PVector bulPos;
    float xPos;
    float yPos;
    float zPos;
    
    public Bullet(){
        bulVel = new PVector(0,0,0);
        bulPos = new PVector (newCam.position.x, newCam.position.y, newCam.position.z);
        //xPos = pos.x;
        //yPos = pos.y;
        //zPos = pos.z;
    }

    public void setVel(PVector vel){
        bulVel = vel;
        
    }

    public void move(){
        //sphere not needed
        /*
        pushMatrix();
        noStroke();
        fill(0);
        translate(bulPos.x, bulPos.y, bulPos.z);
        sphere(1);
        popMatrix(); */
        bulPos.add(bulVel);

    }

    public boolean checkCollision(Target t){
        PVector targetPos = t.position;
        PVector distance = PVector.sub(bulPos, targetPos);
        if (distance.mag() <= 25){
            return true;
        }
       
        return false;
    }
    
}