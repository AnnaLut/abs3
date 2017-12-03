using BarsWeb.Areas.Kernel.Models;
using iTextSharp.text;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Text;

namespace BarsWeb.Areas.Way4Bpk.Infrastructure.DI.Implementation {
    public class SqlCreator
    {
  
        public static BarsSql SearchMain(string custName, string okpo, long? ndNumber, long? accNls, int? passState, string passDateStrs)
        {
            List<OracleParameter> paramsList = new List<OracleParameter>();
            StringBuilder sql = new StringBuilder("select * from W4_DEAL_WEB where ");
            if (ndNumber.HasValue)
            {
                sql.Append("nd = :P_ND ");
                paramsList.Add(new OracleParameter("P_ND", OracleDbType.Long) { Value = ndNumber.Value });
            }
            if (accNls.HasValue)
            {
                if (ndNumber.HasValue) { sql.Append("and "); }
                sql.Append("acc_nls = :p_acc_nls ");
                paramsList.Add(new OracleParameter("p_acc_nls", OracleDbType.Long) { Value = accNls.Value });
            }
            if (!string.IsNullOrEmpty(custName))
            {
                if (ndNumber.HasValue || accNls.HasValue) { sql.Append("and "); }
                sql.Append("cust_name like '%' || :p_cust_name || '%'");
                paramsList.Add(new OracleParameter("p_cust_name", OracleDbType.Varchar2) { Value = custName });
            }
            if (!string.IsNullOrEmpty(okpo))
            {
                if (ndNumber.HasValue || accNls.HasValue || !string.IsNullOrEmpty(custName)) { sql.Append("and "); }
                sql.Append("cust_okpo = :p_cust_okpo ");
                paramsList.Add(new OracleParameter("p_cust_okpo", OracleDbType.Varchar2) { Value = okpo });
            }
            if (passState.HasValue)
            {
                if (ndNumber.HasValue || accNls.HasValue || !string.IsNullOrEmpty(custName) || !string.IsNullOrEmpty(okpo)) { sql.Append("and "); }
                sql.Append("pass_state = :p_pass_state ");
                paramsList.Add(new OracleParameter("p_pass_state", OracleDbType.Int32) { Value = passState });
                if (!string.IsNullOrEmpty(passDateStrs))
                {
                    sql.Append("and pass_date = :p_pass_date ");
                    DateTime dt = DateTime.ParseExact(passDateStrs, "dd.MM.yyyy", CultureInfo.InvariantCulture);
                    paramsList.Add(new OracleParameter("p_pass_date", OracleDbType.Date) { Value = dt });
                }
            }

            return new BarsSql()
            {
                SqlText = sql.ToString(),
                SqlParams = paramsList.ToArray()
            };

        }

        public static BarsSql AddDealToCmque(long ND, int oper_type)
        {
            return new BarsSql()
            {
                SqlText = @"begin 
                                bars_ow.add_deal_to_cmque(:ND, :oper_type); 
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("ND", OracleDbType.Long) { Value = ND },
                    new OracleParameter("oper_type", OracleDbType.Int32) { Value = oper_type }
                }
            };
        }
        public static BarsSql SubProduct(string code)
        {
            return new BarsSql()
            {
                SqlText = @"SELECT W4_SUBPRODUCT.code SUBPRODUCT_CODE, W4_SUBPRODUCT.name, w4_CARD.CODE
                              FROM w4_card, W4_SUBPRODUCT
                             WHERE W4_CARD.SUB_CODE =      W4_SUBPRODUCT.CODE and
                             NVL (w4_card.date_open, bankdate) <= bankdate
                                   AND NVL (w4_card.date_close, bankdate + 1) > bankdate
                                   AND w4_card.code IN (SELECT d.code
                                                          FROM w4_card c, w4_product p, w4_card d
                                                         WHERE     c.code = :p_code
                                                               AND c.product_code = p.code
                                                               AND p.grp_code <> 'SALARY'
                                                               AND c.product_code = d.product_code
                                                               AND d.code <> :p_code
                                                        UNION
                                                        SELECT d.code
                                                          FROM w4_card c,
                                                               w4_product p,
                                                               w4_card d,
                                                               bpk_proect b,
                                                               bpk_proect_card t
                                                         WHERE     c.code = :p_code
                                                               AND c.product_code = p.code
                                                               AND p.grp_code = 'SALARY'
                                                               AND c.product_code = d.product_code
                                                               AND d.code <> :p_code
                                                               AND d.product_code = b.product_code
                                                               AND b.okpo = t.okpo
                                                               AND NVL (b.okpo_n, 0) = t.okpo_n
                                                               AND d.code = t.card_code)",
                SqlParams = new object[]
                {
                    new OracleParameter("p_code", OracleDbType.Varchar2) { Value = code },
                    new OracleParameter("p_code", OracleDbType.Varchar2) { Value = code },
                    new OracleParameter("p_code", OracleDbType.Varchar2) { Value = code },
                    new OracleParameter("p_code", OracleDbType.Varchar2) { Value = code }
                }
            };
        }

        public static BarsSql SetPassDate(long nD, int passState, DateTime dt)
        {
            return new BarsSql()
            {
                SqlText = @"begin 
                                bars_ow.set_pass_date(:p_nd, :p_pass_date, :p_pass_state); 
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_nd", OracleDbType.Long) { Value = nD },
                    new OracleParameter("p_pass_date", OracleDbType.Date) { Value = dt },
                    new OracleParameter("p_pass_state", OracleDbType.Int32) { Value = passState }
                }
            };
        }

        public static BarsSql CngCard(long ND, string code)
        {
            return new BarsSql()
            {
                SqlText = @"begin 
                                bars_ow.cng_card(:ND, :sCardCode); 
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("ND", OracleDbType.Long) { Value = ND },
                    new OracleParameter("sCardCode", OracleDbType.Varchar2) { Value = code }
                }
            };
        }

        public static BarsSql UserBranch()
        {
            return new BarsSql()
            {
                SqlText = @"select sys_context('bars_context','user_branch') from dual",
                SqlParams = new object[] { }
            };
        }
    }
}
