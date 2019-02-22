using Bars.Oracle;
using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;

namespace BarsWeb.Areas.Finmon.Infrastructure.DI.Implementation
{
    public class SqlCreator
    {
        /// <summary>
        /// Довідник правил фінансового моніторингу
        /// </summary>
        /// <returns></returns>
        public static BarsSql FmRules()
        {
            return new BarsSql
            {
                SqlParams = new object[] { },
                SqlText = "SELECT ID, NAME FROM FM_RULES ORDER BY ID"
            };
        }

        public static BarsSql DocumentStatuses()
        {
            return new BarsSql
            {
                SqlParams = new object[] { },
                SqlText = @"select status id, name
                              from finmon_que_status                           
                            union all
                            select '-' status, 'Пусто' name
                              from dual
                             order by 1"
            };
        }

        /// <summary>
        /// Відбір документів по правилам фм
        /// </summary>
        public static BarsSql FmDocumentsByRules(bool count = false)
        {
            string sql = string.Format(@"select 
                                            {0}
                                         from v_finmon_que_oper  
                                         join tmp_fm_checkrules t on v_finmon_que_oper.ref = t.ref
                                         left join finmon_que_status s on v_finmon_que_oper.status = s.status
                                         where 
                                              t.id = bars.user_id() ", count ? "count(*)" : FmSelectRows("t.rules"));
            return new BarsSql
            {
                SqlText = sql,
                SqlParams = new object[] { }
            };
        }

        /// <summary>
        /// Відбір документів по періоду (коли не встановлено відбір по правилам фм)
        /// </summary>
        public static BarsSql FmDocumentsByPeriod(DateTime from, DateTime to, bool count = false)
        {
            string sql = string.Format(@"select 
                                            {0}
                                         from v_finmon_que_oper 
                                         left join finmon_que_status s on v_finmon_que_oper.status = s.status
                                         where 
                                              v_finmon_que_oper.vdat between :p_from and :p_to ", count ? "count(*)" : FmSelectRows("null"));
            return new BarsSql
            {
                SqlText = sql,
                SqlParams = new OracleParameter[] {
                    new OracleParameter("p_from", OracleDbType.Date, from, ParameterDirection.Input),
                    new OracleParameter("p_to", OracleDbType.Date, to, ParameterDirection.Input)
                }
            };
        }

        /// <summary>
        /// Частина запиту для відбору документів (поля які потрібно повернути)
        /// </summary>
        /// <param name="rules"></param>
        /// <returns></returns>
        private static string FmSelectRows(string rules)
        {
            return string.Format(@" v_finmon_que_oper.id,
                                    v_finmon_que_oper.ref,
                                    v_finmon_que_oper.tt,
                                    v_finmon_que_oper.nd,
                                    v_finmon_que_oper.datd DateD,
                                    v_finmon_que_oper.nlsa,
                                    v_finmon_que_oper.s / 100 Sum,
                                    v_finmon_que_oper.sq / 100 SumEquivalent,
                                    v_finmon_que_oper.lcv,
                                    v_finmon_que_oper.mfoa,
                                    v_finmon_que_oper.dk,
                                    v_finmon_que_oper.nlsb,
                                    v_finmon_que_oper.s2 / 100 Sum2,
                                    v_finmon_que_oper.sq2 / 100 SumEquivalent2,
                                    v_finmon_que_oper.lcv2,
                                    v_finmon_que_oper.mfob,
                                    v_finmon_que_oper.sk,
                                    v_finmon_que_oper.vdat VDate,
                                    v_finmon_que_oper.nazn,
                                    v_finmon_que_oper.status,
                                    decode(v_finmon_que_oper.otm,0,null,v_finmon_que_oper.otm) Otm,
                                    v_finmon_que_oper.tobo,
                                    v_finmon_que_oper.opr_vid2 OprVid2,
                                    v_finmon_que_oper.opr_vid3 OprVid3,
                                    v_finmon_que_oper.fio Fio,
                                    v_finmon_que_oper.in_date InDate,
                                    v_finmon_que_oper.comments,
                                    {0} Rules,
                                    nvl(s.name, '-') StatusName,
                                    v_finmon_que_oper.nmka NameA,
                                    v_finmon_que_oper.nmkb NameB,
                                    v_finmon_que_oper.sos,
                                    v_finmon_que_oper.fv2_agg Fv2Agg", rules);
        }

        /// <summary>
        /// Довідник "терористів" 
        /// </summary>
        /// <param name="otm"></param>
        /// <returns></returns>
        public static BarsSql FmTerrorist(int otm)
        {
            return new BarsSql
            {
                SqlText = @"select 
                               origin
                              ,c1
                              ,c4
                              ,c6
                              ,c7
                              ,c8
                              ,c9
                              ,c2
                              ,c13
                              ,c34
                              ,c20
                              ,c5
                              ,c37
                              ,name_hash NameHash
                            from v_finmon_reft where c1 = :p_otm",
                SqlParams = new OracleParameter[] {
                    new OracleParameter("p_otm", OracleDbType.Decimal, otm, ParameterDirection.Input),
                }
            };
        }

        /// <summary>
        /// Пошук параметрів фінансового моніторингу по одному документу
        /// </summary>
        public static BarsSql DocumentFmRules(decimal _ref)
        {
            string sql = @"select
                               v.id, 
                               v.nlsa NlsA, 
                               v.nlsb NlsB,
                               v.datd DateD,
                               v.nazn Nazn,
                               v.lcv Lcv,
                               v.s / 100 Sum,
                               v.mfoa MfoA,
                               v.mfob MfoB,
                               v.nam_a NameA,
                               v.nam_b NameB,
                               v.rnk_a RnkA,
                               v.rnk_b RnkB,
                               v.id_a OkpoA,
                               v.id_b OkpoB,
                               v.kv,
                               v.kv2,
                                case
                                    when f_ourmfo=v.mfoa and v.mfoa!=v.mfob then nvl(v.opr_vid1,'999999999999999') 
                                    when f_ourmfo=v.mfob and v.mfoa!=v.mfob then nvl(v.opr_vid1,'999999999999998') 
                                    else nvl(v.opr_vid1,'999999999999999') 
                                end OprVid1,
                               nvl(v.opr_vid2,'0000') OprVid2,
                               v.comm_vid2 CommVid2,
                               nvl(v.opr_vid3,'000') OprVid3,
                               v.comm_vid3 CommVid3,
                               v.monitor_mode MonitorMode,
                               k2.name K2Name,
                               k3.name K3Name,
                               v.status Status,
                               f_ourmfo OurMfo,
                               case when f_ourmfo=v.mfoa and v.mfoa!=v.mfob then 'A' when f_ourmfo=v.mfob and v.mfoa!=v.mfob then 'B' else 'BOTH' end as Md,
                               v.fv2_agg Fv2Agg,
                               v.fv3_agg Fv3Agg,
                               :p_ref Ref
                          from v_finmon_que_oper v,
                               k_dfm02 k2,
                               k_dfm03 k3
                          where v.ref = :p_ref
                            and nvl(v.opr_vid2,'0000') = k2.code
                            and nvl(v.opr_vid3,'000') = k3.code";
            return new BarsSql
            {
                SqlText = sql,
                SqlParams = new OracleParameter[] {
                    new OracleParameter("p_ref", OracleDbType.Decimal, _ref, ParameterDirection.Input),
                }
            };
        }

        /// <summary>
        /// Пошук параметрів фінансового моніторингу по багатьох документах
        /// </summary>
        public static BarsSql DocumentsFmRules(List<decimal> refs)
        {
            string sql = @"select opr_vid1 OprVid1, opr_vid2 OprVid2, opr_vid3 OprVid3, MD
                            from (select case min(MD)
                                           when 'A' then
                                            '999999999999999'
                                           when 'B' then
                                            '999999999999998'
                                           else
                                            '999999999999999'
                                         end opr_vid1,
                                         opr_vid2,
                                         opr_vid3,
                                         f_ourmfo,
                                         min(MD) as MD,
                                         count(*) over(partition by 1, 2, 3) as cnt
                                    from (select '0000' opr_vid2,
                                                 '000' opr_vid3,
                                                 f_ourmfo as f_mfo,
                                                 case
                                                   when f_ourmfo = v.mfoa and v.mfoa != v.mfob then
                                                    'A'
                                                   when f_ourmfo = v.mfob and v.mfoa != v.mfob then
                                                    'B'
                                                   else
                                                    'BOTH'
                                                 end as MD
                                            from v_finmon_que_oper v
                                           where v.ref in
                                                 (select column_value
                                                    from TABLE(CAST(:p_refs AS number_list)))
                                             and nvl(v.status, 'Z') not in ('B', 'D'))
                                   group by opr_vid2, opr_vid3, MD)
                           where MD != 'BOTH'
                              or cnt = 1";

            OracleParameter pRefs = new OracleParameter("p_refs", OracleDbType.Array, refs.Count, (NumberList)refs.ToArray(), ParameterDirection.Input);
            pRefs.UdtTypeName = "BARS.NUMBER_LIST";

            return new BarsSql
            {
                SqlText = sql,
                SqlParams = new OracleParameter[] {
                    pRefs
                }
            };
        }

        /// <summary>
        /// Запит на отримання даних довідника k_dfm*
        /// </summary>
        /// <param name="code">Для пошуку по коду</param>
        public static BarsSql GetDict(string dictName, string code)
        {
            List<OracleParameter> _params = new List<OracleParameter>();
            string sql = string.Format("select code,name from {0} where (d_close is null or d_close > sysdate)", dictName);
            if (!string.IsNullOrWhiteSpace(code))
            {
                sql += " and code = :p_code ";
                _params.Add(new OracleParameter("p_code", OracleDbType.Varchar2, code, ParameterDirection.Input));
            }

            return new BarsSql
            {
                SqlParams = _params.ToArray(),
                SqlText = sql
            };
        }

        /// <summary>
        /// Запит для отримання даних довідника клієнтів
        /// </summary>
        public static BarsSql GetClientsDict(long? rnk, string okpo, string name)
        {
            List<OracleParameter> _params = new List<OracleParameter>();
            string sql = "select rnk, nmk Name, okpo from V_CUSTOMER_FM where okpo is not null";
            if (null != rnk)
            {
                sql += " and rnk = :p_rnk ";
                _params.Add(new OracleParameter("p_rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input));
            }
            if (!string.IsNullOrWhiteSpace(okpo))
            {
                sql += " and okpo like :p_okpo || '%' ";
                _params.Add(new OracleParameter("p_okpo", OracleDbType.Varchar2, okpo, ParameterDirection.Input));
            }
            if (!string.IsNullOrWhiteSpace(name))
            {
                sql += " and upper(nmk) like :p_name || '%' ";
                _params.Add(new OracleParameter("p_name", OracleDbType.Varchar2, name.ToUpper(), ParameterDirection.Input));
            }

            return new BarsSql
            {
                SqlParams = _params.ToArray(),
                SqlText = sql
            };
        }

        /// <summary>
        /// Запит для отримання даних по клієнту
        /// </summary>
        public static BarsSql GetClientData(long? rnk, string nls, int kv, string mfo, string okpo)
        {
            string sql = @"select c.rnk Rnk, c.nmk Name, c.okpo from customer c
                           where c.rnk = coalesce(to_number(:p_rnk),           -- якщо уже заповнений
                                                 (select a.rnk
                                                  from accounts a 
                                                  where a.nls = :p_nls 
                                                  and a.kv = :p_kv 
                                                  and a.kf = :p_mfo),          -- шукаємо по рахунку
                                                 (select a.rnk
                                                  from accounts a 
                                                  where a.nlsalt = :p_nlsalt
                                                  and a.kv = :p_kvalt
                                                  and a.kf = :p_mfoalt),       -- пошук по альтернативному рахунку
                                                 (select max(co.rnk)           -- шукаємо по окпо в документі - якщо такий клієнт один
                                                  from customer co
                                                  where co.okpo = :p_okpo
                                                  group by co.okpo
                                                  having count(*)=1))";

            OracleParameter[] _params = new OracleParameter[] {
                new OracleParameter("p_rnk", OracleDbType.Decimal , rnk, ParameterDirection.Input),
                new OracleParameter("p_nls", OracleDbType.Varchar2 , nls, ParameterDirection.Input),
                new OracleParameter("p_kv", OracleDbType.Decimal , kv, ParameterDirection.Input),
                new OracleParameter("p_mfo", OracleDbType.Varchar2 , mfo, ParameterDirection.Input),
                new OracleParameter("p_nlsalt", OracleDbType.Varchar2, nls, ParameterDirection.Input),
                new OracleParameter("p_kvalt", OracleDbType.Decimal, kv, ParameterDirection.Input),
                new OracleParameter("p_mfoalt", OracleDbType.Varchar2, mfo, ParameterDirection.Input),
                new OracleParameter("p_okpo", OracleDbType.Varchar2 , okpo, ParameterDirection.Input)
            };

            return new BarsSql
            {
                SqlText = sql,
                SqlParams = _params
            };
        }

        /// <summary>
        /// Формування запиту на отримання історії редагування документу
        /// </summary>
        public static BarsSql GetHistory(string id)
        {
            return new BarsSql
            {
                SqlText = @"SELECT f.mod_date ModDate,
                                   f.mod_type ModType,
                                   t.mod_name Name,
                                   f.user_id UserId,
                                   s.FIO UserName,
                                   f.mod_value OldValue
                              FROM finmon_que_modification f, finmon_que_modtype t, staff$base s
                             WHERE f.mod_type = t.mod_type
                               AND f.id = :p_id
                               AND f.USER_ID = s.ID",
                SqlParams = new object[] {
                    new OracleParameter("p_id", OracleDbType.Decimal , id, ParameterDirection.Input)
                }
            };
        }
    }
}
