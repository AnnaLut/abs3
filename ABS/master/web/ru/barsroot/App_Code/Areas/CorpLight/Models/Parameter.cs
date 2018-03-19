using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.CorpLight.Models
{

    public class Parameter
    {
        [Key]
        public string Name { get; set; }
        public string Value { get; set; }
        public string Description { get; set; }
    }
}
