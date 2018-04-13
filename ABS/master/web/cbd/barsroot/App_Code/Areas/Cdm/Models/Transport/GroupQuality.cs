using System.Runtime.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    [DataContract]
    public class GroupQuality
    {
        [DataMember(IsRequired = true)]
        public decimal? Quality { get; set; }
        public string Name { get; set; }
    }

}