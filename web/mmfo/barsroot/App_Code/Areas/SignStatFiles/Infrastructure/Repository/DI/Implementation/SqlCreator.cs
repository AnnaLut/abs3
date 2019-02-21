using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;
using System.Data;

namespace BarsWeb.Areas.SignStatFiles.Infrastructure.DI.Implementation
{
    public class SqlCreator
    {
        public static BarsSql GetAllFiles()
        {
            return new BarsSql
            {
                SqlParams = new object[] { },
                SqlText = @"select t.file_id          FileId,
                                   t.file_name        FileName,
                                   t.file_type_id     FileTypeId,
                                   t.file_type_name   FileTypeName,
                                   t.file_date        FileDate,
                                   t.load_date        LoadDate,
                                   t.load_user_id     LoadUserId,
                                   t.load_user_fio    LoadUserPib,
                                   t.exec_user_id     ExecUserId,
                                   t.exec_user_fio    ExecUserPib,
                                   t.file_status      FileStatus,
                                   t.file_status_name FileStatusName,
                                   t.status_date      StatusDate,
                                   t.last_version     LastVersion,
                                   t.store_id         StorageId,
                                   t.file_size        FileSize,
                                   t.file_hash        FileHash,
                                   t.file_ver         FileVersion,
                                   t.signer_id        SignerId,
                                   t.sign_date        SignDate,
                                   t.signer_fio       SignerPib,
                                   t.ext_id           ExtensionId,
                                   t.wf_id            WorkflowId,
                                   t.kf,
                                   t.oper_id          OperationId,
                                   t.oper_name        OperationName,
                                   t.need_sign        NeedSign,
                                   t.end_oper         Completed,
                                   t.load
                              from V_STAT_FILES t
                              order by t.file_id desc"
            };
        }

        public static BarsSql GetFileHistory()
        {
            return new BarsSql
            {
                SqlText = @"select t.file_id   FileId,
                                   t.ope_id    OperationId,
                                   t.name,
                                   t.need_sign NeedSign,
                                   t.user_id   UserId,
                                   t.fio       UserPib,
                                   t.oper_date OperDate,
                                   t.way,
                                   t.direction
                            from V_STAT_FILE_WORKFLOW t",
                SqlParams = new object[] { }
            };
        }
    }
}
