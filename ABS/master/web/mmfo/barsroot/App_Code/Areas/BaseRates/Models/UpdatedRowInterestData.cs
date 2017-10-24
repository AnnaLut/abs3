using BarsWeb.Areas.BaseRates.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for UpdatedRowInterestData
/// </summary>
namespace BarsWeb.Areas.BaseRates.Models
{
    public class UpdatedRowInterestData
    {
        public TbBrates NewRowInterestData { get; set; }
        public TbBrates OldRowInterestData { get; set; }

    }
}