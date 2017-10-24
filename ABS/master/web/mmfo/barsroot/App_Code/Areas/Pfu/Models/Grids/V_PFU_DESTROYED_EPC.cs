using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for V_PFU_DESTROYED_EPC
/// </summary>
public class V_PFU_DESTROYED_EPC
{
    public string NAME_PENSIONER { get; set; }
    public string TAX_REGISTRATION_NUMBER { get; set; }
    public string NLS { get; set; }
    public string EPP_NUMBER { get; set; }
    public DateTime? EPP_EXPIRY_DATE { get; set; }
    public DateTime? KILL_DATE { get; set; }
    public int? KILL_TYPE { get; set; }
}
