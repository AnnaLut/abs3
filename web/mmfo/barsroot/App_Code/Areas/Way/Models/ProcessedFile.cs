using System;
using Newtonsoft.Json;

namespace BarsWeb.Areas.Way.Models
{
    public class ProcessedFile
    {
        public string MFOA { get; set; } // МФО отправителя
        public string MFOB { get; set; } // МФО получателя
        public string NLSA { get; set; } // Счет отправителя
        public string NLSB { get; set; } // Счет получателя
        [JsonIgnore]
        public decimal? S { get; set; } // Сумма
        public decimal? Sgrn
        {
            get
            {
                return null == S ? 0 : S / 100;
            }
            set
            {
                S = value * 100;
            }
        }
        public decimal? KV { get; set; } // Код валюты
        public string LCV { get; set; } // Симв Код
        public decimal? DIG { get; set; } // Коп
        [JsonIgnore]
        public decimal? S2 { get; set; } // Сумма документа 2
        public decimal? Sgrn2
        {
            get
            {
                return null == S2 ? 0 : S2 / 100;
            }
            set
            {
                S2 = value * 100;
            }
        }
        public decimal? KV2 { get; set; } // Код валюты 2
        public string LCV2 { get; set; } // Симв Код
        public decimal? DIG2 { get; set; } // Коп
        public decimal? SK { get; set; } // Символ кассплана
        public decimal? DK { get; set; } // Д/К
        public decimal? VOB { get; set; } // Вид банковского документа
        public DateTime? DATD { get; set; } // Дата документа
        public DateTime? VDAT { get; set; } // Плановая дата валютирования
        public string TT { get; set; } // Тип транзакции
        public decimal ID { get; set; } // REF - Внутренний номер документа
        public decimal REF { get; set; } // Внутренний номер документа
        public decimal? SOS { get; set; } // Состояние документа
        public decimal? USERID { get; set; }
        public string ND { get; set; } // Номер документа
        public string NAZN { get; set; } // Назначение платежа
        public string ID_A { get; set; } // Идент. код отправителя
        public string NAM_A { get; set; } // Наименование отправителя
        public string ID_B { get; set; } // Идент. код получателя
        public string NAM_B { get; set; } // Наименование получателя
        public string TOBO { get; set; } // Код безбалансового отделения
    }
}