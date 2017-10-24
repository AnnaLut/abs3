using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;

namespace BarsWeb.Areas.Swift.Infrastructure.DI.Implementation
{
    public class SqlCreatorApprovals
    {
        public static BarsSql SearchApprovals(string g_grpid)
        {
            return new BarsSql()
            {
                SqlText = @"select swref, mt, trn, sender_bic, sender_name, receiver_bic, receiver_name, currency, amount, vdate, ref, nextvisagrp, editstatus
                            from v_sw_user_visa_msg
                            where nextvisagrp = :strChkGrpId",

                SqlParams = new object[] {
                    new OracleParameter("strChkGrpId", OracleDbType.Varchar2) { Value = g_grpid }
                }
            };
        }

        public static BarsSql ListApprovals()
        {
            return new BarsSql()
            {
                SqlText = @"SELECT * FROM v_sw_user_visa",
                SqlParams = new object[] { }
            };
        }

        public static BarsSql VvisaList(decimal g_cDocRef)
        {
            return new BarsSql()
            {
                SqlText = @"select decode(markid, 0, mark, checkgroup) as OPERATION, decode(markid, 0, username, 1, username, mark) as USERNAME,  markid
                            from v_visalist where ref = :g_cDocRef",

                SqlParams = new object[] {
                    new OracleParameter("g_cDocRef", OracleDbType.Decimal) { Value = g_cDocRef }
                }
            };
        }

        public static BarsSql Approve(decimal cDocRef, decimal cSwRef, decimal nChkGrpId)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                                bars_swift.msgchk_put_checkstamp(:cDocRef, :cSwRef, :nChkGrpId, 1, null);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("cDocRef", OracleDbType.Decimal) { Value = cDocRef },
                    new OracleParameter("cSwRef", OracleDbType.Decimal) { Value = cSwRef },
                    new OracleParameter("nChkGrpId", OracleDbType.Decimal) { Value = nChkGrpId }
                }
            };
        }

        public static BarsSql CanselApprove(decimal cDocRef, decimal cSwRef, decimal nChkGrpId, decimal nBackReasonId)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                                bars_swift.msgchk_put_checkstamp(:cDocRef, :cSwRef, :nChkGrpId, 0, :nBackReasonId);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("cDocRef", OracleDbType.Decimal) { Value = cDocRef },
                    new OracleParameter("cSwRef", OracleDbType.Decimal) { Value = cSwRef },
                    new OracleParameter("nChkGrpId", OracleDbType.Decimal) { Value = nChkGrpId },
                    new OracleParameter("nBackReasonId", OracleDbType.Decimal) { Value = nBackReasonId }
                }
            };
        }

        public static BarsSql CanselReasons()
        {
            return new BarsSql()
            {
                SqlText = @"SELECT * FROM BP_REASON",
                SqlParams = new object[] { }
            };
        }

        public static BarsSql GenFullMessage(decimal sw_ref, decimal mt)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                                bars.bars_swift.gen_full_message(:sw_ref, :mt);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("sw_ref", OracleDbType.Decimal) { Value = sw_ref },
                    new OracleParameter("mt", OracleDbType.Decimal) { Value = mt }
                }
            };
        }
    }
}
