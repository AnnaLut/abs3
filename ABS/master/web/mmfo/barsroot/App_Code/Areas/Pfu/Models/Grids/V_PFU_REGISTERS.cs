using System;

namespace BarsWeb.Areas.Pfu.Models.Grids
{
    public class V_PFU_REGISTERS
    {
        public DateTime? crt_date { get; set; } //Дата реєстру
        public decimal? file_count_rec { get; set; } //Кількість рядків до сплати
        public decimal? file_lines_count { get; set; } //Кількість рядків
        public string file_name { get; set; } //Назва
        public decimal? file_sum { get; set; } //Cума
        public decimal? file_sum_rec { get; set; } //Cума до сплати
        public decimal id { get; set; }
        public DateTime? payment_date { get; set; } //Дата оплати
        public string receiver_mfo { get; set; } //МФО
        public DateTime? register_date { get; set; }//	Дата створення
        public string state { get; set; } //Статус реєстру
        public string state_name { get; set; } //Статус реєстру
        public decimal? rest { get; set; }//	залишок
        public DateTime? restdate { get; set; } //дата залишку
        public string acc { get; set; } //acc
        public decimal? rest_2909 { get; set; } 
        public decimal? payed_sum { get; set; }
        public decimal? payed_cnt { get; set; }
        public decimal? payback_sum { get; set; }
        public decimal? payback_cnt { get; set; }
        public decimal? envelope_request_id { get; set; } //acc
        public decimal? env_id { get; set; } //acc
        public DateTime?  date_env_crt { get; set; }
        public DateTime? pay_date { get; set; }
        public string pfu_branch_name { get; set; }
    }
}