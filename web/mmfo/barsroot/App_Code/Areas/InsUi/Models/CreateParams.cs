using System;

namespace BarsWeb.Areas.InsUi.Models
{
    public class CreateParams
    {
        public decimal? ID { get; set; }
        public string KF { get; set; }
        public string NB { get; set; }
        public string URLAPI { get; set; }
        public string USERNAME { get; set; }
        public string HPASSWORD { get; set; }
        public bool IS_ACTIVE { get; set; }
        public string STATUS { get; set; }
        public string STATUS_MESSAGE { get; set; }
    }
}