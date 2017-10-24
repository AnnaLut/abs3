using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class BatchParams
    {
        [Required]
        public string BatchId { get; set; }
        [Required]
        public string Kf { get; set; }
    }
}