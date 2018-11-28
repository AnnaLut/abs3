using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// Модель Хранилища файлов
    /// </summary>
    public class File_Archive
    {
        public String KF { get; set; }
        public Int32 FILE_ID { get; set; }
        public String FILE_NAME { get; set; }
        public String DESCRIPTION { get; set; }
        public DateTime? LOAD_DATE { get; set; }
        public String FILE_STATUS { get; set; }
    }
}