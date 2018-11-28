using System;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// модель данных возвращаемого файла!
    /// </summary>
    public class FileResponseModel
    {
        //Файл в массиве байтов
        public Byte[] Bytes { get; set; }
        public String FileName { get; set; }
    }
}