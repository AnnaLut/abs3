using System;

namespace BarsWeb.Areas.SignStatFiles.Models
{
    public class FileOperation
    {
        public long FileId { get; set; }
        public int OperationId { get; set; }
        public string Sign { get; set; }
        public byte Reverse { get; set; }
        public bool IsCAdES { get; set; }
        public long StorageId { get; set; }
    }
}
