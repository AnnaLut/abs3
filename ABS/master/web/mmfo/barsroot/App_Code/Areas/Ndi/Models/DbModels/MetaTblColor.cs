using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

/// <summary>
/// Summary description for MetaTblColor
/// </summary>
public class MetaTblColor
{
    public MetaTblColor()
    {

    }
    [ScriptIgnore]
    public int TABID { get; set; }
    [ScriptIgnore]
    public int ORD { get; set; }
    [ScriptIgnore]
    public int? COLID { get; set; }
    [ScriptIgnore]
    public string CONDITION { get; set; }
    [ScriptIgnore]
    public short? COLOR_INDEX { get; set; }

    public string COLOR_NAME { get; set; }

    private string colorSemantic;

    public string COLOR_SEMANTIC
    {
        get { return colorSemantic ?? string.Empty; }
        set { colorSemantic = value ?? string.Empty; }
    }


}
