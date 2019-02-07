using System;

namespace BarsWeb.Areas.SignStatFiles.Models
{
    /// <summary>
    /// V_STAT_FILE_WORKFLOW row
    /// </summary>
    public class FileWorkflow
    {
        /// <summary>
        /// FILE_ID
        /// </summary>
        public long FileId { get; set; }
        /// <summary>
        /// OPE_ID
        /// </summary>
        public int OperationId { get; set; }
        public string Name { get; set; }
        /// <summary>
        /// NEED_SIGN
        /// </summary>
        public string NeedSign { get; set; }
        /// <summary>
        /// USER_ID
        /// </summary>
        public long? UserId { get; set; }
        /// <summary>
        /// FIO
        /// </summary>
        public string UserPib { get; set; }
        /// <summary>
        /// OPER_DATE
        /// </summary>
        public DateTime? OperDate { get; set; }
        /// <summary>
        /// WAY (when 1 then пряма when 2 then відміна when 3 then пряма(відмінена))
        /// </summary>
        public byte? Way { get; set; }
        /// <summary>
        /// DIRECTION
        /// </summary>
        public string Direction { get; set; }
    }
}
