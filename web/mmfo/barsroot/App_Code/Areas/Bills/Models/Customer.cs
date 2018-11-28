using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// модель данных пользователя найденного по РНК!
    /// </summary>
    public class Customer
    {
        //Посилання на клієнта АБС
        public Int64? RNK { get; set; }

        //ПІБ/Найменування отримувача
        public String NMK { get; set; }

        //ІНН/ЄДРПОУ отримувача
        public String OKPO { get; set; }

        //Серія документа отримувача
        public String SER { get; set; }

        //Номер документа отримувача
        public String NUMDOC { get; set; }

        //Дата видачі документа
        public DateTime? PDATE { get; set; }

        //Ким виданий документ
        public String ORGAN { get; set; }

        //Тип клієнта (юр/фіз)
        public Int32? CUSTTYPE { get; set; }

        //Номер телефону
        public String PHONE { get; set; }

        // Фактична адреса
        public String ADR { get; set; }

        public List<ReceiverAccounts> ACCOUNTS { get; set; }
    }
}