using System;

namespace BarsWeb.Areas.Pfu.Models.Grids
{
    public class V_PFU_ENVELOPE_WFILE
    {
        public decimal id { get; set; } //ID
        public decimal pfu_envelope_id { get; set; } //ID конверту (ПФУ)
        public string pfu_branch_code { get; set; } //Код обл. управління (ПФУ)
        public string pfu_branch_name { get; set; } //Назва обл. управління (ПФУ)
        public DateTime register_date { get; set; } //Дата створення (Конверт)
        public string receiver_mfo { get; set; } //МФО отримувача
        public string receiver_branch { get; set; } //Код відділення
        //public string receiver_name { get; set; }   //Назва відділення
        public decimal? check_sum { get; set; } //Сума платежів (Конверт)
        public decimal? check_lines_count { get; set; } //Кількість рядків
        public DateTime crt_date { get; set; } //Дата завантаження 
        public string state { get; set; } //Статус
        public Int32 count_files { get; set; } //Кількість файлів (Конверт)
    }
}