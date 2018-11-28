using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// Модель данных Файла
    /// </summary>
    public class SaveFileModel
    {
        public String FileName { get; set; }
        public String Description { get; set; }
        public Byte[] Data { get; set; }
    }
}