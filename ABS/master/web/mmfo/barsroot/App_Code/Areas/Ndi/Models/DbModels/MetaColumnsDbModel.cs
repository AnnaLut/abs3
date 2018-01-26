using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for MetaColumnsDbModel
/// </summary>
namespace BarsWeb.Areas.Ndi.Models.DbModels
{
    public class MetaColumnsDbModel
    {
        public MetaColumnsDbModel()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public decimal TABID { get; set; }
        public decimal COLID { get; set; }
        public string COLNAME { get; set; }
        public string COLTYPE { get; set; }
        public string SEMANTIC { get; set; }
        public decimal? SHOWWIDTH { get; set; }
        public decimal? SHOWMAXCHAR { get; set; }
        public string SHOWFORMAT { get; set; }
        public short SHOWIN_FLTR { get; set; }
        public short NOT_TO_EDIT { get; set; }
        public short NOT_TO_SHOW { get; set; }
        public short EXTRNVAL { get; set; }
        public short? SHOWPOS { get; set; }
        public short? SHOWRETVAL { get; set; }
        public short? INPUT_IN_NEW_RECORD { get; set; }
        public decimal? INSTNSSEMANTIC { get; set; }
        public decimal? ORDERID { get; set; }
        public short SHOWIN_RO { get; set; }
        public decimal? SHOWREL_CTYPE { get; set; }
        public decimal? SHOWREF { get; set; }
        public string SHOWRESULT { get; set; }
        public short? CASE_SENSITIVE { get; set; }
        public int SIMPLE_FILTER { get; set; }
        public string Form_Name { get; set; }
        public string WEB_FORM_NAME { get; set; }
        public string BRANCH { get; set; }

    }
}