using System;

namespace BarsWeb.Areas.Sep.Models
{
    public class SepFutureDoc
    {
        public int? dk { get; set; }
        public decimal? ref_ { get; set; } //Референція
        public string mfoa { get; set; } //МФО А з док
        public string mfob { get; set; } //МФО Б з док
        public string nlsa { get; set; } //Рахунок А з док
        public decimal? s { get; set; } //Сума док
        public string nlsb { get; set; } //Рахунок Б з док
        public string nam_b { get; set; } //Отримувач з док
        public string nazn { get; set; } // Призначення платежу
        public decimal rec { get; set; }
        public DateTime? dat_a { get; set; } //Дата зарахування
        public string nd { get; set; } //№ док
        public string nam_a { get; set; } //Платник з документу
        public int? vob { get; set; } //Вид ОП
        public DateTime? datd { get; set; } //Дата док
        public string id_a { get; set; }
        public string id_b { get; set; } //ОКПО Б з док
        public string nms { get; set; } //Назва рахунку
        public string okpo { get; set; } //ОКРО РАХ
        public int otm { get; set; } //Відк
        public int? kv { get; set; }
        public string nlsalt { get; set; }
        public DateTime? dazs { get; set; }
        public string datval { get; set; } //Дата валютування 
    }
}