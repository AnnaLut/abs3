using System;

namespace BarsWeb.Areas.Pfu.Models.Grids
{
    public class V_PFU_RECORDS
    {
        public decimal id { get; set; }
        public string full_name { get; set; } //ПІБ отримувача
        public string numident { get; set; } //ІПН
        public string num_acc { get; set; } //Номер рахунку
        public string mfo { get; set; } //Код МФО
        public decimal? sum_pay { get; set; } //Сума
        public decimal? Ref  { get; set; } //Платіжне доручення №
        public DateTime? date_income { get; set; } //День зарахування
        public DateTime? payment_date { get; set; } //День зарахування
        public Int32? state { get; set; } //Статус
        public string state_name { get; set; } //Статус name
        public string date_enr { get; set; } 
        public DateTime? DATE_PAYBACK { get; set; }
        public string NUM_PAYM { get; set; }
        public string ERR_MESS_TRACE { get; set; }
    }
}