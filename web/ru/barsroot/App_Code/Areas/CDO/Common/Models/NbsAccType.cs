using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.CDO.Common.Models
{
    /// <summary>
    /// Summary description for NbsAccType
    /// </summary>
    public class NbsAccType
    {
        public string Id
        {
            get { return Nbs + TypeId; }
        }

        [Key]
        [Required]
        public string Nbs { get; set; }
        [Key]
        [Required]
        public string TypeId { get; set; }

        public string TypeName { get; set; }
    }
}
