using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Admin.Models.Oper;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using Areas.Admin.Models;
using Bars.Classes;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Ndi.Infrastructure;
using Kendo.Mvc.UI;
using Microsoft.Ajax.Utilities;
using Oracle.DataAccess.Client;
using Dapper;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Implementation
{

    public class OperRepository : IOperRepository
    {
        Entities _entities;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;
        private readonly IParamsRepository _paramsRepo;
        public OperRepository(IKendoSqlTransformer kendoSqlTransformer,
            IKendoSqlCounter kendoSqlCounter, IAdminModel model, IParamsRepository paramsRepo)
        {
            _entities = model.Entities;
            _sqlTransformer = kendoSqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
            _paramsRepo = paramsRepo;
        }

        #region OperData

        public BarsSql _operDataQuery;
        public BarsSql _operItemQuery;
        /*public IEnumerable<TTS> OperData([DataSourceRequest]DataSourceRequest request)
        {
            InitOperDataQuery();
            var a = _sqlTransformer.TransformSql(_operDataQuery, request);
            var result = _entities.ExecuteStoreQuery<TTS>(a.SqlText, a.SqlParams);
            return result;
        }
        public decimal OperDataCount(DataSourceRequest request)
        {
            InitOperDataQuery();
            var count = _kendoSqlCounter.TransformSql(_operDataQuery, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }*/

        public IEnumerable<TTS> OperData()
        {
            const string query = @"select * from tts";
            return _entities.ExecuteStoreQuery<TTS>(query);
        }

        public TTS OperItem(DataSourceRequest request, string tt)
        {
            InitOperQuery(tt);
            var a = _sqlTransformer.TransformSql(_operItemQuery, request);
            var item = _entities.ExecuteStoreQuery<TTS>(a.SqlText, a.SqlParams).First();
            return item;
        }

        /*private void InitOperDataQuery()
        {
            _operDataQuery = new BarsSql()
            {
                SqlText = string.Format(@"select * from tts"),
                SqlParams = new object[] {}
            };

        }*/

        private void InitOperQuery(string tt)
        {
            _operItemQuery = new BarsSql()
            {
                SqlText = string.Format(@"select * from tts where tt=:p_tt"),
                SqlParams = new object[] { new OracleParameter("p_tt", OracleDbType.Varchar2) { Value = tt } }
            };
        }

        public void UpdateOperItem(TTS item)
        {
            const string command = @"
                begin
                    bars_ttsadm.set_tt(:p_tt, :p_name, :p_dk, :p_nlsm, :p_kv, :p_nlsk, :p_kvk, :p_nlss,
                       :p_nlsa, :p_nlsb, :p_mfob, :p_flc, :p_fli, :p_flv, :p_flr, :p_s, :p_s2, :p_sk,
                       :p_proc, :p_s3800, :p_s6201, :p_s7201, :p_rang, :p_flags, :p_nazn);
                end;";
            var parameters = new object[]
            {
                new OracleParameter("p_tt", OracleDbType.Varchar2) { Value = item.TT },
                new OracleParameter("p_name", OracleDbType.Varchar2) { Value = item.NAME },
                new OracleParameter("p_dk", OracleDbType.Decimal) { Value = item.DK },
                new OracleParameter("p_nlsm", OracleDbType.Varchar2) { Value = item.NLSM },
                new OracleParameter("p_kv", OracleDbType.Decimal) { Value = item.KV == 0 ? null : item.KV },
                new OracleParameter("p_nlsk", OracleDbType.Varchar2) { Value = item.NLSK },
                new OracleParameter("p_kvk", OracleDbType.Decimal) { Value = item.KVK == 0 ? null : item.KVK },
                new OracleParameter("p_nlss", OracleDbType.Varchar2) { Value = item.NLSS },
                new OracleParameter("p_nlsa", OracleDbType.Varchar2) { Value = item.NLSA },
                new OracleParameter("p_nlsb", OracleDbType.Varchar2) { Value = item.NLSB },
                new OracleParameter("p_mfob", OracleDbType.Varchar2) { Value = item.MFOB },
                new OracleParameter("p_flc", OracleDbType.Decimal) { Value = item.FLC },
                new OracleParameter("p_fli", OracleDbType.Decimal) { Value = item.FLI },
                new OracleParameter("p_flv", OracleDbType.Decimal) { Value = item.FLV },
                new OracleParameter("p_flr", OracleDbType.Decimal) { Value = item.FLR },
                new OracleParameter("p_s", OracleDbType.Varchar2) { Value = item.S },
                new OracleParameter("p_s2", OracleDbType.Varchar2) { Value = item.S2 },
                new OracleParameter("p_sk", OracleDbType.Varchar2) { Value = item.SK },
                new OracleParameter("p_proc", OracleDbType.Decimal) { Value = item.PROC },
                new OracleParameter("p_s3800", OracleDbType.Decimal) { Value = Convert.ToDecimal(item.S3800) },
                new OracleParameter("p_s6201", OracleDbType.Decimal) { Value = item.S6201 },
                new OracleParameter("p_s7201", OracleDbType.Decimal) { Value = item.S7201 },
                new OracleParameter("p_rang", OracleDbType.Decimal) { Value = item.RANG },
                new OracleParameter("p_flags", OracleDbType.Varchar2) { Value = item.FLAGS.IsNullOrEmpty() ? "" : item.FLAGS },
                new OracleParameter("p_nazn", OracleDbType.Varchar2) { Value = item.NAZN }
            };
            _entities.ExecuteStoreCommand(command, parameters);
        }

        public void DeleteOper(string tt)
        {
            string query = String.Format(@"DELETE FROM tts WHERE tt = '" + tt + "'");
            //var prms = new object[] {new OracleParameter("p_tt", OracleDbType.Char) {Value = tt}};
            _entities.ExecuteStoreCommand(query);
        }

        #endregion

        #region CardHandbooks

        public IEnumerable<TTS_DK_Handbook> DkHandbookData()
        {
            const string query = @"select * from dk";
            var result = _entities.ExecuteStoreQuery<TTS_DK_Handbook>(query);
            return result;
        }

        public IEnumerable<TTS_INTERBANK_Handbook> InterbankHandbookData()
        {
            const string query = @"select * from interbank";
            var result = _entities.ExecuteStoreQuery<TTS_INTERBANK_Handbook>(query);
            return result;
        }

        #endregion

        #region Flags & Props Data

        public BarsSql _flagsDataQuery;
        public BarsSql _flagsOutDataQuery;
        public BarsSql _propDataQuery;
        public BarsSql _propOutDataQuery;
        public IEnumerable<TTS_OpFlags> FlagsData(int[] code, string tt)
        {
            InitFlagsDataQuery(code, tt);
            //var query = _sqlTransformer.TransformSql(_flagsDataQuery, request);
            var result = _entities.ExecuteStoreQuery<TTS_OpFlags>(_flagsDataQuery.SqlText, _flagsDataQuery.SqlParams);
            return result;
        }

        /*public decimal FlagsDataCount(DataSourceRequest request, int[] code, string tt)
        {
            InitFlagsDataQuery(code, tt);
            var count = _kendoSqlCounter.TransformSql(_flagsDataQuery, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }*/
        private void InitFlagsDataQuery(int[] code, string tt)
        {
            //string param = string.Join(", ", code);

            _flagsDataQuery = new BarsSql()
            {
                /*SqlText = string.Format(@"select * from flags where CODE IN ({0})", param),*/
                SqlText = string.Format(@"
                    SELECT a.fcode,b.name,a.value 
                    FROM tts_flags a,flags b 
                    WHERE ( (a.fcode=b.code) ) AND (a.tt=:p_tt) and a.value > 0
                    ORDER BY fcode"),
                SqlParams = new object[] { new OracleParameter("p_tt", OracleDbType.Varchar2) { Value = tt } }
            };
        }

        public IEnumerable<TTS_FLAGS> FlagsOutData(DataSourceRequest request, int[] code)
        {
            InitFlagsOutDataQuery(code);
            var query = _sqlTransformer.TransformSql(_flagsOutDataQuery, request);
            var result = _entities.ExecuteStoreQuery<TTS_FLAGS>(query.SqlText, query.SqlParams);
            return result;
        }

        public decimal FlagsOutCount(DataSourceRequest request, int[] code)
        {
            InitFlagsOutDataQuery(code);
            var count = _kendoSqlCounter.TransformSql(_flagsOutDataQuery, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }
        private void InitFlagsOutDataQuery(int[] code)
        {
            string param = code != null ? string.Join(", ", code) : "";
            string paramQuery = param.IsNullOrEmpty() ? "" : string.Format(" where CODE NOT IN ({0})", param);

            _flagsOutDataQuery = new BarsSql()
            {
                SqlText = string.Format(@"select * from flags {0}", paramQuery),
                SqlParams = new object[] { }
            };
        }

        public IEnumerable<TTS_Prop> PropData(DataSourceRequest request, string tt)
        {
            InitPropDataQuery(tt);
            var query = _sqlTransformer.TransformSql(_propDataQuery, request);
            var result = _entities.ExecuteStoreQuery<TTS_Prop>(query.SqlText, query.SqlParams);
            return result;
        }

        public decimal PropDataCount(DataSourceRequest request, string tt)
        {
            InitPropDataQuery(tt);
            var count = _kendoSqlCounter.TransformSql(_propDataQuery, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }

        private void InitPropDataQuery(string tt)
        {
            _propDataQuery = new BarsSql()
            {
                SqlText = string.Format(@"SELECT a.tag TAG, b.name NAME, a.opt OPT, a.used4input USED4INPUT, a.ord ORD, a.val VAL
                    FROM op_rules a,op_field b 
                    WHERE a.tag=b.tag AND a.tt=:p_tt 
                    ORDER BY a.ord,a.tag"),
                SqlParams = new object[] { new OracleParameter("p_tt", OracleDbType.Varchar2) { Value = tt } }
            };
        }

        public IEnumerable<TTS_OP_FIELD> PropOutData(DataSourceRequest request, string tt)
        {
            InitPropOutDataQuery(tt);
            var query = _sqlTransformer.TransformSql(_propOutDataQuery, request);
            var result = _entities.ExecuteStoreQuery<TTS_OP_FIELD>(query.SqlText, query.SqlParams);
            return result;
        }

        public decimal PropOutDataCount(DataSourceRequest request, string tt)
        {
            InitPropOutDataQuery(tt);
            var count = _kendoSqlCounter.TransformSql(_propOutDataQuery, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }

        private void InitPropOutDataQuery(string tt)
        {
            _propOutDataQuery = new BarsSql()
            {
                SqlText = string.Format(@"SELECT tag, name 
                    FROM op_field 
                    WHERE tag NOT IN (SELECT tag FROM op_rules WHERE tt=:p_tt) ORDER BY tag"),
                SqlParams = new object[] { new OracleParameter("p_tt", OracleDbType.Varchar2) { Value = tt } }
            };
        }

        public BarsSql _updateProp;
        public void UpdateProps(string tt, string tag, string opt, decimal used, decimal? ord, string val)
        {
            InitUpdatePropCommand(tt, tag, opt, used, ord, val);
            _entities.ExecuteStoreCommand(_updateProp.SqlText, _updateProp.SqlParams);
        }

        private void InitUpdatePropCommand(string tt, string tag, string opt, decimal used, decimal? ord, string val)
        {
            _updateProp = new BarsSql()
            {
                SqlText = string.Format(@"begin bars_ttsadm.set_rules(:p_tag, :p_tt, :p_opt, :p_used, :p_ord, :p_val); end;"),
                SqlParams = new object[]
                {
                    new OracleParameter("p_tag", OracleDbType.Varchar2) { Value = tag },
                    new OracleParameter("p_tt", OracleDbType.Varchar2) { Value = tt },
                    new OracleParameter("p_opt", OracleDbType.Varchar2) { Value = opt },
                    new OracleParameter("p_used", OracleDbType.Decimal) { Value = used },
                    new OracleParameter("p_ord", OracleDbType.Decimal) { Value = ord.HasValue == true ? ord : 0 },
                    new OracleParameter("p_val", OracleDbType.Varchar2) { Value = val }
                }
            };
        }

        public void UpdateFlagValue(string tt, decimal code, string value)
        {
            const string query = @"begin bars_ttsadm.set_flag_on_index(:p_tt, :p_index, :p_value); end;";

            var parameters = new object[]
            {
                new OracleParameter("p_tt", OracleDbType.Varchar2) {Value = tt},
                new OracleParameter("p_index", OracleDbType.Decimal) {Value = code},
                new OracleParameter("p_value", OracleDbType.Varchar2) {Value = value}
            };
            _entities.ExecuteStoreCommand(query, parameters);
        }

        #endregion

        #region Balance Accounts Data

        public BarsSql _balAccQuery;
        public BarsSql _accQuery;
        public IEnumerable<TTS_PS> BalanceAccountsData(DataSourceRequest request, string tt)
        {
            InitBalAccQuery(tt);
            var query = _sqlTransformer.TransformSql(_balAccQuery, request);
            var result = _entities.ExecuteStoreQuery<TTS_PS>(query.SqlText, query.SqlParams);
            return result;
        }

        public decimal BalanceAccountsCount(DataSourceRequest request, string tt)
        {
            InitBalAccQuery(tt);
            var count = _kendoSqlCounter.TransformSql(_balAccQuery, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }

        private void InitBalAccQuery(string tt)
        {
            var globalParam = _paramsRepo.GetParam("OB22").Value;

            _balAccQuery = new BarsSql()
            {
                SqlText = string.Format(@"SELECT a.nbs NBS, b.name NAME, a.dk DK, {0} OB22
                    FROM ps_tts a, ps b 
                    WHERE a.nbs=b.nbs AND a.tt=:p_tt 
                    ORDER BY a.dk, a.nbs", globalParam == "1" ? "a.ob22" : "null"),
                SqlParams = new object[] { new OracleParameter("p_tt", OracleDbType.Varchar2) { Value = tt } }
            };
        }

        public IEnumerable<TTS_NBS> AccountsData(DataSourceRequest request, string tt)
        {
            InitAccQuery();
            var query = _sqlTransformer.TransformSql(_accQuery, request);
            var result = _entities.ExecuteStoreQuery<TTS_NBS>(query.SqlText, query.SqlParams);
            return result;
        }

        public decimal AccountsCount(DataSourceRequest request, string tt)
        {
            InitAccQuery();
            var count = _kendoSqlCounter.TransformSql(_accQuery, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }

        private void InitAccQuery()
        {
            _accQuery = new BarsSql()
            {
                SqlText = string.Format(@"SELECT nbs,name FROM ps ORDER BY nbs")
                    /*можливий запит:
                        SELECT nbs,name FROM ps minus
                            SELECT a.nbs, b.name
                            FROM ps_tts a, ps b 
                            WHERE a.nbs=b.nbs AND a.tt=:p_tt
                        ORDER BY nbs;
                    */,
                SqlParams = new object[] { }
            };
        }

        public BarsSql _insertAccComm;
        public BarsSql _deleteAccComm;
        public void InsertAccount(string tt, string nbs, decimal dk, string ob22)
        {
            InitInsertAccCommand(tt, nbs, dk, ob22);
            _entities.ExecuteStoreCommand(_insertAccComm.SqlText, _insertAccComm.SqlParams);
        }

        private void InitInsertAccCommand(string tt, string nbs, decimal dk, string ob22)
        {
            _insertAccComm = new BarsSql()
            {
                SqlText = string.Format(@"begin bars_ttsadm.set_ps_tts(:p_tt, :p_nbs, :p_dk, :p_ob22); end;"),
                SqlParams = new object[]
                {
                    new OracleParameter("p_tt", OracleDbType.Varchar2) { Value = tt },
                    new OracleParameter("p_nbs", OracleDbType.Varchar2) { Value = nbs },
                    new OracleParameter("p_dk", OracleDbType.Decimal) { Value = dk },
                    new OracleParameter("p_ob22", OracleDbType.Varchar2) { Value = ob22 }
                }
            };
        }

        public void DeleteAccount(string tt, string nbs, decimal dk, string ob22)
        {
            InitDeleteAccCommand(tt, nbs, dk, ob22);
            _entities.ExecuteStoreCommand(_deleteAccComm.SqlText, _deleteAccComm.SqlParams);
        }

        private void InitDeleteAccCommand(string tt, string nbs, decimal dk, string ob22)
        {
            _deleteAccComm = new BarsSql()
            {
                SqlText = string.Format(@"begin bars_ttsadm.remove_ps_tts(:p_tt, :p_nbs, :p_dk, :p_ob22); end;"),
                SqlParams = new object[]
                {
                    new OracleParameter("p_tt", OracleDbType.Varchar2) { Value = tt },
                    new OracleParameter("p_nbs", OracleDbType.Varchar2) { Value = nbs },
                    new OracleParameter("p_dk", OracleDbType.Decimal) { Value = dk },
                    new OracleParameter("p_ob22", OracleDbType.Varchar2) { Value = ob22 }
                }
            };
        }


        #endregion

        #region RelatedTransactionsData

        public BarsSql _relatedTransactionDataQuery;
        public BarsSql _transactionDataQuery;

        public IEnumerable<TTS_RelatedTransaction> RelatedTransactionData(DataSourceRequest request, string tt)
        {
            InitRelatedTransactionDataQuery(tt);
            var data = _sqlTransformer.TransformSql(_relatedTransactionDataQuery, request);
            var result = _entities.ExecuteStoreQuery<TTS_RelatedTransaction>(data.SqlText, data.SqlParams);
            return result;
        }

        public decimal RelatedTransactionDataCount(DataSourceRequest request, string tt)
        {
            InitRelatedTransactionDataQuery(tt);
            var count = _kendoSqlCounter.TransformSql(_relatedTransactionDataQuery, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }

        private void InitRelatedTransactionDataQuery(string tt)
        {
            _relatedTransactionDataQuery = new BarsSql()
            {
                SqlText = string.Format(@"
                    SELECT a.ttap TTAP, b.name NAME, a.dk DK 
                    FROM ttsap a,tts b 
                    WHERE a.ttap=b.tt AND a.tt=:p_tt 
                    ORDER BY a.ttap"),
                SqlParams = new object[] { new OracleParameter("p_tt", OracleDbType.Varchar2) { Value = tt } }
            };
        }

        public IEnumerable<TTS> TransactionData(DataSourceRequest request, string tt)
        {
            InitTransactionDataQuery(tt);
            var query = _sqlTransformer.TransformSql(_transactionDataQuery, request);
            var result = _entities.ExecuteStoreQuery<TTS>(query.SqlText, query.SqlParams);
            return result.AsQueryable();
        }

        public decimal TransactionDataCount(DataSourceRequest request, string tt)
        {
            InitTransactionDataQuery(tt);
            var count = _kendoSqlCounter.TransformSql(_transactionDataQuery, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }

        private void InitTransactionDataQuery(string tt)
        {
            _transactionDataQuery = new BarsSql()
            {
                SqlText = string.Format(@"
                    SELECT *
                    FROM tts    
                    WHERE (tt NOT IN (SELECT ttap FROM ttsap WHERE tt=:p_tt)) AND tt<>:p_tt_1     
                    ORDER BY tt"),
                SqlParams = new object[]
                {
                    new OracleParameter("p_tt", OracleDbType.Varchar2) {Value = tt},
                    new OracleParameter("p_tt_1", OracleDbType.Varchar2) {Value = tt}
                }
            };
        }

        public BarsSql _insertTransactionComm;
        public BarsSql _deleteTransactionComm;

        public void InsertTransaction(string tt, string ttap, decimal dk)
        {
            InitInsertTransactionCommand(tt, ttap, dk);
            _entities.ExecuteStoreCommand(_insertTransactionComm.SqlText, _insertTransactionComm.SqlParams);
        }

        private void InitInsertTransactionCommand(string tt, string ttap, decimal dk)
        {
            _insertTransactionComm = new BarsSql()
            {
                SqlText = string.Format(@"begin bars_ttsadm.set_ttsap(:p_tt, :p_ttap, :p_dk); end;"),
                SqlParams = new object[]
                {
                    new OracleParameter("p_tt", OracleDbType.Varchar2) { Value = tt },
                    new OracleParameter("p_ttap", OracleDbType.Varchar2) { Value = ttap },
                    new OracleParameter("p_dk", OracleDbType.Decimal) { Value = dk }
                }
            };
        }

        public void DeleteTransaction(string tt, string ttap)
        {
            InitDalateTransactionCommand(tt, ttap);
            _entities.ExecuteStoreCommand(_deleteTransactionComm.SqlText, _deleteTransactionComm.SqlParams);
        }

        private void InitDalateTransactionCommand(string tt, string ttap)
        {
            _deleteTransactionComm = new BarsSql()
            {
                SqlText = string.Format(@"begin bars_ttsadm.remove_ttsap(:p_tt, :p_ttap); end;"),
                SqlParams = new object[]
                {
                    new OracleParameter("p_tt", OracleDbType.Varchar2) { Value = tt },
                    new OracleParameter("p_ttap", OracleDbType.Varchar2) { Value = ttap }
                }
            };
        }

        #endregion

        #region VobData

        public BarsSql _vobDataQuery;
        public BarsSql _bankDocsQuery;
        public BarsSql _vobInsertComm;
        public BarsSql _vobDeleteComm;
        public IEnumerable<TTS_VOB> VobData(DataSourceRequest request, string tt)
        {
            InitVobDataQuery(tt);
            var query = _sqlTransformer.TransformSql(_vobDataQuery, request);
            var result = _entities.ExecuteStoreQuery<TTS_VOB>(query.SqlText, query.SqlParams);
            return result;
        }

        public decimal VobDataCount(DataSourceRequest request, string tt)
        {
            InitVobDataQuery(tt);
            var count = _kendoSqlCounter.TransformSql(_vobDataQuery, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }

        private void InitVobDataQuery(string tt)
        {
            _vobDataQuery = new BarsSql()
            {
                SqlText = string.Format(@"
                    SELECT a.vob VOB, b.name NAME, UPPER(b.rep_prefix) REP_PREFIX, a.ord ORD
                    FROM tts_vob a,vob b
                    WHERE a.vob=b.vob AND a.tt=:p_tt 
                    ORDER BY a.ord"),
                SqlParams = new object[] { new OracleParameter("p_tt", OracleDbType.Varchar2) { Value = tt } }
            };
        }

        public IEnumerable<TTS_BankDocsHandbook> BankDocsData(DataSourceRequest request, string tt)
        {
            InitBankDocsQuery(tt);
            var query = _sqlTransformer.TransformSql(_bankDocsQuery, request);
            var result = _entities.ExecuteStoreQuery<TTS_BankDocsHandbook>(query.SqlText, query.SqlParams);
            return result;
        }

        public decimal BankDocsCount(DataSourceRequest request, string tt)
        {
            InitBankDocsQuery(tt);
            var count = _kendoSqlCounter.TransformSql(_bankDocsQuery, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }

        private void InitBankDocsQuery(string tt)
        {
            _bankDocsQuery = new BarsSql()
            {
                SqlText = string.Format(@"SELECT vob,name FROM vob WHERE vob NOT IN (SELECT vob FROM tts_vob WHERE tt=:p_tt) ORDER BY name"),
                SqlParams = new object[] { new OracleParameter("p_tt", OracleDbType.Varchar2) { Value = tt } }
            };
        }

        public void InsertVob(string tt, decimal vob, decimal? ord)
        {
            InitVobInsertCommand(tt, vob, ord);
            _entities.ExecuteStoreCommand(_vobInsertComm.SqlText, _vobInsertComm.SqlParams);
        }

        private void InitVobInsertCommand(string tt, decimal vob, decimal? ord)
        {
            _vobInsertComm = new BarsSql()
            {
                SqlText = string.Format(@"
                    begin
                        bars_ttsadm.set_tts_vob(:p_tt, :p_vob, :p_ord);
                    end;
                "),
                SqlParams = new object[]
                {
                    new OracleParameter("p_tt", OracleDbType.Varchar2) { Value = tt },
                    new OracleParameter("p_vob", OracleDbType.Decimal) { Value = vob },
                    new OracleParameter("p_ord", OracleDbType.Decimal) { Value = ord.HasValue == true ? ord : 0 }
                }
            };
        }

        public void DeleteVob(string tt, decimal vob)
        {
            InitVobDeleteCommand(tt, vob);
            _entities.ExecuteStoreCommand(_vobDeleteComm.SqlText, _vobDeleteComm.SqlParams);
        }

        private void InitVobDeleteCommand(string tt, decimal vob)
        {
            _vobDeleteComm = new BarsSql()
            {
                SqlText = string.Format(@"
                    begin
                        bars_ttsadm.remove_tts_vob(:p_tt, :p_vob);
                    end;"),
                SqlParams = new object[]
                {
                    new OracleParameter("p_tt", OracleDbType.Varchar2) { Value = tt },
                    new OracleParameter("p_vob", OracleDbType.Decimal) { Value = vob }
                }
            };
        }

        #endregion

        #region MonitoringGroupData

        public BarsSql _monitoringGroupsQuery;
        public BarsSql _groupsQuery;

        public IEnumerable<TTS_MonitoringGroup> MonitoringGroupData(DataSourceRequest request, string tt)
        {
            InitMonitoringGroupsQuery(tt);
            var query = _sqlTransformer.TransformSql(_monitoringGroupsQuery, request);
            var result = _entities.ExecuteStoreQuery<TTS_MonitoringGroup>(query.SqlText, query.SqlParams);
            return result;
        }

        public decimal MonitoringGroupDataCount(DataSourceRequest request, string tt)
        {
            InitMonitoringGroupsQuery(tt);
            var count = _kendoSqlCounter.TransformSql(_monitoringGroupsQuery, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }

        private void InitMonitoringGroupsQuery(string tt)
        {
            _monitoringGroupsQuery = new BarsSql()
            {
                SqlText = string.Format(@"
                    SELECT a.idchk IDCHK, b.name NAME, a.f_in_charge F_IN_CHARGE, a.priority PRIORITY, a.sqlval SQLVAL, NVL(bitand(a.flags,1),0) FLAGS
                    FROM chklist_tts a,chklist b 
                    WHERE a.idchk=b.idchk AND a.tt=:p_tt
                    ORDER BY a.priority"),
                SqlParams = new object[] { new OracleParameter("p_tt", OracleDbType.Varchar2) { Value = tt } }
            };
        }

        public IEnumerable<CHKLIST> GroupData(DataSourceRequest request, string tt)
        {
            InitGroupsQuery(tt);
            var query = _sqlTransformer.TransformSql(_groupsQuery, request);
            var result = _entities.ExecuteStoreQuery<CHKLIST>(query.SqlText, query.SqlParams);
            return result;
        }

        public decimal GroupDataCount(DataSourceRequest request, string tt)
        {
            InitGroupsQuery(tt);
            var count = _kendoSqlCounter.TransformSql(_groupsQuery, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }

        private void InitGroupsQuery(string tt)
        {
            _groupsQuery = new BarsSql()
            {
                SqlText = string.Format(@"SELECT idchk,name FROM chklist WHERE idchk NOT IN (SELECT idchk FROM chklist_tts WHERE tt=:p_tt) ORDER BY name"),
                SqlParams = new object[] { new OracleParameter("p_tt", OracleDbType.Varchar2) { Value = tt } }
            };
        }

        public BarsSql _insertGroup;
        public BarsSql _deleteGroup;

        public void InsertGroup(string tt, decimal idchk, decimal priority, string sql, decimal? charge, string respond)
        {
            InitInsertGroupCommand(tt, idchk, priority, sql, charge, respond);
            _entities.ExecuteStoreCommand(_insertGroup.SqlText, _insertGroup.SqlParams);
        }
        private void InitInsertGroupCommand(string tt, decimal idchk, decimal priority, string sql, decimal? charge, string respond)
        {
            _insertGroup = new BarsSql()
            {
                SqlText = string.Format(@"
                    begin
                        bars_ttsadm.set_chklist_tts(:p_tt, :p_idchk, :p_priority, :p_sql, :p_charge, :p_respond);
                    end;
                "),
                SqlParams = new object[]
                {
                    new OracleParameter("p_tt", OracleDbType.Varchar2) { Value = tt },
                    new OracleParameter("p_idchk", OracleDbType.Decimal) { Value = idchk },
                    new OracleParameter("p_priority", OracleDbType.Decimal) { Value = priority },
                    new OracleParameter("p_sql", OracleDbType.Varchar2) { Value = sql },
                    new OracleParameter("p_charge", OracleDbType.Decimal) { Value = charge.HasValue == true ? charge : 0 },
                    new OracleParameter("p_respond", OracleDbType.Varchar2) { Value = respond }
                }
            };
        }

        public void DeleteGroup(string tt, decimal idchk)
        {
            InitDeleteGroupCommand(tt, idchk);
            _entities.ExecuteStoreCommand(_deleteGroup.SqlText, _deleteGroup.SqlParams);
        }

        private void InitDeleteGroupCommand(string tt, decimal idchk)
        {
            _deleteGroup = new BarsSql()
            {
                SqlText = string.Format(@"
                    begin
                        bars_ttsadm.remove_chklist_tts(:p_tt, :p_idchk);
                    end;
                "),
                SqlParams = new object[]
                {
                    new OracleParameter("p_tt", OracleDbType.Varchar2) { Value = tt },
                    new OracleParameter("p_idchk", OracleDbType.Decimal) { Value = idchk }
                }
            };
        }

        #endregion

        #region FoldersData

        public BarsSql _foldersDataQuery;
        public BarsSql _outFoldersDataQuery;
        public IEnumerable<TTS_FOLDERS> FolderData(DataSourceRequest request, string tt)
        {
            InitFoldersDataQuery(tt);
            var query = _sqlTransformer.TransformSql(_foldersDataQuery, request);
            var result = _entities.ExecuteStoreQuery<TTS_FOLDERS>(query.SqlText, query.SqlParams);
            return result;
        }

        public decimal FolderDataCount(DataSourceRequest request, string tt)
        {
            InitFoldersDataQuery(tt);
            var count = _kendoSqlCounter.TransformSql(_foldersDataQuery, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }

        private void InitFoldersDataQuery(string tt)
        {
            _foldersDataQuery = new BarsSql()
            {
                SqlText = string.Format(@"
                    SELECT a.idfo IDFO, b.name NAME
                    FROM folders_tts a, folders b
                    WHERE a.idfo=b.idfo AND a.tt=:strOperId 
                    ORDER BY b.name"),
                SqlParams = new object[] { new OracleParameter("p_tt", OracleDbType.Varchar2) { Value = tt } }
            };

        }

        public IEnumerable<TTS_FOLDERS> OutFoldersData(DataSourceRequest request, string tt)
        {
            InitOutFoldersDataQuery(tt);
            var query = _sqlTransformer.TransformSql(_outFoldersDataQuery, request);
            var result = _entities.ExecuteStoreQuery<TTS_FOLDERS>(query.SqlText, query.SqlParams);
            return result.AsQueryable();
        }

        public decimal OutFoldersDataCount(DataSourceRequest request, string tt)
        {
            InitOutFoldersDataQuery(tt);
            var count = _kendoSqlCounter.TransformSql(_outFoldersDataQuery, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }
        private void InitOutFoldersDataQuery(string tt)
        {
            _outFoldersDataQuery = new BarsSql()
            {
                SqlText = string.Format(@"SELECT idfo IDFO, name NAME
                    FROM folders
                    WHERE idfo NOT IN (SELECT idfo FROM folders_tts WHERE tt=:p_tt) ORDER BY name"),
                SqlParams = new object[] { new OracleParameter("p_tt", OracleDbType.Varchar2) { Value = tt } }
            };
        }

        public BarsSql _insertFolderCommand;
        public BarsSql _deleteFolderCommand;
        public void InsertFolder(string tt, decimal idfo)
        {
            InitInsertFolderCommand(tt, idfo);
            _entities.ExecuteStoreCommand(_insertFolderCommand.SqlText, _insertFolderCommand.SqlParams);
        }

        private void InitInsertFolderCommand(string tt, decimal idfo)
        {
            _insertFolderCommand = new BarsSql()
            {
                SqlText = string.Format(@"begin bars_ttsadm.set_folder_tts(:p_tt, :p_idfo); end;"),
                SqlParams = new object[]
                {
                    new OracleParameter("p_tt", OracleDbType.Varchar2) { Value = tt },
                    new OracleParameter("p_idfo", OracleDbType.Decimal) { Value = idfo }
                }
            };
        }

        public void DeleteFolder(string tt, decimal idfo)
        {
            InitDeleteFolderCommand(tt, idfo);
            _entities.ExecuteStoreCommand(_deleteFolderCommand.SqlText, _deleteFolderCommand.SqlParams);
        }

        private void InitDeleteFolderCommand(string tt, decimal idfo)
        {
            _deleteFolderCommand = new BarsSql()
            {
                SqlText = string.Format(@"begin bars_ttsadm.remove_folder_tts(:p_tt, :p_idfo); end;"),
                SqlParams = new object[]
                {
                    new OracleParameter("p_tt", OracleDbType.Varchar2) { Value = tt },
                    new OracleParameter("p_idfo", OracleDbType.Decimal) { Value = idfo }
                }
            };
        }

        #endregion


        public void RemoveProp(string tt, string tag)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("bars.bars_ttsadm.remove_rules", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add("p_tt", OracleDbType.Varchar2, tt, ParameterDirection.Input);
                command.Parameters.Add("p_tag", OracleDbType.Varchar2, tag, ParameterDirection.Input);

                command.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }
        }
        public byte[] ExportOperationsSQL(string cod)
        {
            var par = new OracleDynamicParameters();
            dynamic data = "";
            var p = new DynamicParameters();
            var sql = @"declare
                        l_blob blob;  
                        begin bars_ttsadm.SG_ExportOpers(:cod,2047,0);  
                        select bars_ttsadm.bl into :l_blob from dual;
                        end;";
            par.Add("cod", Convert.ToString(cod), OracleDbType.Varchar2, ParameterDirection.Input);
            par.Add("l_blob", null, OracleDbType.Blob, ParameterDirection.Output);
            //p.Add("l_blob", dbType: DbType.String, size: 5000, direction: ParameterDirection.Output);

            using (var connection = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = connection.CreateCommand())
            using (OracleParameter lBlob = new OracleParameter("l_blob", OracleDbType.Blob, null, ParameterDirection.Output))
            {
                cmd.CommandText = sql;
                cmd.Parameters.Add("cod", OracleDbType.Varchar2, Convert.ToString(cod), ParameterDirection.Input);
                cmd.Parameters.Add(lBlob);
                cmd.ExecuteNonQuery();

                using (OracleBlob _lBlobRes = (OracleBlob)lBlob.Value)
                {
                    if (_lBlobRes.IsNull) return null;
                    return _lBlobRes.Value;
                }
            }
        }
    }
}
