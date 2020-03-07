import MPoint;
class Maze
{
    public var currentPoint:MPoint;
	private var maze:Array;
	private var r:MovieClip;
    public function setUpMaze()
    {
        var stack:Array= new Array();
        var grid:Array= new Array();
        for(var i:Number=0; i<10; i++)
        {
            grid.push(new Array());
            for(var q:Number=0; q<10; q++)
            {
                grid[i].push(new MPoint());
                grid[i][q].xval=i;
                grid[i][q].yval=q;
            }
        }
        var xval:Number=Math.floor(Math.random()*5)+5;
        var yval:Number=Math.floor(Math.random()*10);
		var startY:Number=yval;
		var startX:Number=xval;
        stack.push(grid[xval][yval]);
        grid[xval][yval].visited=true;
        var options:Array= new Array();
        var temp:MPoint= new MPoint();
        while(stack.length!=0)
        {
            xval=stack[stack.length-1].xval;
            yval=stack[stack.length-1].yval;
            options= new Array();
            for(var i:Number=0; i<4; i++)
            {
                options.push(new MPoint());
                options[i].visited=true;
            }
            if(xval-1>=0)
                options[0]=grid[xval-1][yval];
            if(xval+1<10)
                options[1]=grid[xval+1][yval];
            if(yval-1>=0)
                options[2]=grid[xval][yval-1];
            if(yval+1<10)
                options[3]=grid[xval][yval+1];
            var isOption:Boolean=false;
            for(var i:Number=0; i<4; i++)
            {
                if(options[i].visited==false)
                    isOption=true;
            }
            if(isOption)
            {
                temp= new MPoint();
                temp.visited=true;
                var randomNumber:Number=0;
                while(temp.visited==true)
                {
                    randomNumber=Math.floor((Math.random()*4));
                    temp=options[randomNumber];
                }
                var tempx:Number= options[randomNumber].xval;
                var tempy:Number= options[randomNumber].yval;
                if(randomNumber==0)
                {
                    grid[tempx][tempy].right=grid[xval][yval];
                    grid[xval][yval].left=grid[tempx][tempy];
                    grid[tempx][tempy].visited=true;
                }
                if(randomNumber==1)
                {
                    grid[tempx][tempy].left=grid[xval][yval];
                    grid[xval][yval].right=grid[tempx][tempy];
                    grid[tempx][tempy].visited=true;
                }
                if(randomNumber==2)
                {
                    grid[tempx][tempy].down=grid[xval][yval];
                    grid[xval][yval].up=grid[tempx][tempy];
                    grid[tempx][tempy].visited=true;
                }
                if(randomNumber==3)
                {
                    grid[tempx][tempy].up=grid[xval][yval];
                    grid[xval][yval].down=grid[tempx][tempy];
                    grid[tempx][tempy].visited=true;
                }
                stack.push(grid[tempx][tempy]);
            }
            else
            {
                stack.pop();
            }
        }
		for(var i:Number=0; i<10; i++)
        {
            for(var q:Number=0; q<10; q++)
            {
                grid[i][q].visited=false;
            }
        }
		grid[startX][startY].isGoal=true;
		grid[0][startY].visited=true;
		maze=grid;
        currentPoint=maze[0][startY];
    }
	public function startMaze()
	{
		setUpMaze();
	}
	public function deleteMaze()
	{
		r.removeMovieClip();
	}
	public function drawMaze()
	{
		var grid:Array= maze;
		 _root.HideBackgrounds();
        r = _root.createEmptyMovieClip("rectangles", 2);
        r.beginFill(0x000000, 100);
        r.moveTo(8,6);
        r.lineTo(454,6);
        r.lineTo(454,340);
        r.lineTo(8,340);
        r.endFill();
        r.beginFill(0xFFFFFF,100);
        for(var i:Number=0; i<10; i++)
        {
            for(var q:Number=0; q<10; q++)
            {
				if(maze[i][q].visited || maze[i][q].isGoal)
				{
					if(maze[i][q].isGoal)
					{
						r.beginFill(0xFBEC5D, 100);
					}
					r.moveTo(i*20+13,q*20+13);
					r.lineTo(i*20+27,q*20+13);
					r.lineTo(i*20+27,q*20+27);
					r.lineTo(i*20+13,q*20+27);
					if(grid[i][q].up!=null)
					{
						r.moveTo(i*20+16,q*20+13);
                        r.lineTo(i*20+16,q*20+10);
                        r.lineTo(i*20+24,q*20+10);
                        r.lineTo(i*20+24,q*20+13);
					}
					if(grid[i][q].left!=null)
					{
						r.moveTo(i*20+10,q*20+16);
                        r.lineTo(i*20+10,q*20+24);
                        r.lineTo(i*20+13,q*20+24);
                        r.lineTo(i*20+13,q*20+16);
					}
                    if(grid[i][q].right!=null)
					{
						r.moveTo(i*20+27,q*20+16);
                        r.lineTo(i*20+27,q*20+24);
                        r.lineTo(i*20+30,q*20+24);
                        r.lineTo(i*20+30,q*20+16);
					}
					if(grid[i][q].down!=null)
					{
						r.moveTo(i*20+16,q*20+27);
                        r.lineTo(i*20+16,q*20+30);
                        r.lineTo(i*20+24,q*20+30);
                        r.lineTo(i*20+24,q*20+27);
					}
					if(maze[i][q].isGoal)
					{
						r.beginFill(0xFFFFFF, 100);
					}
				}
            }
        }
        r.endFill();
		r.beginFill(0xFF0000,100);
		i=currentPoint.xval;
		q=currentPoint.yval;
		r.moveTo(i*20+13,q*20+13);
		r.lineTo(i*20+27,q*20+13);
		r.lineTo(i*20+27,q*20+27);
		r.lineTo(i*20+13,q*20+27);
		r.endFill();
	}
	public function isComplete():Boolean
	{
		return currentPoint.isGoal;
	}
}