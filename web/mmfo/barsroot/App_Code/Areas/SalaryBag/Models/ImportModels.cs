using System;

namespace Areas.SalaryBag.Models
{
    public class ImportedFileModel
    {
        public decimal id { get; set; }
        public decimal? id_pr { get; set; }
        public DateTime? imp_date { get; set; }
        public string file_name { get; set; }
        public int? sos { get; set; }
        public string sos_text { get; set; }
        public string err_text { get; set; }
        public int? cnt_total { get; set; }
        public int? cnt_doc { get; set; }
        public int? cnt_doc_reject { get; set; }
    }

    public class ImportErrorModel
    {
        public string okpob { get; set; }
        public string namb { get; set; }
        public string mfob { get; set; }
        public string nlsb { get; set; }
        public string err_text { get; set; }
    }

    public class cfgDropDownModel
    {
        public int? id { get; set; }
        public string name { get; set; }
    }
}
