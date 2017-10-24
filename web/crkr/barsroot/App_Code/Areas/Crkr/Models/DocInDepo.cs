namespace BarsWeb.Areas.Crkr.Models
{
    public class DocInDepo
    {
        public decimal id { get; set; }
        public string doctype { get; set; }
        public string docserial { get; set; }
        public string docnumber { get; set; }
        public string docdate { get; set; }
        public string docorg { get; set; }
        public int type_person { get; set; }
        public string name_person { get; set; }
        public string edrpo_person { get; set; }
    }
}