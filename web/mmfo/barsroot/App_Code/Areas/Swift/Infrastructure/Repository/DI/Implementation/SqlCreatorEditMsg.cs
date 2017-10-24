using System;
using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using Areas.Swift.Models;

namespace BarsWeb.Areas.Swift.Infrastructure.DI.Implementation
{
    public class SqlCreatorEditMsg
    {
        public static BarsSql SwiEditMsgSearch(decimal swref)
        {
            return new BarsSql()
            {
                SqlText = @"SELECT num, seq, subseq, tag, opt, status, empty, seqstat, value, optmodel, editval, swref
                            FROM tmp_sw_message where userid = user_id() and swref = :p_swref 
                            order by num",
                SqlParams = new object[]
                {
                    new OracleParameter("p_swref", OracleDbType.Decimal) { Value = swref }
                }
            };
        }

        public static BarsSql SwOpt()
        {
            return new BarsSql()
            {
                SqlText = @"select * from SW_OPT",
                SqlParams = new object[] { }
            };
        }

        public static BarsSql SwOpt(int mt)
        {
            return new BarsSql()
            {
                SqlText = @"select * from sw_model_opt t where T.MT = :P_MT",
                SqlParams = new object[] 
                {
                    new OracleParameter("P_MT", OracleDbType.Int32) { Value = mt }
                }
            };
        }

        public static BarsSql SwiReceiverSender(decimal swref)
        {
            return new BarsSql()
            {
                SqlText = @"select j.sender, b.name name_sender, j.receiver, b2.name name_receiver
                             from sw_journal j, sw_banks b, sw_banks b2 
                             where j.swref = :p_swref
                             and J.SENDER = B.BIC
                             and j.receiver = b2.bic",
                SqlParams = new object[]
                {
                    new OracleParameter("p_swref", OracleDbType.Decimal) { Value = swref }
                }
            };
        }

        public static BarsSql Save(SwiEditMsg obj)
        {
            return new BarsSql()
            {
                SqlText = @"begin  
                                update tmp_sw_message t
                                set t.value = :p_value, 
                                    t.opt = :p_opt
                                where t.swref = :p_swref 
                                      and t.num = :p_num 
                                      and userid = user_id;
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_value", OracleDbType.Varchar2) { Value = obj.value },
                    new OracleParameter("p_opt", OracleDbType.Char) { Value = obj.opt },
                    new OracleParameter("p_swref", OracleDbType.Decimal) { Value = obj.swref },
                    new OracleParameter("p_num", OracleDbType.Int64) { Value = obj.num }
                }
            };
        }

        public static BarsSql UpdateMsg(decimal swref, int mt)
        {
            return new BarsSql()
            {
                SqlText = @"begin 
                                bars_swift.update_message(:p_swref, :p_mt); 
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_swref", OracleDbType.Decimal) { Value = swref },
                    new OracleParameter("p_mt", OracleDbType.Int64) { Value = mt }                    
                }
            };
        }

        public static BarsSql ClearTmpMsg(decimal swref)
        {
            return new BarsSql()
            {
                SqlText = @"begin 
                                delete from tmp_sw_message 
                                where userid=user_id() 
                                    and swref = :swref; 
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("swref", OracleDbType.Decimal) { Value = swref }
                }
            };
        }
    }
}
