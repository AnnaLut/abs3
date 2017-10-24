using System;
using System.Collections.Generic;

using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

using BarsWeb.Areas.Clients.Models.Enums;

namespace BarsWeb.Areas.Clients.Models
{
    public class CustomFilter
    {
        public CustomerType Type { get; set; }
        public bool ShowClosed { get; set; }
        public int? SystemFilterId { get; set; }
        public int? UserFilterId { get; set; }
        public string WhereClause { get; set; }
    }
}
