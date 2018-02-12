using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.SWCompare.Models
{
    public class SWCTiketModel
    {
        public decimal ID { get; set; }
        public string KOD_NBU { get; set; }
        public DateTime DDATE { get; set; }
        public decimal USERID { get; set; }
        public string FIO { get; set; }
        public decimal? REF { get; set; }
        public string FIO_REF { get; set; }
        public decimal? PRN_FILE_OWN { get; set; }
        public decimal? PRN_FILE_IMPORT { get; set; }
        public string SOS_NAME { get; set; }
        public string COMMENTS { get; set; }
    }
}
