//helper function that will generate the character sprites for NPC and player
public PImage[] createCharacterSprites(int playerNum){
  int i = 0;
  PImage[] characterSprites = new PImage[12];
  //locate which row in the tilemapguide the player starts at
  int row = 0 + playerNum*3;
  //locate which tile num col in the tilemapguide the player starts at
  int tilenum = (27*(row+1))-4;
  //for loop that will go through each column
  for(int c = tilenum; c<tilenum+4; c++){
    for(int r = 0; r< 3;r++){
      characterSprites[i] = tiles[c + (r*27)];
      i++;
    }
  }
  return characterSprites;
}

enum PlayerMovementStates{
  UP,
  DOWN,
  LEFT,
  RIGHT,
  SUDDENSTOP,
  STATIC
}

//player class
class Player{
  
  PlayerMovementStates direction = PlayerMovementStates.STATIC;
  

  PImage[] sprites; //character sprites
  //private Timer keyTimer = new Timer(40);
  SpriteSheet animations;
  final int h = 16;
  final int w = 16;
  int steps = 0; //steps taken during gameplay
  int x = 400;
  int y = 400;
  final int scale = 2;

  
  ArrayList<Items> items = new ArrayList<Items>();
  ArrayList<Monster> monsters = new ArrayList<Monster>();
  
  public Player(PImage[] sprites){
    this.sprites = sprites; 
    animations = new SpriteSheet(this.sprites, 167);
  }
  
  //i am sorry about this  monstrosity but i needed to iterate with letters
  //each string should be the name of a monster)
  public void addMonsters(String a, String aa, String aaa, String aaaa, String aaaaa) {
    String[] parameters = {a, aa, aaa, aaaa, aaaaa};
    for (int i = 0; i < 5; i++) {
      Monster m = new Monster(parameters[i]);
      monsters.add(m);
      println(m.id);
    }
  }
  
  public void display(){
    //image(sprites[0], 400,400, h * scale, w * scale);
    
    if(keyPressed == true){
      if (key == 'w') {
        direction= PlayerMovementStates.UP;
      } else if (key == 's') {
        direction= PlayerMovementStates.DOWN;
      } else if (key == 'a') {
        direction= PlayerMovementStates.LEFT;
      } else if (key == 'd') {
        direction= PlayerMovementStates.RIGHT;
      }
    }
    
    if(animations.stoploop){
      animations.softReset();
      //keyTimer.refresh();
      direction = PlayerMovementStates.STATIC;
    }
    
    switch(direction){
      case UP:
        animations.checkCase(6);
        moveUp();
        break;
      case DOWN:
        animations.checkCase(3);
        moveDown();
        break;
      case LEFT:
        animations.checkCase(0);
        moveLeft();
        break;
      case RIGHT:
        animations.checkCase(9);
        moveRight();
        break;
      default:
        if(animations.animationTimer.countDownOnce()){
          animations.increment = animations.loopstart;
        }
        animations.display(400,400);
        break;
    }
    
   
    


  }
  
  
  
  //player needs key pressed to trigger animations
  //this function is used in the switch statement depending on which direction the player is facing in
  //when this function runs the player needs to player the walking up animation
  void moveUp(){
      if(animations.animationTimer.countDownUntil(animations.stoploop)){
        animations.changeDisplay(6,8);
      }
      animations.display(400,400);
      
      if(keyPressed == false && animations.increment > 6){
        animations.softReset();
        direction = PlayerMovementStates.STATIC;
      }
  }
  
  void moveDown(){
      if(animations.animationTimer.countDownUntil(animations.stoploop)){
        animations.changeDisplay(3,5);
      }
      animations.display(400,400);
      

      if(keyPressed == false && animations.increment > 3){
        animations.softReset();
        direction = PlayerMovementStates.STATIC;
      }
  }
  
  void moveLeft(){  
      if(animations.animationTimer.countDownUntil(animations.stoploop)){
        animations.changeDisplay(0,2);
      }
      animations.display(400,400);
      

      if(keyPressed == false && animations.increment > 0){
        animations.softReset();
        direction = PlayerMovementStates.STATIC;
      }
  }
  
  void moveRight(){
      if(animations.animationTimer.countDownUntil(animations.stoploop)){
        animations.changeDisplay(9,11);
      }
      animations.display(400,400);
      
      if(keyPressed == false && animations.increment > 9){
        animations.softReset();
        direction = PlayerMovementStates.STATIC;
      }
  }
  
  
}
