using System;

namespace Areas.SalaryBag.Models
{
    public class TarifsModel
    {
        public int kod { get; set; }
        public int kv { get; set; }
        public string name { get; set; }
        public decimal? tar { get; set; }
        public decimal? pr { get; set; }
        public int tip { get; set; }
    }

    public class TarifDetails
    {
        public int kod { get; set; }
        public decimal? sum_limit { get; set; }
        public decimal? sum_tarif { get; set; }
        public decimal? pr { get; set; }
        public decimal? smin { get; set; }
        public decimal? smax { get; set; }
    }
}