using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ClientViewModel
/// </summary>
public class ClientViewModel
{
    public decimal Rnk { get; set; }
    public string Nmk { get; set; }
    public string Okpo { get; set; }
    public DateTime? Bday { get; set; }
    public Int32 docTypeId { get; set; }
    public string docType { get; set; }
    public string Ser { get; set; }
    public string Numdoc { get; set; }
}