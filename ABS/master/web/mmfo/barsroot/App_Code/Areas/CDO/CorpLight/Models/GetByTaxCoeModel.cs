using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for GetByTaxCoeModel
/// </summary>
public class GetByTaxCoeModel
{
    public GetByTaxCoeModel()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public decimal CustId { get; set; }
    public string TaxCode { get; set; }
    public string DocSeries { get; set; }
    public string DocNumber { get; set; }
}