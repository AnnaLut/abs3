using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CP_AMOR_Model
/// </summary>
public class CP_AMOR_Model
{
    public CPAmorItem[] items { get; set; }
    public decimal NGRP { get; set; }
    public DateTime? ADAT { set; get; }

}

public class CPAmorItem
{
    public string REF { get; set; }
    public decimal? ID { get; set; }
}
