using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Admin.Models
{
    public class SecAudit
    {
        public int REC_ID { get; set; }

        public string REC_TYPE { get; set; }

        public DateTime REC_DATE { get; set; }

        public DateTime REC_BDATE { get; set; }

        public string REC_MESSAGE { get; set; }

        public string REC_UNAME { get; set; }

        public string MACHINE { get; set; }

        public string REC_UPROXY { get; set; }

        public string REC_MODULE { get; set; }

        public string REC_OBJECT { get; set; }

        public string BRANCH { get; set; }


    }
}