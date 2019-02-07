using System;

namespace BarsWeb.Areas.SignStatFiles.Models
{
    /// <summary>
    /// V_STAT_FILES row
    /// </summary>
    public class StatFile
    {
        /// <summary>
        /// file_id
        /// </summary>
        public long FileId { get; set; }
        /// <summary>
        /// file_name
        /// </summary>
        public string FileName { get; set; }
        /// <summary>
        /// file_type_id
        /// </summary>
        public int? FileTypeId { get; set; }
        /// <summary>
        /// file_type_name
        /// </summary>
        public string FileTypeName { get; set; }
        /// <summary>
        /// file_date
        /// </summary>
        public string FileDate { get; set; }
        /// <summary>
        /// load_date
        /// </summary>
        public DateTime? LoadDate { get; set; }
        /// <summary>
        /// load_user_id
        /// </summary>
        public long? LoadUserId { get; set; }
        /// <summary>
        /// load_user_fio
        /// </summary>
        public string LoadUserPib { get; set; }
        /// <summary>
        /// exec_user_id
        /// </summary>
        public long? ExecUserId { get; set; }
        /// <summary>
        /// exec_user_fio
        /// </summary>
        public string ExecUserPib { get; set; }
        /// <summary>
        /// file_status
        /// </summary>
        public int? FileStatus { get; set; }
        /// <summary>
        /// file_status_name
        /// </summary>
        public string FileStatusName { get; set; }
        /// <summary>
        /// status_date
        /// </summary>
        public DateTime? StatusDate { get; set; }
        /// <summary>
        /// last_version
        /// </summary>
        public int? LastVersion { get; set; }
        /// <summary>
        /// store_id
        /// </summary>
        public long? StorageId { get; set; }
        /// <summary>
        /// file_size
        /// </summary>
        public long? FileSize { get; set; }
        /// <summary>
        /// file_hash
        /// </summary>
        public string FileHash { get; set; }
        /// <summary>
        /// file_ver
        /// </summary>
        public int? FileVersion { get; set; }
        /// <summary>
        /// signer_id
        /// </summary>
        public long? SignerId { get; set; }
        /// <summary>
        /// sign_date
        /// </summary>
        public DateTime? SignDate { get; set; }
        /// <summary>
        /// signer_fio
        /// </summary>
        public string SignerPib { get; set; }
        /// <summary>
        /// ext_id
        /// </summary>
        public string ExtensionId { get; set; }
        /// <summary>
        /// wf_id
        /// </summary>
        public int? WorkflowId { get; set; }
        /// <summary>
        /// kf
        /// </summary>
        public int? Kf { get; set; }
        /// <summary>
        /// oper_id
        /// </summary>
        public int? OperationId { get; set; }
        /// <summary>
        /// oper_name
        /// </summary>
        public string OperationName { get; set; }
        /// <summary>
        /// need_sign
        /// </summary>
        public string NeedSign { get; set; }
        /// <summary>
        /// end_oper (1 = processing complette)
        /// </summary>
        public short? Completed { get; set; }
        /// <summary>
        /// load (1 = user can download file)
        /// </summary>
        public byte? Load { get; set; }
    }
}
