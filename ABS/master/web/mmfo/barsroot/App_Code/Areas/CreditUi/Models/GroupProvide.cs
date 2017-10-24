using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for GroupProvide
/// </summary>
namespace BarsWeb.Areas.CreditUi.Models
{
    public class GroupProvide
    {
        public decimal Change { get; set; }

        public List<decimal> accs { get; set; }
    }
}