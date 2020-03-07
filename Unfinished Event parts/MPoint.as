class MPoint
{
	public var visited:Boolean;
	public var left:MPoint;
	public var right:MPoint;
	public var up:MPoint;
	public var down:MPoint;
	public var xval:Number;
	public var yval:Number;
	public var isGoal:Boolean;
	public function MPoint()
	{
		isGoal=false;
		visited=false;
		left=null;
		right=null;
		up=null;
		down=null;
		xval=null;
		yval=null;
	}
}