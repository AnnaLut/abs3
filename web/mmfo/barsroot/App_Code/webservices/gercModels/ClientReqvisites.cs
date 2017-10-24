using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.WebServices.GercPayModels
{
    /// <summary>
    /// Часть заведения/обновления/получения РНК клиента-получателя оплаты за услуги из ГЕРЦ в АБС
    /// </summary>
    /// класс полного перечня реквизитов клиента
    public class ClientReqvisites
    {
        public Decimal? RNK { get; set; }
        public Decimal? CUSTTYPE { get; set; }
        public Decimal? COUNTRY { get; set; }
        public string NMK { get; set; }
        public string NMKV { get; set; }
        public string NMKK { get; set; }
        public Decimal? CODCAGENT { get; set; }
        public Decimal? PRINSIDER { get; set; }
        public string OKPO { get; set; }
        public string ADR { get; set; }
        //public CustomerAddress[] ADDR { get; set; }
        public Decimal? C_REG { get; set; }
        public Decimal? C_DST { get; set; }
        public string ADM { get; set; }
        public string DATE_ON { get; set; }
        public string DATE_OFF { get; set; }
        public string CRISK { get; set; }
        public string ND { get; set; }
        public string ISE { get; set; }
        public string FS { get; set; }
        public string OE { get; set; }
        public string VED { get; set; }
        public string SED { get; set; }
        public string MB { get; set; }
        public string RGADM { get; set; }
        public Decimal? BC { get; set; }
        public string BRANCH { get; set; }
        public string TOBO { get; set; }
        public string K050 { get; set; }
        public string NREZID_CODE { get; set; }
        public Decimal? PASSP { get; set; }
        public string SER { get; set; }
        public string DOCNUM { get; set; }
        public Decimal? OperationResult { get; set; } // 20 найден клиент ЮЛ, 21 найден Не клиент ЮЛ, 30 найден клиент ФЛб 31 найден не клиент ФЛ
    }
}