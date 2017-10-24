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
using BarsWeb.Areas.Sep.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Implementation
{
    public class SepFilesRepository : ISepFilesRepository
    {
        private const string SepDateTimeFormat = "dd/MM/yyyy HH:mm";

        private readonly SepFiles _entities;
        private bool _isWhereAdded = false;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;
        private readonly IKendoSqlFilter _kendoSqlFilter ;
        private BarsSql _baseSepFilesSql;
        private BarsSql _baseSepDocsSql;

        public SepFilesRepository(IKendoSqlTransformer kendoSqlTransformer, IKendoSqlCounter kendoSqlCounter, IKendoSqlFilter kendoSqlFilter)
        {
            var connectionStr = EntitiesConnection.ConnectionString("SepFiles", "Sep");
            _entities = new SepFiles(connectionStr);
            _sqlTransformer = kendoSqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
            _kendoSqlFilter = kendoSqlFilter;
        }

        private void InitSepFilesSql(SepFilesFilterParams filter)
        {
            var sql = new StringBuilder();
            sql.Append(String.Format("select * from {0} ZAG join TABVAL on ZAG.KV = TABVAL.KV ", filter.Incoming ? "ZAG_A" : "ZAG_B"));


            var parameters = new List<object>();
            if (filter.FileNameMask == null)
            {
                filter.FileNameMask = "";
            }
            if (filter.FileNameMask.Trim() != "*")
            {
                filter.FileNameMask = filter.FileNameMask.Trim().Replace('*', '%').Replace('?', '_');
                sql.Append(String.Format(" where FN LIKE :p_fileMask "));
                parameters.Add(new OracleParameter("p_fileMask", OracleDbType.Varchar2){Value = filter.FileNameMask});
                _isWhereAdded = true;
            }

            var startDate = DateTime.ParseExact(filter.FileDate, "dd-MM-yyyy", null);
            var endDate = startDate.AddDays(1);

            sql.Append(_isWhereAdded ? " and " : " where ");
            sql.Append(" DAT between :p_start_date and :p_end_date ");
            parameters.Add(new OracleParameter("p_start_date", OracleDbType.Date){Value = startDate});
            parameters.Add(new OracleParameter("p_end_date", OracleDbType.Date){Value = endDate});

            sql.Append(String.Format(" and OTM {0} 5", filter.IsMatched ? ">=" : "<"));

            if (filter.Currency != null && filter.Currency != "*")
            {
                sql.Append(" and LCV = :p_currency");
                parameters.Add(new OracleParameter("p_currency", OracleDbType.Varchar2) {Value = filter.Currency});
            }
            _baseSepFilesSql = new BarsSql()
            {
                SqlParams = parameters.ToArray(),
                SqlText = sql.ToString()
            };
        }
        private void InitSepDocsSql(SepFileDocParams sepDocParams)
        {
            if (_baseSepDocsSql != null)
            {
                return;
            }
            _baseSepDocsSql = new BarsSql()
            {
                SqlParams = new object[]{ 
                    new OracleParameter("p_fileName", OracleDbType.Varchar2) {Value = sepDocParams.FileName},
                    new OracleParameter("p_fileCreated",OracleDbType.Varchar2) {Value = sepDocParams.FileCreated}
                },
                SqlText = string.Format(
                @"SELECT a.mfoa, a.mfob, a.nlsa, a.nlsb, a.s, a.kv, v.lcv, v.dig, a.dk, a.vob, a.datp, 
                a.rec, a.fn_a, a.dat_a, a.rec_a, a.fn_b, a.dat_b, a.rec_b, a.ref, a.sos,
                substr(a.nd,1,10) nd, substr(a.nazn,1,160) nazn, 
                substr(decode(mod(a.dk,2),0,a.nam_b,a.nam_a),1,38) NamA, b1.nb NbA, 
                substr(decode(mod(a.dk,2),0,a.nam_a,a.nam_b),1,38) NamB, b2.nb NBb,
                a.id_a, a.id_b, zag_a.DATK, zag_a.DAT_2
                FROM ARC_RRP a, tabval$global v, banks$base b1, banks$base b2, zag_a
                WHERE a.kv=v.kv(+) and (fn_{0}=:p_fileName and dat_{0}=TO_DATE(:p_fileCreated, 'DD/MM/YYYY HH24:MI') 
                AND a.bis<=1 AND decode(mod(a.dk,2),0,a.mfob,a.mfoa)=b1.mfo AND decode(mod(a.dk,2),0,a.mfoa,a.mfob)=b2.mfo)                
                AND a.FN_{0} = zag_a.FN(+) and a.DAT_A = zag_a.DAT(+)",
                sepDocParams.IsIncoming ? "a" : "b")
            };
        }

        public decimal GetSepFilesCount(SepFilesFilterParams filter, DataSourceRequest request)
        {
            InitSepFilesSql(filter);
            var filteredSql = _kendoSqlCounter.TransformSql(_baseSepFilesSql, request);
            var total = _entities.ExecuteStoreQuery<decimal>(filteredSql.SqlText, filteredSql.SqlParams).Single();
            return total;
        }

        public IQueryable<Zag> GetSepFilesInfo(SepFilesFilterParams filter, DataSourceRequest request)
        {
            InitSepFilesSql(filter);

            var sql = _sqlTransformer.TransformSql(_baseSepFilesSql, request);
            ObjectResult<Zag> tmpResult = _entities.ExecuteStoreQuery<Zag>(sql.SqlText, sql.SqlParams);
            return tmpResult.AsQueryable();
        }

        public ObjectResult<SepFileDoc> GetSepFileDocs(SepFileDocParams sepDocParams, DataSourceRequest request)
        {
            InitSepDocsSql(sepDocParams);
            
            var sql = _sqlTransformer.TransformSql(_baseSepDocsSql, request);
            return _entities.ExecuteStoreQuery<SepFileDoc>(sql.SqlText, sql.SqlParams);
        }
         
        public decimal GetSepDocsCount(SepFileDocParams sepDocParam, DataSourceRequest request)
        {
            InitSepDocsSql(sepDocParam);
            var filteredSql = _kendoSqlCounter.TransformSql(_baseSepDocsSql, request);
            var total = _entities.ExecuteStoreQuery<decimal>(filteredSql.SqlText, filteredSql.SqlParams).Single();
            return total;
        }

        public int RecreateZagB(string fileName, string fileCreateDate)
        {
            var dateCreate = DateTime.ParseExact(fileCreateDate, SepDateTimeFormat, new CultureInfo("en-US"));
            var sepFile = _entities.ZAG_B.SingleOrDefault(z => z.FN == fileName && z.DAT == dateCreate && (z.OTM == 1 || z.OTM == 2 || z.OTM == 3));
            if (sepFile != null)
            {
                sepFile.OTM = 1;
                sepFile.K_ER = null;
                return _entities.SaveChanges();
            }
            throw new Exception(string.Format("Не знайдено файл із вказаним іменем {0} за дату {1}", fileName, fileCreateDate));
        }

        public int MatchSepFile(SepFileMatchParams matchParams)
        {
            var dateCreate = DateTime.ParseExact(matchParams.FileCreated, SepDateTimeFormat, new CultureInfo("en-US"));
            string pTt = matchParams.Incoming ? "RT1" : "RT0";
            var errorCode = new ObjectParameter("ERR_", typeof(int)) {Value = 0};
            
            _entities.SEP_PS_GRC(
                eRR_: errorCode,
                tT_: pTt,
                fN_: matchParams.FileName,
                dAT_: dateCreate,
                n_: matchParams.RowCount,
                sD_: matchParams.DebitSum, 
                sK_: matchParams.KreditSum, 
                eRRK_: 0, 
                dETAIL_: 0, 
                aB_SIGN_: null,
                aB_SIGNSIZE_: 0, 
                dAT_2_: null, 
                tIC_SIGN_KEY_: null);

            return (int)(decimal)errorCode.Value;
        }

        public int UnCreateSepFile(SepFileUncreateParams uncreateParams)
        {
            var dateCreate = DateTime.ParseExact(uncreateParams.FileCreated, SepDateTimeFormat, new CultureInfo("en-US"));
            var errorCode = new ObjectParameter("ERR_", typeof(int)) { Value = 0 };
            _entities.SEP_P_KWT(errorCode, uncreateParams.FileName, dateCreate, 0, uncreateParams.BpReasonId);
            var kwtResult = (int) (decimal) errorCode.Value;
            if (kwtResult != 0)
            {
                return kwtResult;
            }
            errorCode.Value = 0;
            _entities.SEP_PS_GRC(
                eRR_: errorCode,
                tT_: "RT0",
                fN_: uncreateParams.FileName,
                dAT_: dateCreate,
                n_: uncreateParams.RowCount,
                sD_: uncreateParams.DebitSum,
                sK_: uncreateParams.KreditSum,
                eRRK_: uncreateParams.BpReasonId,
                dETAIL_: 1,
                aB_SIGN_: null,
                aB_SIGNSIZE_: 0,
                dAT_2_: null,
                tIC_SIGN_KEY_: null);

            return (int)(decimal)errorCode.Value; 
        }
        public void DeleteSepFile(SepFilesDelParams delParams)
        {
            var dateCreate = DateTime.ParseExact(delParams.FileCreated, SepDateTimeFormat, new CultureInfo("en-US"));
            object[] parameters =
            {
                new OracleParameter("p_Fn", OracleDbType.Varchar2) {Value = delParams.FileName},
                new OracleParameter("p_Dat", OracleDbType.Date) {Value = dateCreate}
            };
            
            _entities.ExecuteStoreCommand("DELETE FROM tzapros WHERE rec IN (SELECT rec FROM arc_rrp WHERE fn_a = :p_Fn AND dat_a = :p_Dat)", parameters);
            _entities.ExecuteStoreCommand("DELETE FROM rec_que WHERE rec IN (SELECT rec FROM arc_rrp WHERE fn_a = :p_Fn AND dat_a = :p_Dat)", parameters);
            _entities.ExecuteStoreCommand("DELETE FROM ARC_RRP where FN_A = :p_Fn and DAT_A = :p_Dat", parameters);
            _entities.ExecuteStoreCommand("DELETE FROM zag_a WHERE fn = :p_Fn AND dat = :p_Dat AND otm=0", parameters);

            _entities.GL_PAY_BCK(delParams.Ref, 5);
        }
        public void DoIpsRequest(SepFileDoc doc)
        {
            object[] parameters =
            {
                new OracleParameter("p_DAT_B", OracleDbType.Date) {Value = doc.DAT_A},
                new OracleParameter("p_MFOA", OracleDbType.Varchar2) {Value = doc.MFOA},
                new OracleParameter("p_NLSA", OracleDbType.Varchar2) {Value = doc.NLSA},
                new OracleParameter("p_MFOB", OracleDbType.Varchar2) {Value = doc.MFOB},
                new OracleParameter("p_NLSB", OracleDbType.Varchar2) {Value = doc.NLSB},
                new OracleParameter("p_S", OracleDbType.Decimal) {Value = doc.S},
                new OracleParameter("p_DK", OracleDbType.Decimal) {Value = doc.DK},
                new OracleParameter("p_FN_B", OracleDbType.Varchar2) {Value = doc.FN_B},
                new OracleParameter("p_KV", OracleDbType.Decimal) {Value = doc.KV},
                new OracleParameter("p_REC_A", OracleDbType.Decimal) {Value = doc.REC_B}
            };
            _entities.ExecuteStoreCommand(@"INSERT INTO Ips_rrp (dat_sep, mfoa, nlsa, mfob, nlsb, s, dk, fn_a, kv, rec_a)
                                          VALUES (:p_DAT_B, :p_MFOA, :p_NLSA, :p_MFOB, :p_NLSB, :p_S, :p_DK, :p_FN_B, :p_KV, :p_REC_A )", parameters);
        }
    }
}