/***************************************************************\
	ActionScript code to parse mathematical expressions
	using numbers, parentheses, the operators
	+, - *, /, ^, and standard private functions of the Flash
	Math object.
	
	© 2005 Michael Kantor
	You may use and/or adapt this code however you want.  
	Attribution, and a link to flashgizmo.com, is 
	appreciated, but not required.
***************************************************************/
import Scripts.Classes.*;

class ExpressionParser {

	private var i:Number; 
	private var c:String;
	private var strIn:String;
	private var coreGame:Object;
	private var obj:Object;
	
	public function ExpressionParser(cg:Object) { coreGame = cg; }
	
	public function GetExpression(s:String) : Number
	{
		if (s == undefined || s == "") return 0;
		strIn = s.toLowerCase();
		strIn = strIn.substr(-1, 1) == "%" ? strIn.substr(0, strIn.length - 1) : strIn;
		if (s.indexOf("\r") != -1 || s.indexOf("\n") != -1 || s.indexOf("\t") != -1) strIn = strIn.split("\\n").join("\n").split("\\r").join("\r").split("\r\n").join("\r").split("\t").join("");
		if (strIn.indexOf("divide") != -1 || strIn.indexOf("multiply") != -1) strIn = strIn.split("divide").join("/").split("multiply").join("*");
		i = 0;
		c = strIn.charAt(i);
		return getExpression();
	}
	
	private function getExpression() : Number
	{
		// inlinedeatWhiteSpace();
		while (c == ' ') c = strIn.charAt(++i);
		if (c == '') return 0;
		var v:Number = getTerm();
		while ('x+-'.indexOf(c) > 0) {
			if (c == '+') {
				// inlined next();
				c = strIn.charAt(++i);
				v += getTerm();
			}
			if (c == '-') {
				// inlined next();
				c = strIn.charAt(++i);
				v -= getTerm();			
			}
			// inlined eatWhiteSpace();
			while (c == ' ') c = strIn.charAt(++i);
		}
		return v;
	}
	
	private function getTerm() : Number
	{
		var v:Number = getSubTerm();
		// inlined eatWhiteSpace();
		while (c == ' ') c = strIn.charAt(++i);
		while ('x*/'.indexOf(c) > 0) {
			if (c == '*') {
				// inlined next();
				c = strIn.charAt(++i);
				v *= getSubTerm();		
			}
			if (c == '/') {
				// inlined next();
				c = strIn.charAt(++i);
				v /= getSubTerm();	
			}
			// inlined eatWhiteSpace();
			while (c == ' ') c = strIn.charAt(++i);
		}
		return v;
	}
	
	
	private function getSubTerm() : Number
	{
		var v:Number;
		v = getAtom();
		// inlined eatWhiteSpace();
		while (c == ' ') c = strIn.charAt(++i);
		if (c == '^') {	
			// inlined next();
			c = strIn.charAt(++i);
			// this recursion treats ^ as right-associative
			v = Math.pow(v, getSubTerm());	
		}
		return v;
	}
	
	private function getAtom() : Number
	{
		var v:Number;
		// inlined eatWhiteSpace();
		while (c == ' ') c = strIn.charAt(++i);
		if (c == '-') {
			// inlined next();
			c = strIn.charAt(++i);
			v = getSubTerm();
			return(-1 * v);
		}
		if (c == '(') {
			// inlined next();
			c = strIn.charAt(++i);
			v = getExpression();
			match(')');
			return v;
		}
		if (' 0123456789abcdefghijklmnopqrstuvwxyz'.indexOf(c) > 10) {
			v = getexpfunctionName();
			if (v != undefined) return v;
			return 0;
		}
		var s:String = '';
		if ('x+-'.indexOf(c) > 0) {
			s += c;
			match(c);
		}
		while ('x0123456789.'.indexOf(c) > 0) {	// isNumChar matches digits and decimal point
			s += c;
			// inlined next();
			c = strIn.charAt(++i);
		}
		if (isNaN(Number(s))) {
			coreGame.SMTRACE("Error : '" + s + "' is not a number.");
			return 0;
		}
		return Number(s);
	}
	
	private function getexpfunctionName() : Number
	{
		var sa:String = '';
		var v:Number;
		while (' 0123456789abcdefghijklmnopqrstuvwxyz'.indexOf(c) > 10) {
			sa += c;
			// inlined next();
			c = strIn.charAt(++i);
		}
		var s:String = sa;
		while (' 0123456789abcdefghijklmnopqrstuvwxyz_'.indexOf(c) > 0) {
			s += c;
			// inlined next();
			c = strIn.charAt(++i);
		}

		if (s == "int") {
			match('(');
			v = getExpression();
			match(')');
			return int(v);
		}
		if (s == "minus") {
			match('(');
			v = getExpression();
			match(')');
			return -1 * v;
		}
		if (s == "true") return 1;
		if (s == "false") return 0;
		
		if (s.substr(0, 6) == "random") {
			v = Number(s.substr(6));
			if (v == 0) return Math.random();
			return int(Math.random() * v) + 1;
		}
		
		obj = coreGame.GetStSk(s);
		if (obj != undefined) {
			if (isNaN(obj)) return 0;
			return Number(obj);
		}

		// a constant number
		if (!isNaN(Math[s.toUpperCase()])) return(Math[s.toUpperCase()]);
						   
		if (Math[s] instanceof Function) { // a static function of Math
			// otherwise, it's a private function
			match('(');
			v = getExpression();
			match(')');
			return Math[s](v);
		}
		return 0;
	}
	
	private function match(cc:String) {
		if (strIn.charAt(i) == cc) c = strIn.charAt(++i);
	}
	
	/*
	// all the following are wholly inlined
	
	private function next() { c = strIn.charAt(++i); }

	private function eatWhiteSpace() {
		while (c == ' ') c = strIn.charAt(++i);
	}
	private function isAlpha(c:String) : Boolean {
		return (' 0123456789abcdefghijklmnopqrstuvwxyz'.indexOf(c) > 10);
	}
	
	private function isNumChar(c:String) : Boolean {
		return ('x0123456789.'.indexOf(c) > 0);
	}
	
	private function isAlphaNumeric(c:String) : Boolean {
		return (' 0123456789abcdefghijklmnopqrstuvwxyz_'.indexOf(c) > 0);
	}
	*/
}
