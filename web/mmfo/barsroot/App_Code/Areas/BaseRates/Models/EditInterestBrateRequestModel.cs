using BarsWeb.Areas.BaseRates.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for EditInterestBrateRequestModel
/// </summary>
namespace BarsWeb.Areas.BaseRates.Models
{
    public class EditInterestBrateRequestModel
    {
        public EditInterestBrateRequestModel()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public List<UpdatedRowInterestData> InterestList { get; set; }
        public decimal br_id { get; set; }
    }
}