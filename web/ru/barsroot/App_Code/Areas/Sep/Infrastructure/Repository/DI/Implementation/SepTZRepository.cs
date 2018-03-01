using Areas.Sep.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Models;
using BarsWeb.Models;
using Kendo.Mvc.UI;
using Oracle.DataAccess.Client;
using System;
using System.Data.Objects;
using System.Linq;
using ARC_RRP = Models.ARC_RRP;
using ZAG_A = Areas.Sep.Models.ZAG_A;
using System.Collections.Generic;

/// <summary>
/// Реалізація інтерфейсу ISepTZRepository
/// </summary>

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Implementation
{
    public class SepTZRepository : ISepTZRepository
    {
        private readonly SepFiles _entities;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IParamsRepository _paramsRepo;
        private readonly IKendoSqlCounter _kendoSqlCounter;
        public BarsSql _baseSepTZSql;
        public BarsSql _checkRowReplySql;
        public BarsSql _getS902Sql;
        public BarsSql _getReportSql;
        public SepTZRepository(IKendoSqlTransformer sqlTransformer, IKendoSqlCounter kendoSqlCounter, IParamsRepository paramsRepo)
        {
            var connectionStr = EntitiesConnection.ConnectionString("SepFiles", "Sep");
            this._entities = new SepFiles(connectionStr);
            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
            _paramsRepo = paramsRepo;
        }
        public IQueryable<SepTZ> GetSepTZList(DataSourceRequest request, AccessType accessType)
        {
            InitSepTZSql(accessType);
            var sql = _sqlTransformer.TransformSql(_baseSepTZSql, request);
            ObjectResult<SepTZ> tmpResult = _entities.ExecuteStoreQuery<SepTZ>(sql.SqlText, sql.SqlParams);

            return tmpResult.AsQueryable();
        }
        public decimal GetSepTZCount(AccessType accessType, DataSourceRequest request)
        {
            InitSepTZSql(accessType);
            var a = _kendoSqlCounter.TransformSql(_baseSepTZSql, request);
            var total = _entities.ExecuteStoreQuery<decimal>(a.SqlText, a.SqlParams).Single();
            return total;
        }
        public void DeleteSepTZRow(int rowREC)
        {
            var delRow = _entities.TZAPROS.Where(r => r.REC == rowREC).Select(r => r).SingleOrDefault();
            _entities.DeleteObject(delRow);
            _entities.SaveChanges();
        }
        public IQueryable<ARC_RRP> GetRowReply(string dRec)
        {
            InitRowReplySql(dRec);
            ObjectResult<ARC_RRP> rowReplyResult = _entities.ExecuteStoreQuery<ARC_RRP>(_checkRowReplySql.SqlText, _checkRowReplySql.SqlParams);
            return rowReplyResult.AsQueryable();
        }
        public IQueryable<ACCOUNTS> GetS902()
        {
            InitS902Sql();
            ObjectResult<ACCOUNTS> s902Result = _entities.ExecuteStoreQuery<ACCOUNTS>(_getS902Sql.SqlText, _getS902Sql.SqlParams);
            return s902Result.AsQueryable();
        }
        public IQueryable<ARC_RRP> GetReport(string mode, DateTime dStart, DateTime dEnd)
        {
            InitReportSql(mode, dStart, dEnd);
            ObjectResult<ARC_RRP> tmpReport = _entities.ExecuteStoreQuery<ARC_RRP>(_getReportSql.SqlText, _getReportSql.SqlParams);
            return tmpReport.AsQueryable();
        }
        public decimal GetReportCount(string mode, DateTime dStart, DateTime dEnd, DataSourceRequest request)
        {
            InitReportSql(mode, dStart, dEnd);
            var a = _kendoSqlCounter.TransformSql(_getReportSql, request);
            var total = _entities.ExecuteStoreQuery<decimal>(a.SqlText, a.SqlParams).Single();
            return total;
        }
        public IEnumerable<ZAG_A> GetZagA(string arcFn, DateTime arcDate_a)
        {
            var zag = _entities.ZAG_A.Where(fn => fn.FN == arcFn).Where(d => d.DAT == arcDate_a);
            return zag;
        }
        private void InitSepTZSql(AccessType accessType)
        {
            var mfo = _paramsRepo.GetParam("MFO");
            var dateBank = _paramsRepo.GetParam("BANKDATE");

            string sFilt = ""; 
            switch (accessType.Mode)
            {
                case "bank":
                    sFilt = "mfoA<>:p_mfo AND mfoB=:p_mfo1";
                    break;
                case "department":
                    sFilt = "mfoA<>:p_mfo  AND  (accounts.TOBO=tobopack.GetTobo  or  length(tobopack.GetTobo)=8 and accounts.TOBO like '%000000%')";
                    break;
                case "depNUsers":
                    sFilt = "mfoa<>:p_mfo  AND tobopack.GetTobo=substr(accounts.tobo,1,length(tobopack.GetTobo))";
                    break;
            }
            _baseSepTZSql = new BarsSql() 
                {
                     SqlText = string.Format(@"
                        SELECT arc_rrp.dk,   arc_rrp.rec, arc_rrp.fn_a, arc_rrp.dat_b, arc_rrp.ref_a,  arc_rrp.datd,arc_rrp.nd,  arc_rrp.vob,
                               arc_rrp.mfoa, arc_rrp.nlsa, arc_rrp.kv,  arc_rrp.s/100 s, 
                               arc_rrp.nlsb, arc_rrp.nam_b,arc_rrp.nazn,arc_rrp.d_rec,
                               arc_rrp.dat_a,arc_rrp.nam_a,arc_rrp.id_a,arc_rrp.id_b,arc_rrp.datp,
                               accounts.nms, accounts.ostc/100 ostc, accounts.lim/100 lim, accounts.pap, banks.nb, tzapros.otm
                        FROM tzapros, arc_rrp, accounts, banks
                        WHERE {0} AND arc_rrp.s>0 and arc_rrp.dk>1 and arc_rrp.rec =tzapros.rec AND
                               accounts.nls(+)=arc_rrp.nlsb AND accounts.KV(+)=arc_rrp.KV AND arc_rrp.mfoa(+)=banks.mfo AND
                               {1}
                        ORDER BY tzapros.rec DESC",
                               accessType.obFixed ? "tzapros.otm>0 AND tzapros.dat+30>TO_DATE(:p_dateBank, 'MM/DD/YYYY')" : "tzapros.otm=0",
                               sFilt),
                     SqlParams = accessType.obFixed && accessType.Mode == "bank" ? new object[] 
                     {
                        new OracleParameter("p_dateBank", OracleDbType.Varchar2) { Value = dateBank.Value },
                        new OracleParameter("p_mfo", OracleDbType.Varchar2) { Value = mfo.Value},
                        new OracleParameter("p_mfo1", OracleDbType.Varchar2) { Value = mfo.Value}
                     } : accessType.obFixed && (accessType.Mode == "department" || accessType.Mode == "depNUsers") ? new object[] 
                     {
                        new OracleParameter("p_dateBank", OracleDbType.Varchar2) { Value = dateBank.Value },
                        new OracleParameter("p_mfo", OracleDbType.Varchar2) { Value = mfo.Value}
                     } : accessType.Mode == "bank" ? new object[] 
                     { 
                        new OracleParameter("p_mfo", OracleDbType.Varchar2) { Value = mfo.Value},
                        new OracleParameter("p_mfo1", OracleDbType.Varchar2) { Value = mfo.Value}
                     } : new object[] 
                     {
                        new OracleParameter("p_mfo", OracleDbType.Varchar2) { Value = mfo.Value} 
                     }
                };
        }
        private void InitRowReplySql(string dRec)
        {
            var dateBank = _paramsRepo.GetParam("BANKDATE");
            string fn = dRec.Substring(2, 12);
            int rec = Int32.Parse(dRec.Substring(15, 5));

            _checkRowReplySql = new BarsSql()
            {
                SqlText = string.Format(@"
                        SELECT *
			   	        FROM arc_rrp
			  	        WHERE dat_b >= ADD_MONTHS(TO_DATE(:p_dateBank,'MM/DD/YYYY'),-1) 
				             AND fn_b=:p_fn AND rec_b=:p_rec"
                        ),
                SqlParams = new object[] { 
                    new OracleParameter("p_dateBank", OracleDbType.Varchar2) { Value = dateBank.Value },
                    new OracleParameter("p_fn", OracleDbType.Varchar2) { Value = fn },
                    new OracleParameter("p_rec", OracleDbType.Decimal) { Value = rec }
                }
            };
        }
        private void InitS902Sql()
        {
            var nBaseVal = _paramsRepo.GetParam("BASEVAL");
            _getS902Sql = new BarsSql()
            {
                SqlText = string.Format(@"
                        SELECT *
                        FROM accounts
                        WHERE kv=:nBaseVal and tip='902'"),
                SqlParams = new object[] {
                    new OracleParameter("nBaseVal", OracleDbType.Decimal) { Value = nBaseVal.Value }
                }
            };
        }
        private void InitReportSql(string mode, DateTime dStart, DateTime dEnd) 
        {
            var mfo = _paramsRepo.GetParam("MFO");
            string sTmp = "";

            switch(mode) {
                case "1":
                    sTmp = "mfob=:p_mfo AND SUBSTR(d_rec,1,2)='#?'";
                    break;
                case "2":
                    sTmp="mfoa=:p_mfo AND SUBSTR(d_rec,1,2) IN ('#!','#+','#-','#*')";
                    break;
            }

            _getReportSql = new BarsSql() 
            {
                SqlText = string.Format(@"               
                SELECT dat_a,mfoa,nlsa,mfob,nlsb,dk,s,vob,nd,kv,datd,nam_a,nam_b,nazn,d_rec,id_a,id_b
                FROM arc_rrp
                WHERE {0} AND dat_a >=:dDat1 AND dat_a -1  < :dDat2
                ORDER BY nlsb
                ", sTmp),
                SqlParams = new object[] {
                    new OracleParameter("p_mfo", OracleDbType.Varchar2) { Value = mfo.Value },
                    new OracleParameter("dDat1", OracleDbType.Date) { Value = dStart },
                    new OracleParameter("dDat2", OracleDbType.Date) { Value = dEnd }
                }
            };
            
        }
    }
}

