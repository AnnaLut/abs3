using System;

namespace BarsWeb.Areas.CorpLight.Models.Acsk
{
    public class AcskEnrollResponse
    {
        public AcskEnrollResponse()
        {
        }

        public decimal? RequestId { get; set; }
        public int Status { get; set; }
        public DateTime CreateTime { get; set; }
    }
}