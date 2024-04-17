import de.bezier.guido.*;
public int NUM_ROWS = 20; 
public int NUM_COLS = 20;
public int NUM_MINES = 10;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    mines = new ArrayList <MSButton>();
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int i = 0; i < NUM_ROWS; i++){
      for(int n = 0; n < NUM_COLS; n++){
        buttons[i][n] = new MSButton(i,n);
      }
    }
    
    setMines();
}
public void setMines()
{
   while(mines.size() < NUM_MINES){
    int rRow = (int)(Math.random()*NUM_ROWS);
    int rCol = (int)(Math.random()*NUM_COLS);
    
    if(!mines.contains(buttons[rRow][rCol])){
      mines.add(buttons[rRow][rCol]);
    }
  }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    for(int i = 0; i < NUM_ROWS; i++){
        for(int n = 0; n < NUM_COLS; n++){
            if(!buttons[i][n].isClicked()==true&&!mines.contains(buttons[i][n])){
                return false;
            }
        }
    }
    return true;
}

public void displayLosingMessage()
{
    for(int i = 0; i < NUM_ROWS; i++){
        for(int n = 0; n < NUM_COLS; n++){
            if(!buttons[i][n].isClicked() && mines.contains(buttons[i][n])){
                buttons[i][n].flagged = false;
                buttons[i][n].clicked = true;
                    buttons[10][6].setLabel("Y");
                    buttons[10][7].setLabel("O");
                    buttons[10][8].setLabel("U");
                    buttons[10][10].setLabel("L");
                    buttons[10][11].setLabel("O");
                    buttons[10][12].setLabel("S");
                    buttons[10][13].setLabel("E");
            }
        }
    }
}
public void displayWinningMessage()
{
  buttons[10][6].setLabel("Y");
  buttons[10][7].setLabel("O");
  buttons[10][8].setLabel("U");
  buttons[10][10].setLabel("W");
  buttons[10][11].setLabel("I");
  buttons[10][12].setLabel("N");
  
}
public boolean isValid(int r, int c)
{
  if(r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS){
    return true;
  }else{
    return false;
  }
}
public int countMines(int row, int col)
{
    int count = 0;
    if(isValid(row+1, col) && mines.contains(buttons[row+1][col])){
            count++;
        }
        if(isValid(row-1, col) && mines.contains(buttons[row-1][col])){
            count++;
        }
        if(isValid(row, col-1) && mines.contains(buttons[row][col-1])){
            count++;
        }
        if(isValid(row, col+1) && mines.contains(buttons[row][col+1])){
            count++;
        }
        if(isValid(row-1, col-1) && mines.contains(buttons[row-1][col-1])){
            count++;
        }
        if(isValid(row+1, col-1) && mines.contains(buttons[row+1][col-1])){
            count++;
        }
        if(isValid(row+1, col+1) && mines.contains(buttons[row+1][col+1])){
            count++;
        }
        if(isValid(row-1, col+1) && mines.contains(buttons[row-1][col+1])){
            count++;
        }
    
    
    
    
    return count;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton == RIGHT){
           if(flagged == true){
             flagged = false;
             clicked = false;
           }else if(flagged == false){
             flagged = true;
           }
        }else if(mines.contains(this)){
          displayLosingMessage();
        }else if(countMines(myRow, myCol) > 0){
          myLabel += countMines(myRow, myCol);
        }else{
          if(isValid(myRow, myCol-1) && !buttons[myRow][myCol-1].isClicked())
            buttons[myRow][myCol-1].mousePressed();
          if(isValid(myRow, myCol+1) && !buttons[myRow][myCol+1].isClicked())
            buttons[myRow][myCol+1].mousePressed();
          if(isValid(myRow-1, myCol) && !buttons[myRow-1][myCol].isClicked())
            buttons[myRow-1][myCol].mousePressed();
          if(isValid(myRow+1, myCol) && !buttons[myRow+1][myCol].isClicked())
            buttons[myRow+1][myCol].mousePressed();
          if(isValid(myRow-1, myCol-1) && !buttons[myRow-1][myCol-1].isClicked())
            buttons[myRow-1][myCol-1].mousePressed();
          if(isValid(myRow+1, myCol+1) && !buttons[myRow+1][myCol+1].isClicked())
            buttons[myRow+1][myCol+1].mousePressed();
          if(isValid(myRow-1, myCol+1) && !buttons[myRow-1][myCol+1].isClicked())
            buttons[myRow-1][myCol+1].mousePressed();
          if(isValid(myRow+1, myCol-1) && !buttons[myRow+1][myCol-1].isClicked())
            buttons[myRow+1][myCol-1].mousePressed();
        }
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
    public boolean isClicked(){
      return clicked;
    }
}
