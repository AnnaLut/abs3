using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;
using System.Data;
using System.Collections.Generic;

namespace BarsWeb.Areas.ImageViewer.Infrastructure.DI.Implementation {
    public class SqlCreator
    {
        public static BarsSql SearchMain(ImageViewerRequest obj)
        {
            List<object> sqlParams = new List<object>();
            if (!string.IsNullOrEmpty(obj.TYPE_IMG))
            {
                sqlParams.Add(new OracleParameter("P_TYPE_IMG", OracleDbType.Varchar2) { Value = obj.TYPE_IMG });
            }

            return new BarsSql()
            {
                SqlText = string.Format(@"select C.RNK, C.OKPO, C.NMK,
                    CI.TYPE_IMG, CI.DATE_IMG ,
                   (select S.FIO 
                    from customer cc, staff$base s 
                    where cc.rnk = C.RNK 
                    and cc.ISP = S.ID) AS ISP
                    from customer c, CUSTOMER_IMAGES ci 
                    where C.RNK = CI.RNK                    
                    and CI.TYPE_IMG {0} {1} {2}", 
                    string.IsNullOrEmpty(obj.TYPE_IMG) ? @"in ('PHOTO_WEB', 'PHOTO_JPG')" : "= :P_TYPE_IMG",
                    !string.IsNullOrEmpty(obj.DATE_IMG_START) ? string.Format("and CI.DATE_IMG >= to_date('{0}','mm/dd/yyyy')", obj.DATE_IMG_START) : "",
                    !string.IsNullOrEmpty(obj.DATE_IMG_END) ? string.Format("and CI.DATE_IMG <= to_date('{0}','mm/dd/yyyy')+0.99999", obj.DATE_IMG_END) : ""
                    ),
                SqlParams = sqlParams.ToArray()
            };
        }

        public static BarsSql GetImagesTypes()
        {
            return new BarsSql()
            {
                SqlText = @"select * from CUSTOMER_IMAGE_TYPES",
                SqlParams = new object[] { }
            };
        }
    }
}
