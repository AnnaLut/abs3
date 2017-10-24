using System;
using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Swift.Infrastructure.DI.Implementation
{
    public class SqlCreatorPositioner
    {
        public static BarsSql PositionerSearch(decimal? Ref)
        {
            string refSql = Ref.HasValue ? string.Format("and ref like '%{0}%'", Ref.Value.ToString()) : "";

            return new BarsSql()
            {
                SqlText = string.Format(@"select
                                ref,
                                tt, 
                                vob,
                                trn_amount,
                                s,
                                nlsa,
                                kv,
                                nlsb,
                                kv2,
                                dk,
                                bank_bic,
                                bank_name,
                                nazn 
                            from 
                                V_SW_CORRACC_DOCS 
                              WHERE DOC_TYPE in ('FACT') {0} order by ref desc", refSql),
                SqlParams = new object[] { }
            };
        }

        public static BarsSql PositionerCorrespondentSearch(int kv, byte pap)
        {
            return new BarsSql()
            {
                SqlText = @"select acc,
                                    nls,
                                    substr(nms,1,38) nms,
                                    kv,
                                    lcv,    
                                    to_char(ostc, 'fm9999999999990.00') ostc, 
                                    to_char(ostb, 'fm9999999999990.00') ostb,
                                    bic
                            from 
                                v_sw_corracc 
                            where kv = :p_kv 
                                    and pap = :p_pap
                            order by kv asc",
                SqlParams = new object[] 
                {
                    new OracleParameter("p_kv", OracleDbType.Int32) { Value = kv },
                    new OracleParameter("p_pap", OracleDbType.Int16) { Value = pap }
                }
            };
        }

        public static BarsSql Action(decimal p_ref, string p_type, decimal? p_acc)
        {
            return new BarsSql()
            {
                SqlText = @"begin 
                                p_positioner(:p_ref, :p_acc, :p_type); 
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_ref", OracleDbType.Decimal) { Value = p_ref },
                    new OracleParameter("p_acc", OracleDbType.Decimal) { Value = p_acc, IsNullable = true },
                    new OracleParameter("p_type", OracleDbType.Varchar2) { Value = p_type }
                }
            };
        }

        public static BarsSql PayNotAcc(decimal p_ref)
        {
            return new BarsSql()
            {
                SqlText = @"begin 
                                bars_swift.genmsg_document_coraccskip(:p_ref); 
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_ref", OracleDbType.Decimal) { Value = p_ref }
                }
            };
        }

        public static BarsSql RefNos(decimal p_ref)
        {
            return new BarsSql()
            {
                SqlText = @"select refl from oper where ref = :p_ref",
                SqlParams = new object[]
                {
                    new OracleParameter("p_ref", OracleDbType.Decimal) { Value = p_ref }
                }
            };
        }
    }
}
