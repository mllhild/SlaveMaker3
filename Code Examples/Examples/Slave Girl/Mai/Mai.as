// Translation status: COMPLETE

import Scripts.Classes.*;

class Mai extends GenericSlave
{
	
	// static function to create the class instance
	public static function main(swfRoot:MovieClip, slave:Object, core:Object) : SlaveModule 
	{
		// entry point
		var sm:SlaveModule = new Mai(swfRoot, slave, core);
		return sm;
	}
	
	// constructor, initialises private variables
	public function Mai(mc:MovieClip, slave:Object, core:Object)
	{
		super(mc, slave, core);
	}
		
		
	// override any specific event/handlers as needed
	// defauly/standard for xml slaves is handled in the class GenericSlave ang its inherited class GenericSlaveImages
	// including showing dress, naked images, initialisation/setup etc

}