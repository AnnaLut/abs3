using System.Collections.Generic;

namespace BarsWeb.Areas.Mbdk.Models
{
    public class NostroDataList
    {
        public List<KeyValuePair<int, string>> KAT23 { get; set; }
        public List<KeyValuePair<int, string>> FIN { get; set; }
        public List<KeyValuePair<int, string>> OBS23 { get; set; }
        public List<KeyValuePair<int, string>> KV { get; set; }


        public NostroDataList()
        {
            KAT23 = new List<KeyValuePair<int, string>>();
            FIN = new List<KeyValuePair<int, string>>();
            OBS23 = new List<KeyValuePair<int, string>>();
            KV = new List<KeyValuePair<int, string>>();
        }
    }
}