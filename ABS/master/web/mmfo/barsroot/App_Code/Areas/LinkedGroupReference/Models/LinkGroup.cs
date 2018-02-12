using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.LinkedGroupReference.Models
{
    public class LinkGroup
    {
        // Group number
        public decimal? Link_Group { get; set; }

        //should be evaluated during filling of the table, Назва контрагента
        public string Link_Code { get; set; }

        //conditional group name
        public string GroupName { get; set; }

        //ЄДРПУО код
        public string OKPO { get; set; }

        //RNK
        public string RNK { get; set; }

        // MFO
        public string KF { get; set; }


    }
}