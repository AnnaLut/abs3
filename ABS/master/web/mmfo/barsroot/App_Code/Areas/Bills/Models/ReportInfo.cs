using System;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// Модель отчета (FastReport)
    /// </summary>
    public class ReportInfo
    {
        public Int32 Report_ID { get; set; }

        [Display(Name = "Назва звіту")]
        [Required]
        public String Report_Name { get; set; }

        [Display(Name = "Назва файлу")]
        [Required]
        public String Frx_File_Name { get; set; }

        [Display(Name = "Опис звіту")]
        public String Description { get; set; }

        public Int32? Active { get; set; }
    }
}