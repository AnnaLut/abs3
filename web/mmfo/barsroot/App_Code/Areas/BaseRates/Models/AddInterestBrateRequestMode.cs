using System.Collections.Generic;
using BarsWeb.Areas.BaseRates.Models;

/// <summary>
/// Summary description for AddInterestBrateRequestModel
/// </summary>
namespace BarsWeb.Areas.BaseRates.Models
{
    public class AddInterestBrateRequestMode
    {
        public AddInterestBrateRequestMode()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public List<TbBrates> InterestList { get; set; }
        public decimal br_id { get; set; }
    }
}