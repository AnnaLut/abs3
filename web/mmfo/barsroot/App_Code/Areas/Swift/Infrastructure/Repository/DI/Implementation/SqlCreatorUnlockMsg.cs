using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.Swift.Infrastructure.DI.Implementation
{
    public class SqlCreatorUnlockMsg
    {
        public static BarsSql SwiUnlockMsg(string mt)
        {
            string mtSql = mt == "950" ? "and mt=950" : (mt == "3_0" ? "and mt in(300, 320)" : "and mt in(950, 910, 300, 320, 103, 202, 190, 200)");
            return new BarsSql()
            {
                SqlText = string.Format(@"SELECT swref, mt, trn, 
                                                sender_bic as SENDER, sender_name,
                                                receiver_bic as RECEIVER, receiver_name,
                                                currency, (NVL(amount, 0)/100) AMOUNT,
                                                date_rec, date_pay, vdate
                                           FROM v_sw_procmsg
                                             WHERE expstatus = 1 {0}", mtSql),
                SqlParams = new object[] { }
            };
        }

        public static BarsSql SwiUnlockMsgAction(string aType, decimal swref, int p_retOpt)
        {
            string proc = string.Empty;
            List<object> p = new List<object>() { new OracleParameter("p_swref", OracleDbType.Decimal) { Value = swref } };
            if (aType == "Delete")
            {
                p.Add(new OracleParameter("p_retOpt", OracleDbType.Decimal) { Value = p_retOpt });
                proc = "bars_swift.expmsg_delete_message(:sw_ref, :p_retOpt);";
            }
            else    //Unblock
            {
                proc = "bars_swift.unlock_message(:sw_ref);";
            }

            return new BarsSql()
            {
                SqlText = string.Format(@"begin
                                {0}
                            end;", proc),
                SqlParams = p.ToArray()
            };
        }        

        public static BarsSql SwiUnlockMsgView(decimal swref)
        {
            return new BarsSql()
            {
                SqlText = @"SELECT CHR (10) || LISTAGG (LPAD (TAG || OPT || ': ', 6) || REPLACE (VALUE, CHR (10), (CHR (10) || '      ')), CHR (10))
                                  WITHIN GROUP (ORDER BY N, TAG, SEQ)
                                  RESULT
                          FROM sw_operw
                         WHERE swref = :p_swref",
                SqlParams = new object[]
                {
                    new OracleParameter("p_swref", OracleDbType.Decimal) { Value = swref }
                }
            };
        }
    }
}
