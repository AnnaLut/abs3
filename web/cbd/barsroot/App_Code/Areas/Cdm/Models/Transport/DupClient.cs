using System.Runtime.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    [DataContract]
    public class DupClient
    {
        [DataMember(IsRequired = true)]
        public string Kf { get; set; }

        [DataMember(IsRequired = true)]
        public string Rnk { get; set; }
        public DupClient[] Duplicates { get; set; } 
    }
}