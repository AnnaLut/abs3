using System;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class BufRelData
    {
        public string Kf { get; set; }

        public int RelId { get; set; }

        public string Relatedness { get; set; }

        public string RelIntext { get; set; }

        public string Rnk { get; set; }

        public string RelRnk { get; set; }

        public string Notes { get; set; }

        public string Maker { get; set; }

        public DateTime MakerDtStamp { get; set; }
    }

}