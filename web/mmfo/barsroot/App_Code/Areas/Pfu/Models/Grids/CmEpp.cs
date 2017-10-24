using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Pfu.Models.Grids
{
    public class CmEpp
    {
        public decimal ID { get; set; }
        public DateTime? DATEMODE { get; set; }
        public decimal? OPER_TYPE { get; set; }
        public decimal? OPER_STATUS { get; set; }
        public string RESP_TXT { get; set; }
        public string BRANCH { get; set; }
        public DateTime? OPENDATE { get; set; }
        public decimal? CLIENTTYPE { get; set; }
        public string TAXPAYERIDENTIFIER { get; set; }
        public string FIRSTNAME { get; set; }
        public string LASTNAME { get; set; }
        public string MIDDLENAME { get; set; }
        public string ENGFIRSTNAME { get; set; }
        public string ENGLASTNAME { get; set; }
        public string COUNTRY { get; set; }
        public string WORK { get; set; }
        public string OFFICE { get; set; }
        public DateTime? BIRTHDATE { get; set; }
        public string BIRTHPLACE { get; set; }
        public string GENDER { get; set; }
        public decimal? TYPEDOC { get; set; }
        public string PASPNUM { get; set; }
        public string PASPSERIES { get; set; }
        public DateTime? PASPDATE { get; set; }
        public string PASPISSUER { get; set; }
        public string CONTRACTNUMBER { get; set; }
        public string PRODUCTCODE { get; set; }
        public string CARD_TYPE { get; set; }
        public string REGNUMBERCLIENT { get; set; }
        public string REGNUMBEROWNER { get; set; }
        public string CARD_BR_ISS { get; set; }
    }
}