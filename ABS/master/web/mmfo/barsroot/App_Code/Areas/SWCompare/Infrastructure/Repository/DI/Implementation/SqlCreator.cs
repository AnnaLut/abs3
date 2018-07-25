using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.SWCompare.Models;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;

namespace BarsWeb.Areas.SWCompare.Infrastructure.DI.Implementation
{
    public class SqlCreator
    {
        public static BarsSql SearchMain(string DateFrom, string DateTo, string Type)
        {
            string sql = @" select 
                                * 
                            from v_sw_compare_list 
                            where 
                                type in ({0}) 
                                and ddate >= to_date(:p_from, 'DD.MM.YYYY')
                                and ddate <= to_date(:p_to, 'DD.MM.YYYY')";

            List<string> paramsNamesList = new List<string>();
            List<object> oraParamsList = new List<object>();

            string[] typeArr = Type.Split(',');
            for (int i = 0; i < typeArr.Length; i++)
            {
                paramsNamesList.Add(":p_type_" + i);
                oraParamsList.Add(new OracleParameter("p_type_" + i, OracleDbType.Decimal, typeArr[i], ParameterDirection.Input));
            }

            oraParamsList.Add(new OracleParameter("p_from", OracleDbType.Varchar2, 4000, DateFrom, ParameterDirection.Input));
            oraParamsList.Add(new OracleParameter("p_to", OracleDbType.Varchar2, 4000, DateTo, ParameterDirection.Input));

            return new BarsSql()
            {
                SqlText = string.Format(sql, string.Join(", ", paramsNamesList.ToArray())),
                SqlParams = oraParamsList.ToArray()
            };
        }

        public static BarsSql SerchTickets(string ID_C)
        {
            return new BarsSql()
            {
                SqlText = string.Format(@"select * from v_sw_compare where id = {0}", ID_C),
                SqlParams = new object[] { }
            };
        }

        public static BarsSql GetBranchNames()
        {
            return new BarsSql()
            {
                SqlText = @"select t.KF, t.BRANCH_NAME from V_SW_BRANCH_WS_PARAMETERS t",
                SqlParams = new object[] { }
            };
        }

        public static BarsSql GetNBU()
        {
            return new BarsSql()
            {
                SqlText = @"select t.KOD_NBU, t.NAME from V_SWI_MTI_LIST_LIGHT t",
                SqlParams = new object[] { }
            };
        }

        public static BarsSql ResolveDifference(ResolveModel resolveModel)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                                pkg_sw_compare.resolve_cause(:p_id, :comments);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_id", OracleDbType.Decimal).Value = resolveModel.p_id,
                    new OracleParameter("comments", OracleDbType.Varchar2).Value = resolveModel.comment
                }
            };
        }

        public static BarsSql DeleteСompare(ResolveModel resolveModel)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                                pkg_sw_compare.del_compare_data(:p_id);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_id", OracleDbType.Decimal).Value = resolveModel.p_id
                }
            };
        }

        public static BarsSql HandFixing(HandModel handModel)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                                pkg_sw_compare.compare_data_hand(:p_kod_nbu,
                                :p_ref, :p_tt, :p_transactionid, :p_operation, :p_ddate_oper, :p_prn_file, :p_kf, :p_comments);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_kod_nbu",  OracleDbType.Varchar2).Value = handModel.p_kod_nbu,
                    new OracleParameter("p_ref", OracleDbType.Decimal).Value = handModel.p_ref,
                    new OracleParameter("p_tt", OracleDbType.Varchar2).Value = handModel.p_tt,
                    new OracleParameter("p_transactionid", OracleDbType.Varchar2).Value = handModel.p_transactionid,
                    new OracleParameter("p_operation", OracleDbType.Decimal).Value = handModel.p_operation,
                    new OracleParameter("p_ddate_oper", OracleDbType.Date).Value = handModel.p_ddate_oper,
                    new OracleParameter("p_prn_file", OracleDbType.Decimal).Value = handModel.p_prn_file,
                    new OracleParameter("p_kf", OracleDbType.Varchar2).Value = handModel.p_kf,
                    new OracleParameter("p_comments", OracleDbType.Varchar2).Value = handModel.p_comments
                }
            };
        }

        public static BarsSql ZsRowCount(ZsPostModel zsPostModel)
        {
            return new BarsSql()
            {
                SqlText = @"select pkg_sw_compare.get_row_count(:p_date, :p_kod_nbu) from dual",
                SqlParams = new object[]
                {
                    new OracleParameter("p_date", OracleDbType.Date).Value = zsPostModel.p_date,
                    new OracleParameter("p_kod_nbu", OracleDbType.Varchar2).Value = zsPostModel.p_kod_nbu
                }
            };
        }

        public static BarsSql RuRowCount(RuPostModel ruPostModel)
        {
            return new BarsSql()
            {
                SqlText = @"select pkg_sw_compare.get_own_row_count(:p_date, :p_mfo) from dual",
                SqlParams = new object[]
                {
                    new OracleParameter("p_date", OracleDbType.Date).Value = ruPostModel.p_date,
                    new OracleParameter("p_mfo", OracleDbType.Varchar2).Value = ruPostModel.p_mfo
                }
            };
        }

        public static BarsSql GetUser()
        {
            return new BarsSql()
            {
                SqlText = @"select sys_context('bars_context','user_branch') as NAME from dual",
                SqlParams = new object[] { }
            };
        }
    }
}
