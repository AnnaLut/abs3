using Oracle.DataAccess.Types;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;



namespace BarsWeb.Areas.Ndi.Models.FilterModels
{
    public class IconsMetainfo
    {
        public IconsMetainfo()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public int ICON_ID { get; set; }
        public string ICON_PATH { get; set; }
        public string ICON_DESC { get; set; }
        public byte[] IMAGE { get; set; }
    }

}