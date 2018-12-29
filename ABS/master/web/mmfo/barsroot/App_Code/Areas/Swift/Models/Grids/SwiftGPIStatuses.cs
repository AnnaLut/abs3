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

        public Int64? Ref { get; set; } // референс документа  //N
        public Int64 MT103 {get;set;} // код типа сообщения  //C
        public String InputOutputInd103 { get; set; } // тип сообщения (входящее/исходящее, наверное I/O)  //C
        public Int64? SWRef { get; set; } // референс сообщения  //C  - but are really empty in DB

        public DateTime? DateIn { get; set;} // дата поступления  //N
        public DateTime? VDate { get; set; } // дата валютирования  //N
        public DateTime? DateOut { get; set; } // дата отправки  //N

        public String SenderCode { get; set; }  // код отправителя  //C

        public String SenderAccount { get; set; } // номер счета отправителя  //C  - but is really empty in DB
        public String ReceiverCode { get; set; }  // код получателя   //C
        public String Payer { get; set; } // плательщик, скорее всего тот же отправитель, словами  //N
        public String Payee { get; set; } // получатель платежа, словами   //N
        public Decimal Summ { get; set; } //сумма платежа, Amount  //C
        public String Currency { get; set; } // валюта сообщения  //C

        public String STI { get; set; } // "Service type identifier"   //N
        public String UETR { get; set; }  // "Unique End-to-end Transaction Reference"  //N

        public String Status { get; set; } //N 
        public String StatusDescription { get; set; }  //N 

        //*where N - is possibly nullable field
        // C - Compulsory field, will be always filled
    }
}