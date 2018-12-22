using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for MetaCallSettings
/// </summary>
namespace BarsWeb.Areas.Ndi.Models
{

    public class MetaCallSettings
    {
        public MetaCallSettings()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public decimal? ID { get; set; }

        public string CODE { get; set; }
        public string CALL_FROM { get; set; }

        public string WEB_FORM_NAME { get; set; }

        public string TABNAME { get; set; }
        public decimal? TABID { get; set; }

        public int? ACCESSCODE { get; set; }

        public decimal? FUNCID { get; set; }

        public string SHOW_DIALOG { get; set; }

        public string LINK_TYPE { get; set; }

        public short? INSERT_AFTER { get; set; }

        public string EDIT_MODE { get; set; }

        public short? SUMM_VISIBLE { get; set; }

        public string CONDITIONS { get; set; }

        public string EXCEL_OPT { get; set; }

        public short? ADD_WITH_WINDOW { get; set; }

        public short? SWITCH_OF_DEPS { get; set; }

        public short? SHOW_COUNT { get; set; }

        public string SAVE_COLUMN { get; set; }

        public string CODEAPP { get; set; }
        public string BASE_OPTIONS { get; set; }
        public string CUSTOM_OPTIONS { get; set; }
    }
}