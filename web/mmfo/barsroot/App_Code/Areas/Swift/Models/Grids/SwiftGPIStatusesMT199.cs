using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Areas.Swift.Models
{

    /// <summary>
    /// Модель для отображения v_sw_gpi_statuses
    /// </summary>
    public class SwiftGPIStatusesMT199
    {
        public SwiftGPIStatusesMT199() { }

        public String UETR { get; set; }  // "Unique End-to-end Transaction Reference"
        public Int64 Ref { get; set; } //референс сообщения (свифтовый)
        public Int64 MT {get;set;} // код типа сообщения

        public String Status { get; set; } // for some reason Status in SwiftGPIStatuses db view should be string, while here - of type short
        public String StatusDescription { get; set; }  // 
        public String SenderCode { get; set; }  // код отправителя
        public String ReceiverCode { get; set; }  // код получателя
        public String Currency { get; set; } // валюта сообщения
        public Decimal Summ { get; set; } //сумма платежа, Amount
        public DateTime? DateOut { get; set; } // дата отправки
    }
}