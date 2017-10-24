using Areas.Sep.Models;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Models;
using BarsWeb.Models;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Globalization;
using System.Linq;
using System.Text;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Implementation
{
    public class SepPaymentStateRepository : ISepPaymentStateRepository
    {
        private readonly SepFiles _entities;
        private bool _isWhereAdded = false;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;

        private BarsSql _baseSepDocsSql;

        public SepPaymentStateRepository(IKendoSqlTransformer kendoSqlTransformer, IKendoSqlCounter kendoSqlCounter)
        {
            var connectionStr = EntitiesConnection.ConnectionString("SepFiles", "Sep");
            _entities = new SepFiles(connectionStr);
            _sqlTransformer = kendoSqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
        }


        public List<SepPaymentStateInfo> GetSepPaymentStateInfo(SepPaymentStateFilterParams filter, DataSourceRequest request)
        {
            List<SepPaymentStateInfo> result = new List<SepPaymentStateInfo>();
              List<SepPaymentStateInfo> result2 = new List<SepPaymentStateInfo>();
            result = _entities.ExecuteStoreQuery<SepPaymentStateInfo>
                (@"SELECT nn, tt, name  FROM v_procacc ORDER BY nn", null).ToList<SepPaymentStateInfo>();

            result2 = _entities.ExecuteStoreQuery<SepPaymentStateInfo>
                (@" SELECT nn, count(*) cnt, sum(s) suma FROM v_procaccdoc  GROUP BY nn", null).ToList<SepPaymentStateInfo>();

            // СВОД 2-х результирующих номеров. Добавление результата агрегации count(*) cnt, sum(s) suma
            foreach (var item1 in result)
            {
                foreach (var item2 in result2)
                {
                    if (item1.NN == item2.NN)
                    {
                        item1.CNT = item2.CNT;
                        item1.SUMA = item2.SUMA;
                    }       
                }                    
            }
            return result;
        }

        public ObjectResult<SepFileDoc> GetSepPaymentStateDocs(SepFileDocParams p, DataSourceRequest request)
        {
            InitSetPaymentStateDocSql(p);
            var sql = _sqlTransformer.TransformSql(_baseSepDocsSql, request);
            return _entities.ExecuteStoreQuery<SepFileDoc>(sql.SqlText, sql.SqlParams);
        }

        public decimal GetSepPaymentStateDocsCount(SepFileDocParams p)
        {
            InitSetPaymentStateDocSql(p);
            var total = _entities.ExecuteStoreQuery<decimal>(_kendoSqlCounter.TransformSql(_baseSepDocsSql.SqlText, null).SqlText, _baseSepDocsSql.SqlParams).Single();
            return total;
        }

        private void InitSetPaymentStateDocSql(SepFileDocParams p)
        {
            _baseSepDocsSql = new BarsSql()
            {
             SqlParams = new object[] { },
             SqlText = String.Format(@" 

      SELECT 
      a.mfoa, a.mfob, a.nlsa, a.nlsb, a.s, a.kv, 
      v.lcv, v.dig, a.dk, a.vob, a.datd, a.datp,
      a.rec, a.fn_a, a.dat_a, a.rec_a, a.fn_b, a.dat_b, 
      a.rec_b, 
      a.ref,
      a.sos, 
      substr ( a.nd,1,10 ) as ND,
      substr ( a.nazn,1,160 ) as NAZN, 
      1 as DKCount,  
      substr ( decode ( mod ( a.dk,2 ) ,0,a.nam_b,a.nam_a ) ,1,38 ) as NAMA, 
      b1.nb as NBA,  
      substr ( decode ( mod ( a.dk,2 ) ,0,a.nam_a,a.nam_b ) ,1,38 ) as NAMB, 
      b2.nb as NBB 
      FROM ARC_RRP a, tabval$global v, banks$base b1, banks$base b2
      WHERE a.kv=v.kv ( + )  and  (  ( a.rec in  ( select rec from v_procaccdoc where nn={0} )  )  AND  a.bis<=1 
      AND decode ( mod ( a.dk,2 ) ,0,a.mfob,a.mfoa ) =b1.mfo 
      AND decode ( mod ( a.dk,2 ) ,0,a.mfoa,a.mfob ) =b2.mfo   ) 
      ORDER BY a.rec DESC 
     ", p.nn.Value.ToString() )
            };
        }
         
    }
}