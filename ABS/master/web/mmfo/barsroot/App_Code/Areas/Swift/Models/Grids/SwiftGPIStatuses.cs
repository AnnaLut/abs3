using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Areas.Swift.Models
{

    /// <summary>
    /// Модель для отображения v_sw_gpi_statuses
    /// </summary>
    public class SwiftGPIStatuses
    {
        public SwiftGPIStatuses() { }

        public Int64 Ref { get; set; } // референс документа
        public Int64 MT103 {get;set;} // код типа сообщения
        public String InputOutputInd103 { get; set; } // тип сообщения (входящее/исходящее, наверное I/O)
        public Int64 SWRef { get; set; } // референс сообщения

        public DateTime? DateIn { get; set;} // дата поступления
        public DateTime? VDate { get; set; } // дата валютирования
        public DateTime? DateOut { get; set; } // дата отправки

        public String SenderCode { get; set; }  // код отправителя

        public String SenderAccount { get; set; } // номер счета отправителя
        public String ReceiverCode { get; set; }  // код получателя
        public String Payer { get; set; } // плательщик, скорее всего тот же отправитель, словами
        public String Payee { get; set; } // получатель платежа, словами
        public Decimal Summ { get; set; } //сумма платежа, Amount
        public String Currency { get; set; } // валюта сообщения

        public String STI { get; set; } // "Service type identifier"
        public String UETR { get; set; }  // "Unique End-to-end Transaction Reference"

        public String Status { get; set; } // 
        public String StatusDescription { get; set; }  // 
    }
}