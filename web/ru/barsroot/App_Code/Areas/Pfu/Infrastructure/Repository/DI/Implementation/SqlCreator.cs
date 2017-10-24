using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Pfu.Infrastructure.Repository.DI.Implementation
{
    /// <summary>
    /// Summary description for SqlCreator
    /// </summary>
    public class SqlCreator
    {
        public static BarsSql InitSearchKvitSendHistory()
        {
            return new BarsSql()
            {
                SqlText = @"select * from pfu.v_pfu_file_kvit2_history",
                SqlParams = new object[] { }
            };
        }

        public static BarsSql RecordStatus()
        {
            return new BarsSql()
            {
                SqlText = @"select * from pfu.pfu_record_state",
                SqlParams = new object[] { }
            };
        }

        static public BarsSql InitSearchKvitSend()
        {
            return new BarsSql()
            {
                SqlText = @"select * from pfu.v_pfu_file_kvit2",
                SqlParams = new object[] { }
            };
        }

        static public BarsSql InitSearchCatalogHistory()
        {
            return new BarsSql()
            {
                SqlText = @"select * from pfu.v_pfu_registers where state in ('PAYED', 'ERROR')",
                SqlParams = new object[] { }
            };
        }

        static public BarsSql InitSearchSync(SearchSyncPensioners qv)
        {
            return new BarsSql()
            {
                SqlText = @"select * from pfu.v_syncru_ebd
                        where (KF = :P_KF or :P_KF is null)
                        and (CURSTATE = :P_CURSTATE or :P_CURSTATE is null)",
                SqlParams = new object[]
                {
                    new OracleParameter("P_KF", OracleDbType.Varchar2) { Value = qv.KF },
                    new OracleParameter("P_KF", OracleDbType.Varchar2) { Value = qv.KF },
                    new OracleParameter("P_CURSTATE", OracleDbType.Decimal) { Value = qv.CURSTATE },
                    new OracleParameter("P_CURSTATE", OracleDbType.Decimal) { Value = qv.CURSTATE },
                }
            };
        }

        static public BarsSql GetDestroyedEpcInfo(string epcId)
        {
            return new BarsSql()
            {
                SqlText = @"select k.epp_number, k.kill_date, kt.name name_t
                        from pfu.pfu_epp_killed k
                        inner join pfu.pfu_epp_kill_type kt on k.kill_type = kt.id_type
                        where (k.epp_number = :p_epp_number)",

                SqlParams = new object[]
                {
                new OracleParameter("p_epp_number", OracleDbType.Varchar2) { Value = epcId },
                new OracleParameter("p_epp_number", OracleDbType.Varchar2) { Value = epcId },
                }
            };
        }

        static public BarsSql InitSearchRegisterEpc(SearchRegisterEpc qv)
        {
            return new BarsSql()
            {
                SqlText = @"select * from pfu.v_epp_batch
                        where (id = :p_id or :p_id is null)
                        and (batch_date = :p_batch_date or :p_batch_date is null)",
                SqlParams = new object[]
                {
                    new OracleParameter("p_id", OracleDbType.Decimal) { Value = qv.RegisterId },
                    new OracleParameter("p_id", OracleDbType.Decimal) { Value = qv.RegisterId },
                    new OracleParameter("p_batch_date", OracleDbType.Date) { Value = qv.RegisterDate },
                    new OracleParameter("p_batch_date", OracleDbType.Date) { Value = qv.RegisterDate },
                }
            };
        }

        static public BarsSql InitSearchRegisterLinesEpc(SearchRegisterLinesEpc qv)
        {
            return new BarsSql()
            {
                SqlText = @"select * from pfu.v_epp_line
                where (epp_number = :p_epp_number or :p_epp_number is null)
                    and (fio like '%' || :p_fio || '%' or :p_fio is null)
                    and (tax_registration_number= :p_tax_registration_number or :p_tax_registration_number is null)
                    and (state_id = :p_state_id or :p_state_id is null)",
                SqlParams = new object[]
                {
                new OracleParameter("p_epp_number", OracleDbType.Varchar2) { Value = qv.EpcId },
                new OracleParameter("p_epp_number", OracleDbType.Varchar2) { Value = qv.EpcId },
                new OracleParameter("p_fio", OracleDbType.Varchar2) { Value = qv.FullName },
                new OracleParameter("p_fio", OracleDbType.Varchar2) { Value = qv.FullName },
                new OracleParameter("p_tax_registration_number", OracleDbType.Varchar2) { Value = qv.TaxID },
                new OracleParameter("p_tax_registration_number", OracleDbType.Varchar2) { Value = qv.TaxID },
                new OracleParameter("p_state_id", OracleDbType.Decimal) { Value = qv.State },
                new OracleParameter("p_state_id", OracleDbType.Decimal) { Value = qv.State },
                }
            };
        }

        public static BarsSql RecBlocked()
        {
            return new BarsSql()
            {
                SqlText = @"select * from PFU.V_PFU_REC_BLOCK_FM",
                SqlParams = new object[] { }
            };
        }
    }
}

