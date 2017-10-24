using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;

namespace BarsWeb.Areas.BatchOpeningCardAccounts.Infrastructure.DI.Implementation {
    public class SqlCreator
    {
        public static BarsSql SearchMain(DateTime dateStart, DateTime dateEnd)
        {
            return new BarsSql()
            {
                SqlText = @"select * from ow_batch_files where file_date between :p_datestart and :p_dateend+0.99999",
                SqlParams = new object[] 
                {
                    new OracleParameter("p_datestart", OracleDbType.Date) { Value = dateStart },
                    new OracleParameter("p_dateend", OracleDbType.Date) { Value = dateEnd }
                }
            };
        }

        public static BarsSql SearchData(long Id)
        {
            return new BarsSql()
            {
                SqlText = @"select * from V_OW_BATCH_OPEN_DATA where ID = :P_ID",
                SqlParams = new object[] 
                {
                    new OracleParameter("P_ID", OracleDbType.Int64) { Value = Id }
                }
            };
        }

        public static BarsSql FileTypes()
        {
            return new BarsSql()
            {
                SqlText = @"select * from OW_BATCH_FILETYPES",
                SqlParams = new object[] { }
            };
        }

        public static BarsSql LoadFile(string p_filename, byte[] p_filebody, int p_filetype)
        {
            int p_fileid = 0;

            return new BarsSql()
            {
                SqlText = @"begin
                                ow_batch_opening.import_file(:p_filename, :p_filebody, :p_filetype, :p_fileid);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_filename", OracleDbType.Varchar2) { Value = p_filename },
                    new OracleParameter("p_filebody", OracleDbType.Blob) { Value = p_filebody },
                    new OracleParameter("p_filetype", OracleDbType.Int32) { Value = p_filetype },
                    new OracleParameter("p_fileid", OracleDbType.Int32, p_fileid, System.Data.ParameterDirection.Output)
                }
            };
        }

        public static BarsSql CreateDeal(int p_fileid, string p_card_code, string p_branch, int p_isp, int? p_proect_id)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                                ow_batch_opening.create_deal(:p_fileid, :p_proect_id, :p_card_code, :p_branch, :p_isp);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_fileid", OracleDbType.Int32) { Value = p_fileid },
                    new OracleParameter("p_proect_id", OracleDbType.Int32) { Value = p_proect_id },
                    new OracleParameter("p_card_code", OracleDbType.Varchar2) { Value = p_card_code },
                    new OracleParameter("p_branch", OracleDbType.Varchar2) { Value = p_branch },
                    new OracleParameter("p_isp", OracleDbType.Int32) { Value = p_isp }
                }
            };
        }

        public static BarsSql FormTicket(int p_fileid, string p_ticketdata, string p_ticketname)
        {

            return new BarsSql()
            {
                SqlText = @"begin
                                ow_batch_opening.form_ticket(:p_fileid, :p_ticketname, :p_ticketdata);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_fileid", OracleDbType.Int32) { Value = p_fileid },
                    new OracleParameter("p_ticketname", OracleDbType.Varchar2, 4000, p_ticketname, System.Data.ParameterDirection.Output),
                    new OracleParameter("p_ticketdata", OracleDbType.Clob, p_ticketdata, System.Data.ParameterDirection.Output)
                }
            };
        }
    }
}
