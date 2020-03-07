class Slave extends Object
{
    var SlaveType, CanAssist, Available, SlaveIndex, SlaveName, SlaveGender, Endings, Ending, LastEnding, SlaveImage;
    function Slave(sname, gnd)
    {
        super();
        SlaveType = 0;
        CanAssist = false;
        Available = true;
        SlaveIndex = -1;
        _root.ResetCommonSlaveDetails(this);
        _root.ResetCommonSlaveMakerDetails(this);
        SlaveName = sname == undefined ? ("") : (sname);
        SlaveGender = gnd == undefined ? (2) : (gnd);
        Endings = new Array();
        for (var _loc4 = 0; _loc4 < 100; ++_loc4)
        {
            Ending.push(0);
        } // end of for
        LastEnding = -10;
        SlaveImage = "";
    } // End of the function
    function Load(slaveg)
    {
        SlaveType = slaveg.SlaveType;
        CanAssist = slaveg.CanAssist;
        SlaveIndex = slaveg.SlaveIndex;
        LastEnding = slaveg.LastEnding;
        SlaveImage = slaveg.SlaveImage;
        SlaveName = slaveg.SlaveName;
        SlaveGender = slaveg.SlaveGender;
        for (var _loc3 = 0; _loc3 < slaveg.Endings.length; ++_loc3)
        {
            Endings[_loc3] = slaveg.Endings[_loc3];
        } // end of for
        _root.LoadCommonSlaveDetails(slaveg, this);
        if (slaveg.sSlaveTrainer != undefined)
        {
            _root.LoadCommonSlaveMakerDetails(slaveg, this);
        } // end if
    } // End of the function
    function Save(slaveg)
    {
        slaveg.SlaveType = SlaveType;
        slaveg.CanAssist = CanAssist;
        slaveg.SlaveIndex = SlaveIndex;
        slaveg.LastEnding = LastEnding;
        slaveg.SlaveImage = SlaveImage;
        slaveg.SlaveName = SlaveName;
        slaveg.SlaveGender = SlaveGender;
        slaveg.Endings = new Array();
        for (var _loc3 = 0; _loc3 < Endings.length; ++_loc3)
        {
            slaveg.Endings[_loc3].push(Endings[_loc3]);
        } // end of for
        _root.SaveCommonSlaveDetails(slaveg, this);
        _root.SaveCommonSlaveMakerDetails(slaveg, this);
    } // End of the function
    function CheckBitFlag1(flag)
    {
        return (_root.CheckBitFlag1(flag, this));
    } // End of the function
    function SetBitFlag1(flag)
    {
        _root.SetBitFlag1(flag, this);
    } // End of the function
    function ClearBitFlag1(flag)
    {
        _root.ClearBitFlag1(flag, this);
    } // End of the function
    function CheckAndSetBitFlag1(flag)
    {
        return (_root.CheckAndSetBitFlag1(flag, this));
    } // End of the function
    function CheckBitFlag2(flag)
    {
        return (_root.CheckBitFlag2(flag, this));
    } // End of the function
    function SetBitFlag2(flag)
    {
        _root.SetBitFlag2(flag, this);
    } // End of the function
    function ClearBitFlag2(flag)
    {
        _root.ClearBitFlag2(flag, this);
    } // End of the function
    function CheckAndSetBitFlag2(flag)
    {
        return (_root.CheckAndSetBitFlag2(flag, this));
    } // End of the function
    function SetGirlsVitals(sname, desc, bust, waist, hips, age, bloodtype, tall, weight, clitcock)
    {
        _root.SetGirlsVitals(sname, desc, bust, waist, hips, age, bloodtype, tall, weight, clitcock, this);
    } // End of the function
    function SetBustSize(bust)
    {
        _root.SetBustSize(bust, this);
    } // End of the function
    function AlterSexuality(sex)
    {
        _root.AlterSexuality(sex, this);
    } // End of the function
    function SetSexuality(newsexuality)
    {
        _root.SetSexuality(newsexuality, this);
    } // End of the function
} // End of Class
