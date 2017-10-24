using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace BarsWeb.Areas.Sep.Models
{
	public class SepLockDoc
	{
        public decimal? Ref { get; set; }
        public Int16? blk { get; set; } //Код блокировки
        public string mfoa { get; set; } //МФО банка Плательщика
        public string nlsa { get; set; } //Счет Плательщика
        public string nam_a { get; set; } //Наименование Плательщика
        public Int16 kv { get; set; } //Код Вал
        public byte dk { get; set; } //Дб Кр
        public decimal s { get; set; } //Сумма
        public string mfob { get; set; } //МФО банка Получателя
        public string nlsb { get; set; } //Счет Получателя
        public string nam_b { get; set; } //Наименование Получателя
        public string nazn { get; set; } //Назначение платежа
        public decimal rec { get; set; }
        public DateTime? dat_a { get; set; } //Дата платежного документа
        public Int16 prty { get; set; } //Признак срочности

        public Int32 bis { get; set; }

        public short vob { get; set; }
        public string nd { get; set; }
        public DateTime datd { get; set; }

        public string id_a { get; set; }
        public string id_b { get; set; }

        public string blkName { get; set; }
    }
}