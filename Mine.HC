//Minesweeper for TempleOS

//Sprites removed for GitHub



U64 sprites[]	 = {<1>,<2>,<3>,<4>,<5>,
		    <7>,<8>,<9>,<10>,<11>,<12>,<6>};



I64 height=9;
I64 width=9;
I64 nrMines2=10;
Bool PlayAgain=TRUE;



switch(PopUpPickLst("Easy\0Medium\0Hard")){
	case:	height=9;width=9;nrMines2=10;	break;
	case:	height=width=16;nrMines2=40;	break;
	case:	height=16;width=30;nrMines2=99;	break;
	default:PlayAgain=FALSE;		break;
}




I64 tileSize=(width*height);



//Board visible to player
I64 smallBV[tileSize];

//Hidden Board
I64 smallBoard[tileSize];



I64 arg1;
I64 arg2;
I64 f;
I64 nrMines=nrMines2;

Bool GameOver=FALSE;
Bool Loss=FALSE;




Bool notU(I64 x){
if(smallBV[x]==sprites[0])
	return TRUE;
else
	return FALSE;
}

U0 IsOver(){
Bool Over = TRUE;
for(f=0;f<tileSize;f++){
  if(smallBoard[f]!=-1&&notU(f))
    Over=FALSE;
}
for(f=0;f<tileSize;f++){
  if(smallBV[f]==sprites[5]){
    Over=Loss=TRUE;}
}
GameOver=Over;
}

U0 setBoard(I64 s=0,Bool First=FALSE,Bool Last=FALSE,Bool All=FALSE){
if(All){
for(f=0;f<tileSize;f++){
switch(smallBoard[f]){
	case 1:
		smallBV[f]=sprites[1];break;
	case 2:
		smallBV[f]=sprites[6];break;
	case 3:
		smallBV[f]=sprites[2];break;
	case 4:
		smallBV[f]=sprites[7];break;
	case 5:
		smallBV[f]=sprites[3];break;
	case 6:
		smallBV[f]=sprites[8];break;
	case 7:
		smallBV[f]=sprites[4];break;
	case 8:
		smallBV[f]=sprites[9];break;
	case -1:
		smallBV[f]=sprites[5];break;
	default:
		smallBV[f]=sprites[10];break;
}
}
}
else{
  if(smallBoard[s]!=-1){
    switch(smallBoard[s]){
	case 1:
		smallBV[s]=sprites[1];break;
	case 2:
		smallBV[s]=sprites[6];break;
	case 3:
		smallBV[s]=sprites[2];break;
	case 4:
		smallBV[s]=sprites[7];break;
	case 5:
		smallBV[s]=sprites[3];break;
	case 6:
		smallBV[s]=sprites[8];break;
	case 7:
		smallBV[s]=sprites[4];break;
	case 8:
		smallBV[s]=sprites[9];break;
	case -1:
		smallBV[s]=sprites[5];break;
	default:
		smallBV[s]=sprites[10];break;

    }
if(!Last){
  if(s>=width+1 && s%width!=0 && notU(s-(width+1)) && smallBoard[s-(width+1)]!=-1)
   setBoard(s-(width+1),,smallBoard[s-(width+1)]>0);

  if(s>=width  && notU(s-width) && smallBoard[s-width] !=-1)
   setBoard(s-width,,smallBoard[s-width]>0);

  if(s>=width-1  && s%width!=width-1 && notU(s-(width-1)) && smallBoard[s-(width-1)] !=-1)
   setBoard(s-(width-1),,smallBoard[s-(width-1)]>0);

  if(s<=tileSize-(width) && s%width!=0 && notU(s+(width-1)) && smallBoard[s+width-1] !=-1)
   setBoard(s+width-1,,smallBoard[s+width-1]>0);

  if(s<=tileSize-(width+1) && notU(s+width) && smallBoard[s+width] !=-1)
   setBoard(s+width,,smallBoard[s+width]>0);

  if(s<=tileSize-(width+2) && s%width!=width-1 && notU(s+width+1) && smallBoard[s+width+1]!=-1)
   setBoard(s+width+1,,smallBoard[s+width+1]>0);

  if(notU(s-1) && s%width!=0 && smallBoard[s-1] !=-1)
   setBoard(s-1,,smallBoard[s-1]>0);

  if(notU(s+1) && s%width!=width-1 && smallBoard[s+1] !=-1)
   setBoard(s+1,,smallBoard[s+1]>0);

  }
}
  else if(First){
	GameOver=TRUE;
	smallBV[s]=sprites[5];
  }
}
}



I64 makeSurr(I64 s){
I64 nr=0;
  if(s>=width+1 && s%width!=0 && smallBoard[s-(width+1)]==-1)
   nr++;

  if(s>=width  && smallBoard[s-width]==-1)
   nr++;

  if(s>=width-1  && s%width!=width-1 && smallBoard[s-(width-1)]==-1)
   nr++;

  if(s<=tileSize-width && s%width!=0 && smallBoard[s+width-1]==-1)
   nr++;

  if(s<=tileSize-(width+1) && smallBoard[s+width]==-1)
   nr++;

  if(s<=tileSize-(width+2) && s%width!=width-1 && smallBoard[s+width+1]==-1)
   nr++;

  if(s%width!=0 && smallBoard[s-1]==-1)
   nr++;

  if(s%width!=width-1 && smallBoard[s+1]==-1)
   nr++;

 return nr;
}


U0 GenerateBoard(){
//Place mines
I64 rn;
while(nrMines>0){
  rn=RandU16%tileSize;
  if(rn<tileSize){
    smallBoard[rn]=-1;
    nrMines--;
    //"%d\n",rn;
  }
}
//Generate numbers
for(f=0;f<tileSize;f++){
  if(smallBoard[f]!=-1)
    smallBoard[f]=makeSurr(f);
}

//Fill SmallBV
for(rn=0;rn<tileSize;rn++){
  smallBV[rn]=sprites[0];
}
}

U0 DrawIt(CTask *, CDC *dc){
I64 x, y;
x=100;
y=50;

dc->color=DKGRAY;
GrFloodFill(dc,0,0);
dc->color=WHITE;
GrPrint(dc,25+width*6,25,"Press ESC to quit");

dc->color=BLACK;

for(f=0;f<tileSize;f++){
  Sprite3(dc,x,y,0,smallBV[f]);
  x = (x+12);
  if(x-100==12*width){
    x=100;
    y+=12;
  }
  
}
}

U0 GetInput(){
Bool input=TRUE;
I64 ch;
  while (input) {
      switch (ScanMsg(&arg1,&arg2,1<<MSG_MS_L_DOWN+1<<MSG_KEY_DOWN+
			1<<MSG_MS_R_DOWN)) {
	case 0:
	  Refresh;
	  break;
	case MSG_MS_L_DOWN:
		if(108<=arg1<=(width*12+108) && 54<=arg2<=(height*12+54)){
		  //"%d\t",arg1;
		  //"%d\t",arg2;
		  ch=(arg1-108)/12 + width*((arg2-54)/12);
		  //"%d\n",ch;
		  if(smallBV[ch]==sprites[0]){
			input=FALSE;
			setBoard(ch,TRUE);
		  }
		  //if(smallBoard[ch]==-1){GameOver=TRUE;}
		}
	  break;
	case MSG_MS_R_DOWN:
		if(108<=arg1<=(width*12+108) && 54<=arg2<=(height*12+54)){
			  //"%d\t",arg1;
		  //"%d\t",arg2;
		  ch=(arg1-108)/12 + width*((arg2-54)/12);
		  //"%d\n",ch;
		if(smallBV[ch]==sprites[11])
		   smallBV[ch]=sprites[0];
		else if(smallBV[ch]==sprites[0])
		   smallBV[ch]=sprites[11];
		}
	case MSG_KEY_DOWN:
		if(arg1==CH_ESC){
		  setBoard(,,,TRUE);
		  input=FALSE;GameOver=TRUE;
		}
	  break;
	}
  }


}

U0 ResetBoard(){
  GameOver=FALSE;
  Loss=FALSE;
  nrMines=nrMines2;
  for(f=0;f<tileSize;f++){
    smallBoard[f]=0;
    smallBV[f]=0;
  }

}

U0 Main(){
  SettingsPush;
  AutoComplete;
  DocClear;
  WinMax;
  WinBorder;
  DocCursor;
  Fs->draw_it=&DrawIt;
while(PlayAgain){
  ResetBoard;
  GenerateBoard;
  while(!GameOver){
    GetInput;
    IsOver;
  }
  if(Loss){
    setBoard(,,,TRUE);
    Beep;
    PopUpOk("You Lost!");
  }
  else
    PopUpOk("You Won!");

  if(!PopUpNoYes("Play Again?"))
    PlayAgain=FALSE;

}
SettingsPop;
}
if(PlayAgain)
Main;