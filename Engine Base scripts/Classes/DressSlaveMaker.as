// A Slave Maker's Dress/Suit of clothing
// Translation status: COMPLETE

import Scripts.Classes.*;

class DressSlaveMaker extends Dress {
	
	// Functions
	
	// constructor
	public function DressSlaveMaker(sdo:Object) { 
		super(sdo);
	}
	
	// Set the stat effects for the dress, usings interface like SMPoints()
	public function SetDressStats(attack:Number, defence:Number, arousaldef:Number, constitution:Number, conversation:Number, lust:Number, corrupt:Number, renown:Number, dominance:Number, charisma:Number, refinement:Number, nymphomania:Number, sexualenergy:Number)
	{
		delete arDressStats;
		arDressStats = new Array();

		arDressStats.push(attack == undefined ? 0 : attack);
		arDressStats.push(defence == undefined ? 0 : defence);
		arDressStats.push(arousaldef == undefined ? 0 : arousaldef);
		arDressStats.push(constitution == undefined ? 0 : constitution);
		arDressStats.push(conversation == undefined ? 0 : conversation);
		arDressStats.push(lust == undefined ? 0 : lust);
		arDressStats.push(corrupt == undefined ? 0 : corrupt);
		arDressStats.push(renown == undefined ? 0 : renown);
		arDressStats.push(dominance == undefined ? 0 : dominance);
		arDressStats.push(charisma == undefined ? 0 : charisma);
		arDressStats.push(refinement == undefined ? 0 : refinement);
		arDressStats.push(nymphomania == undefined ? 0 : nymphomania);
		arDressStats.push(sexualenergy == undefined ? 0 : sexualenergy);
		
		bDressLeft = true;
		strDescription = "";
		strDescription = AddDressStatEffect(sd.GetStatName(0), attack, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(1), defence, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(2), arousaldef, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(3), constitution, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(4), conversation, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(5), lust, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(6), corrupt, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(7), renown, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(8), dominance, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(9), charisma, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(10), refinement, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(11), nymphomania, strDescription);
		strDescription = AddDressStatEffect(sd.GetStatName(13), sexualenergy, strDescription);
	}
}