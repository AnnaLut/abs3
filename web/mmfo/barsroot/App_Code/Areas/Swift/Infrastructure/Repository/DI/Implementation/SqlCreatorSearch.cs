using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;
using System.Text;

namespace BarsWeb.Areas.Swift.Infrastructure.DI.Implementation
{
    public class SqlCreatorSearch
    {
        public static BarsSql SearchMain(string text, DateTime d1, DateTime d2)
        {
            return new BarsSql()
            {
                SqlText = @"select swref, io_ind, mt, trn, sender, receiver,
                            currency, amount/100 amount, date_rec, date_pay, vdate, ref 
                            from v_sw_searchmsg 
                            where 1=1 and bars_swift.get_message_condition(swref, :p_text) = 1 
                             and vdate>=:p_d1",
                SqlParams = new object[]
                {
                    new OracleParameter("p_text", OracleDbType.Varchar2) { Value = text },
                    new OracleParameter("p_d1", OracleDbType.Date) { Value = d1 }
                    //new OracleParameter("p_d2", OracleDbType.Date) { Value = d2 }
                }
            };
        }
    }
}
