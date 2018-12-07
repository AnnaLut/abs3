using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;


namespace BarsWeb.Areas.Way.Infrastructure.DI.Implementation
{
    public class SqlCreator
    {
        public static BarsSql GetSubContracts(int? nd)
        {
            string sql = nd == null ? @"select * from  v_ow_inst_sub_contr" : @"select * from  v_ow_inst_sub_contr where ND = :nd ";
            var param = nd == null ? new object[] { } : new object[] { new OracleParameter(":nd", OracleDbType.Decimal, nd, ParameterDirection.Input) };

            return new BarsSql()
            {
                SqlText = sql,
                SqlParams = param
            };
        }

        public static BarsSql GetSubContracts(int[] states, int? nd)
        {
            string sql = nd == null 
                ? "select * from v_ow_inst_sub_contr where ST_ID in ({0})"
                : "select * from  v_ow_inst_sub_contr where ND = :nd AND ST_ID in ({0})";

            var paramsNamesList = new List<string>();
            var oraParamsList = new List<object>();

            if (nd != null)
            {
                oraParamsList.Add(new OracleParameter(":nd", OracleDbType.Decimal, nd, ParameterDirection.Input));
            }

            for (int i = 0; i < states.Length; i++)
            {
                paramsNamesList.Add(":p_state_" + i);
                oraParamsList.Add(new OracleParameter(":p_state_" + i, OracleDbType.Decimal, states[i], ParameterDirection.Input));
            }

            return new BarsSql()
            {
                SqlText = string.Format(sql, string.Join(", ", paramsNamesList.ToArray())),
                SqlParams = oraParamsList.ToArray()
            };
        }

        public static BarsSql GetPayments(int chainIdt)
        {
            return new BarsSql()
            {
                SqlText = @"select * from  v_ow_inst_sub_pay where chain_idt = :chainIdt  order by seq_number",
                SqlParams = new object[] 
                {
                    new OracleParameter(":chainIdt", OracleDbType.Decimal, chainIdt, ParameterDirection.Input)
                }
            };
        }

        public static BarsSql GetPayments(int chainIdt, int[] states)
        {
            string sql = "select * from  v_ow_inst_sub_pay where chain_idt = :chainIdt AND ST_ID in ({0}) order by seq_number";

            var paramsNamesList = new List<string>();
            var oraParamsList = new List<object>() { new OracleParameter(":chainIdt", OracleDbType.Decimal, chainIdt, ParameterDirection.Input) };

            for (int i = 0; i < states.Length; i++)
            {
                paramsNamesList.Add(":p_state_" + i);
                oraParamsList.Add(new OracleParameter(":p_state_" + i, OracleDbType.Decimal, states[i], ParameterDirection.Input));
            }

            return new BarsSql()
            {
                SqlText = string.Format(sql, string.Join(", ", paramsNamesList.ToArray())),
                SqlParams = oraParamsList.ToArray()
            };
        }

        public static BarsSql GetAccounts(int chainIdt)
        {
            return new BarsSql()
            {
                SqlText = @"select * from  v_ow_inst_acc where chain_idt = :chainIdt",
                SqlParams = new object[] 
                {
                    new OracleParameter(":chainIdt", OracleDbType.Decimal, chainIdt, ParameterDirection.Input)
                }
            };
        }

        public static BarsSql GetStatuses()
        {
            return new BarsSql()
            {
                SqlText = @"select ST_ID as value, ST_NAME as text from ow_inst_status_dict",
                SqlParams = new object[] { }
            };
        }
    }
}