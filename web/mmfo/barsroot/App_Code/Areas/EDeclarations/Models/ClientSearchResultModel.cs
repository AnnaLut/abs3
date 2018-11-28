using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ClientSearchResultModel
/// </summary>
public class ClientSearchResultModel
{
    public DateTime DateFrom { get; set; }
    public DateTime DateTo { get; set; }
    public List<ClientViewModel> Clients { get; set; }
}