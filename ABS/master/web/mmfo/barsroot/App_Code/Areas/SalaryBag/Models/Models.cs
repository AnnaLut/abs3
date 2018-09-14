using Newtonsoft.Json;
using System;

namespace Areas.SalaryBag.Models
{
    public class ZpDeals
    {
        public decimal id { get; set; }
        public string deal_id { get; set; }
        public DateTime? start_date { get; set; }
        public DateTime? close_date { get; set; }
        public decimal? rnk { get; set; }
        public string nmk { get; set; }
        public string deal_name { get; set; }
        public string fs_name { get; set; }
        public int? fs { get; set; }
        public int? sos { get; set; }
        public string sos_name { get; set; }
        public int? deal_premium { get; set; }
        public int? central { get; set; }
        public string nls_2909 { get; set; }
        public decimal? ostc_2909 { get; set; }
        public string nls_3570 { get; set; }
        public decimal? ostc_3570 { get; set; }
        public string branch { get; set; }
        public string fio { get; set; }
        public string corp2 { get; set; }
        public int? kod_tarif { get; set; }
        public string tarif_name { get; set; }
        public int? tar { get; set; }
        public string max_tarif { get; set; }
        public string ind_acc_tarif { get; set; }
        public string comm_reject { get; set; }
        public int? tip { get; set; }
        public string okpo { get; set; }
        public decimal? acc_2909 { get; set; }
        public decimal? acc_3570 { get; set; }
    }

    public class ZpDealEditHistory
    {
        public string deal_id { get; set; }
        public decimal? rnk { get; set; }
        public string branch { get; set; }
        public string upd_user_fio { get; set; }

        [JsonIgnore]
        public DateTime? upd_date { get; set; }

        [JsonProperty(PropertyName = "upd_date")]
        public string upd_date_string
        {
            get
            {
                if (upd_date == null) return "";

                DateTime tmp = (DateTime)upd_date;
                return tmp.ToString("dd.MM.yyyy");
            }
        }
        [JsonProperty(PropertyName = "upd_time")]
        public string upd_time_string
        {
            get
            {
                if (upd_date == null) return "";

                DateTime tmp = (DateTime)upd_date;
                return tmp.ToString("HH:mm:ss");
            }
        }
        [JsonProperty(PropertyName = "Тип організації")]
        public string fs_name { get; set; }
        [JsonProperty(PropertyName = "Стан договору")]
        public string sos_name { get; set; }
        [JsonIgnore]
        public int? deal_premium { get; set; }
        [JsonProperty(PropertyName = "Тип договору")]
        public string deal_premium_string
        {
            get
            {
                return deal_premium == 1 ? "Преміальний" : "Базовий";
            }
        }

        [JsonIgnore]
        public int? central { get; set; }
        [JsonProperty(PropertyName = "Централізований договір")]
        public string central_string
        {
            get
            {
                return central == 1 ? "Так" : "Ні";
            }
        }
        [JsonProperty(PropertyName = "Код тарифу")]
        public int? kod_tarif { get; set; }
        [JsonProperty(PropertyName = "Рахунок 2909")]
        public string nls_2909 { get; set; }
        [JsonProperty(PropertyName = "Рахунок 3570")]
        public string nls_3570 { get; set; }
    }

    public class ZpDealsMin
    {
        public decimal id { get; set; }
        public string deal_id { get; set; }
        public string deal_name { get; set; }
        public string okpo { get; set; }
        public string nmk { get; set; }
    }

    public class ZpDealInfo : SignedModel
    {
        public string okpo { get; set; }
        public string nmk { get; set; }
        public string deal_id { get; set; }
        public string deal_name { get; set; }
        public int deal_premium { get; set; }
        public decimal? ostc_2909 { get; set; }
        public string nls_2909 { get; set; }
        public string nls_3570 { get; set; }
        public decimal? kod_tarif { get; set; }

        public DateTime? pr_date { get; set; }
        public string payroll_num { get; set; }
        public string nazn { get; set; }

        public decimal? ostc_3570 { get; set; }

        public string reject_fio { get; set; }
        public string comm_reject { get; set; }
    }

    public class PayRollItem : SignedModel
    {
        public int id { get; set; }
        public int rownum { get; set; }
        public string namb { get; set; }
        public string okpob { get; set; }
        public string mfob { get; set; }
        public string nlsb { get; set; }
        public decimal? s { get; set; }
        public string nazn { get; set; }
        public string source { get; set; }
        public decimal? doc_ref { get; set; }
        public int? sos { get; set; }
        public string doc_comment { get; set; }
        public string passp_serial { get; set; }
        public string passp_num { get; set; }
        public string idcard_num { get; set; }
    }

    public class ClientModel
    {
        public string okpo { get; set; }
        public string nmk { get; set; }
        public string nls { get; set; }
        public string mfo { get; set; }

        public string PassportSerial { get; set; }
        public string PassportNumber { get; set; }
        public string PassportIdCardNum { get; set; }
        public DateTime? ActualDate { get; set; }
    }

    public class PayrollHistory
    {
        public decimal? id { get; set; }
        public DateTime? pr_date { get; set; }
        public string deal_name { get; set; }
        public decimal? cnt { get; set; }
        public decimal? s { get; set; }
        public decimal? cms { get; set; }
        public string src_name { get; set; }
        public string payroll_num { get; set; }
    }

    public class DdlIdNameModel
    {
        public int id { get; set; }
        public string name { get; set; }
    }

    public class EaStructCodesDdl
    {
        public string id { get; set; }
        public string name { get; set; }
    }

    public class SignModel
    {
        public decimal? id { get; set; }
        public string buffer { get; set; }
    }
}
