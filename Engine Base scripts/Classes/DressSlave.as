// A Slave's Dress/Suit of clothing
// Translation status: COMPLETE

import Scripts.Classes.*;

class DressSlave extends Dress {
	
	// Functions
	
	// constructor
	public function DressSlave(sdo:Object) { 
		super(sdo);
	}
	
	// Set the stat effects for the dress, usings interface like Points()
	public function SetDressStats(Charisma:Number, Sensibility:Number, Refinement:Number, Intelligence:Number, Morality:Number, Constitution:Number, Cooking:Number, Cleaning:Number, Conversation:Number, BlowJob:Number, Fuck:Number, Temperament:Number, Nymphomania:Number, Obedience:Number, Lust:Number, Reputation:Number, Joy:Number, Special:Number, Special2:Number)
	{
		delete arDressStats;
		arDressStats = new Array();

		arDressStats.push(Charisma == undefined ? 0 : Charisma);
		arDressStats.push(Sensibility == undefined ? 0 : Sensibility);
		arDressStats.push(Refinement == undefined ? 0 : Refinement);
		arDressStats.push(Intelligence == undefined ? 0 : Intelligence);
		arDressStats.push(Morality == undefined ? 0 : Morality);
		arDressStats.push(Constitution == undefined ? 0 : Constitution);
		arDressStats.push(Cooking == undefined ? 0 : Cooking);
		arDressStats.push(Cleaning == undefined ? 0 : Cleaning);
		arDressStats.push(Conversation == undefined ? 0 : Conversation);
		arDressStats.push(BlowJob == undefined ? 0 : BlowJob);
		arDressStats.push(Fuck == undefined ? 0 : Fuck);
		arDressStats.push(Temperament == undefined ? 0 : Temperament);
		arDressStats.push(Nymphomania == undefined ? 0 : Nymphomania);
		arDressStats.push(Obedience == undefined ? 0 : Obedience);
		arDressStats.push(Lust == undefined ? 0 : Lust);
		arDressStats.push(Reputation == undefined ? 0 : Reputation);
		arDressStats.push(Joy == undefined ? 0 : Joy);
		arDressStats.push(Special == undefined ? 0 : Special);
		arDressStats.push(Special2 == undefined ? 0 : Special2);
		
		bDressLeft = true;
		strDescription = "";
		strDescription = AddDressStatEffect(sd.GetStatName(0), Charisma, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(1), Sensibility, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(2), Refinement, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(3), Intelligence, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(4), Morality, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(5), Constitution, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(6), Cooking, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(7), Cleaning, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(8), Conversation, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(9), BlowJob, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(10), Fuck, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(11), Temperament, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(12), Nymphomania, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(13), Obedience, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(14), Lust, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(15), Reputation, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(16), Joy, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(17), Special, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(18), Special2, strDescription);
	}

}