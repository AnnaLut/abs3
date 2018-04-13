using System;
using System.Collections.Generic;
using System.Linq;
using Areas.Zay.Models;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Zay.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Models;
using Kendo.Mvc.UI;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Implementation
{
    public class MandatorySaleRepository : IMandatorySaleRepository
    {
        private readonly ZayModel _entities;
        private readonly IZayParams _zayParams;
        private readonly IParamsRepository _kernelParams;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;
        private BarsSql _basicSql;
        private BarsSql _zayDocSql;
        private int _baseval = - 1;
        public MandatorySaleRepository(IZayParams zayParams, IKendoSqlTransformer kendoSqlTransformer, IKendoSqlCounter kendoSqlCounter, IParamsRepository kernelParams)
        {
            var connectionStr = EntitiesConnection.ConnectionString("ZayModel", "Zay");
            _entities = new ZayModel(connectionStr);
            _zayParams = zayParams;
            _sqlTransformer = kendoSqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
            _kernelParams = kernelParams;
        }
        private int GetBaseVal()
        {
            if (_baseval < 0)
            {
                int baseval = 0;
                int.TryParse(_kernelParams.GetParam("BASEVAL").Value, out baseval); 
            }
            return _baseval;
        }
        private bool ZayDebtExist(decimal refDoc)
        {
            var sql = new BarsSql()
            {
                SqlText = "SELECT ref FROM zay_debt WHERE ref = :p_ref and rownum = 1",
                SqlParams = new object[] {new OracleParameter("p_ref", OracleDbType.Decimal).Value = refDoc}
            };
            decimal? firstRef = _entities.ExecuteStoreQuery<decimal>(sql.SqlText, sql.SqlParams).SingleOrDefault();
            return firstRef != null && firstRef > 0;
        }
        private bool CheckAndCloseDoc(decimal refDoc)
        {
            //! Проверка на урегулированность
            var checkSql = new BarsSql()
            {
                SqlText = @"SELECT sum(decode(z.ref,z.refd,z.zay_sum,o2.s)) sum
                    FROM oper o1, oper o2, zay_debt z
                    WHERE o1.ref=z.ref AND o2.ref=z.refd AND
                          o1.sos=5     AND o2.sos=5      AND
                          z.ref=:p_ref
                    GROUP BY z.ref, o1.s
                    HAVING o1.s<=sum(decode(z.ref,z.refd,z.zay_sum,o2.s))",
                SqlParams = new[] { new OracleParameter("p_ref", OracleDbType.Decimal).Value = refDoc }
            };

            decimal? checkResult = _entities.ExecuteStoreQuery<decimal>(checkSql.SqlText, checkSql.SqlParams).SingleOrDefault();
            if (checkResult != null && checkResult != 0)
            {
                //! "Закрываем" документ
                var closeSql = new BarsSql()
                {
                    SqlText = @"UPDATE zay_debt SET sos=1 WHERE ref=:p_ref",
                    SqlParams = new[] { new OracleParameter("p_ref", OracleDbType.Decimal).Value = refDoc }
                };
                _entities.ExecuteStoreCommand(closeSql.SqlText, closeSql.SqlParams);
            }
            return false;
        }

        private decimal GetZaySum(decimal refDoc)
        {
            decimal result = 0;
            var sums =
                _entities.ExecuteStoreQuery<decimal>(@"SELECT z.zay_sum/power(10,t.dig)
                    FROM zay_debt z, oper o, tabval t 
                    WHERE z.ref=:p_ref  AND z.ref=z.refd AND z.tip=2 AND
                          z.ref=o.ref AND o.kv=t.kv",
                new OracleParameter("p_ref", OracleDbType.Decimal).Value = refDoc).ToList();
            if (sums.Any())
            {
                result = sums.First();
            }
            return result;
        }

        private decimal GetPayedSum(decimal refDoc)
        {
            decimal result = 0;
            var sums =
                _entities.ExecuteStoreQuery<decimal>(@"SELECT sum(o.s)/power(10,t.dig)
                    FROM zay_debt z, oper o, oper o2, tabval t
                    WHERE z.ref=:p_ref   AND o.ref=z.refd AND 
                          z.ref<>z.refd AND  o.sos>0 AND
                          z.ref=o2.ref  AND o2.kv=t.kv
                    GROUP BY t.dig",
                new OracleParameter("p_ref", OracleDbType.Decimal).Value = refDoc).ToList();
            if (sums.Any())
            {
                result = sums.First();
            }
            return result;
        }
        private decimal GetTip(decimal refDoc, decimal kv)
        {
            if (kv == GetBaseVal())
            {
                return 1;
            }
            var zayDebt = _entities.ExecuteStoreQuery<decimal>("SELECT nvl(tip,2) tip  FROM zay_debt  WHERE ref = :p_ref",
                new object[] {new OracleParameter("p_ref", OracleDbType.Decimal).Value = refDoc}).ToList();
            if (zayDebt.Any())
            {
                return zayDebt.First();
            }
            return 2;
        }

        private void InitZayDocSql(decimal refDoc )
        {
            if (_zayDocSql != null) return;
            _zayDocSql = new BarsSql()
            {
                SqlParams = new object[] { new OracleParameter("p_ref", OracleDbType.Decimal).Value = refDoc },
                SqlText = @"SELECT a.mfoa, a.mfob, a.nlsa, a.nlsb, 
                     a.s, a.kv, v.lcv, v.dig, a.userid,
                     a.s2, a.kv2, v2.lcv lcv2, v2.dig dig2, 
                     a.sk, a.dk, a.vob, a.datd, a.vdat, a.tt, a.ref, a.sos, 
                     a.nd, a.nazn, a.id_a refa, a.nam_a nama, a.id_b refb, a.nam_b namb , a.tobo 
                     FROM OPER a, tabval$global v, tabval$global v2 
                     WHERE a.kv=v.kv(+) and a.kv2=v2.kv(+) 
                     and ( a.ref IN (SELECT refd FROM zay_debt WHERE refd<>ref AND ref=:p_ref)) 
                     ORDER BY a.ref"
            };
        }


        private void InitBasicSql()
        {
            if (_basicSql != null) return;

            var nobz1919 = _zayParams.GetParam("OBZ_1919");
            _basicSql = new BarsSql()
            {
                SqlText = @"SELECT c.rnk, c.nmk, a.acc, a.kv, t.lcv iso, a.nls, o.ref, o.s/power(10,t.dig) suma,  
                        o.fdat vdat, dat_next_u(o.fdat,1) dat5, t.dig
                       ,(select least(count(*), 1) from zay_debt_klb zk where zk.rnk = c.rnk AND zk.kv2 = a.kv AND zk.datz = o.fdat) kb
                       ,(select count(*) from fdat fd where fd.fdat >= o.fdat AND fd.fdat <= bankdate) dni
                       ,(SELECT count(0) FROM zay_debt zd WHERE zd.ref=zd.refd AND zd.ref=o.REF) zay 
                  FROM accounts a, customer c, tabval t, opldok o
                  WHERE a.nbs = '2603'
                    AND a.kv <> 980
                    AND a.rnk = c.rnk
                    AND a.kv  = t.kv
                    AND a.acc = o.acc
                    AND o.fdat >= dat_next_u(bankdate,-1) and o.fdat <= bankdate
                    AND o.dk  = 1
                    AND o.sos = 5
                    AND o.ref NOT IN (SELECT DISTINCT ref FROM zay_debt)
                  UNION ALL
                 SELECT c.rnk, c.nmk, a.acc, a.kv, t.lcv, a.nls, oper.ref, oper.s/power(10,t.dig), 
                                           oper.vdat, dat_next_u(oper.vdat,1), t.dig
                                          ,(select least(count(*), 1) from zay_debt_klb zk where zk.rnk = c.rnk AND zk.kv2 = a.kv AND zk.datz = oper.vdat) kb     
                                          ,(select count(*) from fdat fd where fd.fdat >= oper.vdat AND fd.fdat <= bankdate) dni
                                          ,(SELECT count(0) FROM zay_debt zd WHERE zd.ref=zd.refd AND zd.ref=oper.REF) zay  
                   FROM accounts a, customer c, tabval t, oper, zay_debt z
                  WHERE a.nbs = '2603'
                    AND a.kv <> 980 
                    AND a.rnk = c.rnk
                    AND a.kv  = t.kv
                    AND a.nls = decode(oper.dk,1,oper.nlsb,oper.nlsa)
                    AND a.kv  = decode(oper.dk,1,nvl(oper.kv2,oper.kv),oper.kv)
                    AND oper.sos = 5
                    AND oper.ref = z.ref
                    AND z.sos = 0
                    AND z.refd IS NULL
                  ORDER BY  4, 1, 9, 7 desc",
                SqlParams = new object[] { }
            };

            if (nobz1919 != null && nobz1919.Value == "1")
            {
                _basicSql.SqlText = @"SELECT c.rnk, c.nmk, a.acc, a.kv, t.lcv iso, a.nls, o.ref, o.s/power(10,t.dig) suma,  
                        o.fdat vdat, dat_next_u(o.fdat,1) dat5, t.dig
                       ,(select least(count(*), 1) from zay_debt_klb zk where zk.rnk = c.rnk AND zk.kv2 = a.kv AND zk.datz = o.fdat) kb
                       ,(select count(*) from fdat fd where fd.fdat >= o.fdat AND fd.fdat <= bankdate) dni
                       ,(SELECT count(0) FROM zay_debt zd WHERE zd.ref=zd.refd AND zd.ref=o.REF) zay 
                    FROM accounts a, customer c, opldok o, tabval t
                    WHERE (a.nbs = '2603' or (a.nls,a.kv) in (select nls, kv from v_zay_ndr_1919))
                    AND a.kv <> 980
                    AND a.rnk = c.rnk
                    AND a.kv  = t.kv
                    AND a.acc = o.acc
                    AND o.fdat >= dat_next_u(bankdate,-1) and o.fdat <= bankdate
                    AND o.dk  = 1
                    AND o.sos = 5
                    AND o.ref NOT IN (SELECT DISTINCT ref FROM zay_debt)
                    UNION ALL
                    SELECT c.rnk, c.nmk, a.acc, a.kv, t.lcv, a.nls, oper.ref, oper.s/power(10,t.dig), 
                        oper.vdat, dat_next_u(oper.vdat,1), t.dig
                        ,(select least(count(*), 1) from zay_debt_klb zk where zk.rnk = c.rnk AND zk.kv2 = a.kv AND zk.datz = oper.vdat) kb     
                        ,(select count(*) from fdat fd where fd.fdat >= oper.vdat AND fd.fdat <= bankdate) dni
                        ,(SELECT count(0) FROM zay_debt zd WHERE zd.ref=zd.refd AND zd.ref=oper.REF) zay 
                    FROM accounts a, customer c, tabval t, oper, zay_debt z
                    WHERE (a.nbs='2603' or (a.nls,a.kv) in (select nls, kv from v_zay_ndr_1919))
                    AND a.kv <> 980
                    AND a.rnk = c.rnk
                    AND a.kv  = t.kv
                    AND a.nls = decode(oper.dk,1,oper.nlsb,oper.nlsa)
                    AND a.kv  = decode(oper.dk,1,nvl(oper.kv2,oper.kv),oper.kv)
                    AND oper.sos = 5
                    AND oper.ref = z.ref
                    AND z.sos = 0
                    AND z.refd IS NULL
                    ORDER BY  4, 1, 9, 7 desc ";
              }
        }
        public IEnumerable<Models.MandatorySale> GetMandatorySaleList(DataSourceRequest request)
        {
            InitBasicSql();
            var sql = _sqlTransformer.TransformSql(_basicSql, request);
            var result = _entities.ExecuteStoreQuery<MandatorySale>(sql.SqlText, sql.SqlParams).ToList();
            decimal mandatoryPercent = 50;
            var nobzProc = _zayParams.GetParam("OBZ_PROC");
            if (nobzProc != null)
            {
                mandatoryPercent = Convert.ToDecimal(nobzProc.Value);
            }
            foreach (var row in result)
            {
                row.Tip = GetTip(row.Ref, row.Kv);
                row.Payed = GetPayedSum(row.Ref);
                if (row.Tip == 2)
                {
                    if (row.Zay == 0)
                    {
                        row.S1s = row.Suma*mandatoryPercent/100;
                    }
                    else
                    {
                        row.S1s = GetZaySum(row.Ref);
                    }
                    row.S2s = row.Suma - row.S1s - row.Payed;
                }
                else
                {
                    row.S1s = 0;
                    row.S2s = row.Suma - row.Payed;
                }
            }

            return result;
        }

        public decimal GetMandatorySaleCount(DataSourceRequest request)
        {
            InitBasicSql();
            var total = _entities.ExecuteStoreQuery<decimal>(_kendoSqlCounter.TransformSql(_basicSql, null).SqlText, _basicSql.SqlParams).Single();
            return total;
        }

        public void DelZay(decimal refDoc)
        {
            _entities.ExecuteStoreCommand("UPDATE zay_debt SET sos = 1 WHERE ref=:p_ref", 
                 new OracleParameter("p_ref", OracleDbType.Decimal).Value = refDoc);
        }

        public IEnumerable<ZayDoc> GetZayLinkedDocs(decimal refDoc, DataSourceRequest request)
        {
            InitZayDocSql(refDoc);
            var transformedSql = _sqlTransformer.TransformSql(_zayDocSql, request);
            return _entities.ExecuteStoreQuery<ZayDoc>(transformedSql.SqlText, transformedSql.SqlParams);
        }

        public decimal GetZayLinkedDocCount(decimal refDoc, DataSourceRequest request)
        {
            InitZayDocSql(refDoc);
            return
                _entities.ExecuteStoreQuery<decimal>(_kendoSqlCounter.TransformSql(_zayDocSql, request).SqlText,
                    _zayDocSql.SqlParams).Single();
        }

        public string GetOperNazn(decimal refDoc)
        {
            return _entities.ExecuteStoreQuery<string>("SELECT nazn FROM oper WHERE ref = :p_ref",
                new OracleParameter("p_ref", OracleDbType.Decimal).Value = refDoc).SingleOrDefault();
        }
        public void DoZayDebt(ZayDebt bidParams)
        {
            var operType = _entities.ExecuteStoreQuery<int>("select 1 from zay_debt where ref=:p_ref",
                new OracleParameter("p_ref", OracleDbType.Decimal).Value = bidParams.nRef).SingleOrDefault();
            if (operType == 0)
            {
                _entities.P_ZAYDEBT(
               mOD_: bidParams.nMod,
               aCC_: bidParams.nAcc,
               rEF_: bidParams.nRef,
               s1_: bidParams.nSum1,
               s2_: bidParams.nSumOper,
               d27_1: bidParams.d27_1,
               d27_2: bidParams.d27_2,
               nAMEKB_: bidParams.sFnameKb,
               iDKB_: bidParams.sIdKb,
               nAZN_: bidParams.nNazn,
               sOPER_: bidParams.nSumOper);
            }
            else
            {
                _entities.P_ZAYDEBT(
              mOD_: bidParams.nMod,
              aCC_: bidParams.nAcc,
              rEF_: bidParams.nRef,
              s1_: bidParams.nSum1,
              s2_: bidParams.nSum2,
              d27_1: bidParams.d27_1,
              d27_2: bidParams.d27_2,
              nAMEKB_: bidParams.sFnameKb,
              iDKB_: bidParams.sIdKb,
              nAZN_: bidParams.nNazn,
              sOPER_: bidParams.nSumOper);
            }
        }
    }
}