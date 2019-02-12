using Areas.Finmom.Models;
using Areas.Finmon.Models;
using BarsWeb.Areas.Finmon.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Finmon.Infrastructure.DI.Implementation;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Models;
using System.Collections.Generic;
using Oracle.DataAccess.Client;
using Bars.Classes;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using System.Data.Objects;
using System.Linq;
using System;
using System.Globalization;
using System.Data;
using BarsWeb.Infrastructure.Helpers;
using System.IO;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using Bars.Oracle;

namespace BarsWeb.Areas.Finmon.Infrastructure.Repository.DI.Implementation
{
    public class FmDocumentsRepository : IFmDocumentsRepository
    {
        readonly IKendoSqlTransformer _sqlTransformer;
        readonly IKendoSqlCounter _kendoSqlCounter;
        private readonly FinmonModel _entities;

        CultureInfo ci;

        public FmDocumentsRepository(IKendoSqlTransformer sqlTransformer, IKendoSqlCounter kendoSqlCounter)
        {
            var connectionStr = EntitiesConnection.ConnectionString("FmonModel", "Finmon");
            _entities = new FinmonModel(connectionStr);

            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;

            ci = CultureInfo.CreateSpecificCulture("en-GB");
            ci.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
            ci.DateTimeFormat.DateSeparator = ".";
        }

        #region Kendo DS
        public KendoGridDs<Document> GetDocuments(DataSourceRequest request, DocsGridFilter filter)
        {
            return GetKendoGridDs<Document>(request, GetDocumentsSql(filter));
        }
        public KendoGridDs<Filter<decimal>> GetRules(DataSourceRequest request)
        {
            return GetKendoGridDs<Filter<decimal>>(request, SqlCreator.FmRules());
        }
        public KendoGridDs<Filter<string>> GetDocumentStatuses(DataSourceRequest request)
        {
            return GetKendoGridDs<Filter<string>>(request, SqlCreator.DocumentStatuses());
        }
        public KendoGridDs<FmTerrorist> GetTerroristsList(DataSourceRequest request, int otm)
        {
            return GetKendoGridDs<FmTerrorist>(request, SqlCreator.FmTerrorist(otm));
        }

        public KendoGridDs<DictRow> GetDict(DataSourceRequest request, string dictName, string code)
        {
            return GetKendoGridDs<DictRow>(request, SqlCreator.GetDict(dictName, code));
        }

        public KendoGridDs<ClientData> GetClientsDict(DataSourceRequest request, long? rnk, string okpo, string name)
        {
            return GetKendoGridDs<ClientData>(request, SqlCreator.GetClientsDict(rnk, okpo, name));
        }

        public KendoGridDs<HistoryRow> GetHistory(DataSourceRequest request, string id)
        {
            if (string.IsNullOrWhiteSpace(id)) return new KendoGridDs<HistoryRow>();
            return GetKendoGridDs<HistoryRow>(request, SqlCreator.GetHistory(id));
        }
        #endregion

        public List<string> CheckDictCodes(List<string> codes, string dictName)
        {
            List<string> errors = new List<string>();
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            {
                foreach (string code in codes)
                {
                    BarsSql a = SqlCreator.GetDict(dictName, code);
                    List<DictRow> res = _entities.ExecuteStoreQuery<DictRow>(a.SqlText, a.SqlParams).ToList();
                    if (res.Count() <= 0)
                        errors.Add(code);
                }
            }

            return errors;
        }

        public int GetDocumentsCount(DocsGridFilter filter)
        {
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            {
                BarsSql sql = GetDocumentsSql(filter, true);
                cmd.CommandText = sql.SqlText;
                cmd.BindByName = true;
                cmd.Parameters.AddRange(sql.SqlParams);

                object _res = cmd.ExecuteScalar();
                if (null == _res) return 0;
                return Convert.ToInt32(_res);
            }
        }
        /// <summary>
        /// Формування SQL запиту для відбору документів по заданим фільтрам
        /// </summary>
        /// <param name="filter">Задані користувачем фільтри</param>
        /// <param name="isCount">true = отримати кількість записів, false = отримати самі записи</param>
        /// <returns></returns>
        private BarsSql GetDocumentsSql(DocsGridFilter filter, bool isCount = false)
        {
            BarsSql res;
            if (null == filter.Rules || filter.Rules.Count <= 0)
            {
                DateTime _from = Convert.ToDateTime(filter.From, ci);
                DateTime _to = Convert.ToDateTime(filter.To, ci);
                res = SqlCreator.FmDocumentsByPeriod(_from, _to, isCount);
            }
            else
            {
                res = SqlCreator.FmDocumentsByRules(isCount);
            }
            if (null != filter.Statuses && filter.Statuses.Count > 0)
            {
                //string[] r = nums.Select(x => x + "a").ToArray();
                string[] statuses = filter.Statuses.Select(s => string.Format("'{0}'", s)).ToArray();
                res.SqlText += " and ( v_finmon_que_oper.status in (" + string.Join(",", statuses) + ") " + (filter.Statuses.IndexOf("-") != -1 ? " or v_finmon_que_oper.status is null " : "") + " )";
            }

            res.SqlText += filter.ShowBlockedOnly ? " and to_number(v_finmon_que_oper.otm) != 0 " : "";

            switch (filter.FormType.ToUpper())
            {
                case "SUBDIVISION":
                    res.SqlText += " and exists (select 1 from v_fm_func_kontr where ref = v_finmon_que_oper.ref)";
                    break;
                case "USER":
                    res.SqlText += " and exists (select 1 from v_fm_func_oper where ref = v_finmon_que_oper.ref)";
                    break;
                case "INPUT":
                    res.SqlText += " and exists (SELECT R.REF FROM V_OPER_DEPARTMENT R WHERE R.REF=v_finmon_que_oper.REF and v_finmon_que_oper.TT='R01')";
                    break;
                default:
                    break;
            }

            if (!string.IsNullOrWhiteSpace(filter.CustomFilters))
                res.SqlText += filter.CustomFilters;

            res.SqlText += " and ROWNUM <= 100000";
            return res;
        }

        public void SetRules(DocsGridFilter model)
        {
            DateTime _from = Convert.ToDateTime(model.From, ci);
            DateTime _to = Convert.ToDateTime(model.To, ci);

            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "p_fm_checkrules";
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("p_dat1", OracleDbType.Date, _from, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_dat2", OracleDbType.Date, _to, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_rules", OracleDbType.Varchar2, string.Join(",", model.Rules.ToArray()), System.Data.ParameterDirection.Input);

                cmd.ExecuteNonQuery();
            }
        }

        public string GetPreviousBankDate()
        {
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "select to_char(bars.DAT_NEXT_U(bars.web_utl.get_bankdate,-1),'dd.mm.yyyy') from dual";

                object res = cmd.ExecuteScalar();

                if (null != res)
                {
                    return Convert.ToString(res);
                }
                else throw new Exception("Error on get_bankdate (empty result)");
            }
        }
        public int Unblock(List<Document> documents)
        {
            int counter = 0;

            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "bars.p_fm_unblock";

                foreach (Document doc in documents)
                {
                    if ("0" != doc.Otm)
                    {
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("p_ref", OracleDbType.Decimal, doc.Ref, System.Data.ParameterDirection.Input);
                        cmd.Parameters.Add("p_rec", OracleDbType.Decimal, null, System.Data.ParameterDirection.Input);
                        cmd.ExecuteNonQuery();
                        counter++;
                    }
                }
            }
            return counter;
        }

        public int SendDocuments(List<Document> documents)
        {
            int count = 0;
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            {
                for (int i = 0; i < documents.Count; i++)
                {
                    Document curDoc = documents[i];
                    if ((string.IsNullOrWhiteSpace(curDoc.Status) && !string.IsNullOrWhiteSpace(curDoc.Otm))
                        || (!string.IsNullOrWhiteSpace(curDoc.Status) && ("I" == curDoc.Status || "S" == curDoc.Status)))
                    {
                        string status = !string.IsNullOrWhiteSpace(curDoc.Otm) ? "T" : "N";
                        SetStatus(con, refference: curDoc.Ref, status: status);
                        count++;
                    }
                }
            }
            return count;
        }
        public void SendDocumentsBulk(List<Document> documents)
        {
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "bars.p_fm_bulk_set_status";

                List<decimal?> refs = documents.ConvertAll(x => x.Ref);
                OracleParameter refsParam = new OracleParameter("p_refs", OracleDbType.Array, refs.Count(), refs.ToArray(), ParameterDirection.Input);
                refsParam.UdtTypeName = "BARS.NUMBER_LIST";

                cmd.Parameters.Add(refsParam);

                cmd.ExecuteNonQuery();
            }
        }

        public void StatusReported(List<Document> documents, string comment)
        {
            SetStatus(documents, "I", comment);
        }

        public void Exclude(List<Document> documents)
        {
            SetStatus(documents, "B");
        }

        public void SetASide(List<Document> documents)
        {
            SetStatus(documents, "S");
        }

        public byte[] ExportToExcel(DocsGridFilter filter)
        {
            BarsSql sql = GetDocumentsSql(filter);
            DataTable dt = new DataTable();
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = sql.SqlText;
                cmd.Parameters.AddRange(sql.SqlParams);
                using (OracleDataAdapter dataAdapter = new OracleDataAdapter())
                {
                    dataAdapter.SelectCommand = cmd;
                    dataAdapter.Fill(dt);
                }
            }

            ExcelExportModel excelModel = new ExcelExportModel();

            foreach (KeyValuePair<string, string> item in excelModel.Fields)
            {
                dt.Columns[item.Key].ColumnName = item.Value;
            }

            List<string> moneyWildcards = new List<string> { "оборот", "кредит", "дебет", "залишок", "сума", "Sum", "Sum2", "SumEquivalent", "SumEquivalent2" };
            List<int> moneyColumns = new List<int>();
            for (int i = 0, max = dt.Columns.Count; i < max; i++)
            {
                foreach (var mw in moneyWildcards)
                {
                    if (dt.Columns[i].Caption.ToLower().Contains(mw.ToLower()))
                    {
                        moneyColumns.Add(i + 1);
                    }
                }
            }

            var rep = new RegisterCountsDPARepository();
            var userInf = rep.GetPrintHeader();

            List<Dictionary<string, object>> res = new List<Dictionary<string, object>>();

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                Dictionary<string, object> row = new Dictionary<string, object>();
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    string key = dt.Columns[j].Caption;
                    var value = dt.Rows[i][j];
                    row[key] = value;
                }
                res.Add(row);
            }

            List<string[]> fileContentHat = new List<string[]>();
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                fileContentHat.Add(new string[] { dt.Columns[i].ColumnName, dt.Columns[i].Caption });
            }

            List<TableInfo> tableInfo = new List<TableInfo>();
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                string colDataType = string.Empty;
                int excelRowNum = i + 1;
                if (moneyColumns.Contains(excelRowNum))
                {
                    colDataType = "Money";
                }
                else
                {
                    colDataType = dt.Columns[i].DataType.FullName;
                }

                tableInfo.Add(new TableInfo(dt.Columns[i].ColumnName, dt.Columns[i].MaxLength, colDataType, dt.Columns[i].AllowDBNull));
            }

            List<string> hat = new List<string>
                    {
                        "АТ 'ОЩАДБАНК'",
                        "Користувач:" + userInf.USER_NAME,
                        "Дата: " + userInf.DATE.ToString("dd'.'MM'.'yyyy") + " Час: " + userInf.DATE.Hour + ":" + userInf.DATE.Minute + ":" + userInf.DATE.Second
                    };

            var excel = new ExcelHelpers<List<Dictionary<string, object>>>(res, fileContentHat, tableInfo, null, hat);

            using (MemoryStream ms = excel.ExportToMemoryStream())
            {
                ms.Position = 0;
                return ms.ToArray();
            }
        }

        #region FmRules
        public DocumentFmRules GetDocumentFmRules(decimal _ref)
        {
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            {
                BarsSql sql = SqlCreator.DocumentFmRules(_ref);
                DocumentFmRules res = _entities.ExecuteStoreQuery<DocumentFmRules>(sql.SqlText, sql.SqlParams).FirstOrDefault();
                res.ClientA = SearchClientData(res.RnkA, res.NlsA, res.Kv, res.MfoA, res.OkpoA);
                res.ClientB = SearchClientData(res.RnkB, res.NlsB, res.Kv2, res.MfoB, res.OkpoB);

                return res;
            }
        }

        public DocumentFmRules GetDocumentsFmRules(List<decimal> _refs)
        {
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            {
                BarsSql sql = SqlCreator.DocumentsFmRules(_refs);
                List<DocumentFmRules> res = _entities.ExecuteStoreQuery<DocumentFmRules>(sql.SqlText, sql.SqlParams).ToList();
                if (res.Count() != 1) throw new Exception("Неоднорідні дані");

                return res[0];
            }
        }

        public void SaveDocumentFmRules(FmRulesSaveModel model)
        {
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "bars.fm_utl.set_fm_params";
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                cmd.Parameters.Add(new OracleParameter("p_id", OracleDbType.Decimal, model.Data.Id, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_ref", OracleDbType.Decimal, model.Data.Ref, ParameterDirection.Input));

                cmd.Parameters.Add(new OracleParameter("p_rec", OracleDbType.Decimal, null, ParameterDirection.Input));

                cmd.Parameters.Add(new OracleParameter("p_vid1", OracleDbType.Varchar2, model.Data.OprVid1, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_vid1", OracleDbType.Varchar2, model.Data.OprVid2, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_comm2", OracleDbType.Varchar2, model.Data.CommVid2, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_vid3", OracleDbType.Varchar2, model.Data.OprVid3, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_comm3", OracleDbType.Varchar2, model.Data.CommVid3, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_mode", OracleDbType.Decimal, model.Data.Md, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_rnka", OracleDbType.Decimal, model.Data.ClientA.Rnk, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_rnkb", OracleDbType.Decimal, model.Data.ClientB.Rnk, ParameterDirection.Input));
                cmd.Parameters.Add(ToOraDict(model.Vids2, "p_vids2"));
                cmd.Parameters.Add(ToOraDict(model.Vids3, "p_vids3"));
                cmd.ExecuteNonQuery();
            }
        }
        public void SaveDocumentsFmRules(FmRulesSaveModel model)
        {
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "bars.fm_utl.set_fm_params_bulk";
                cmd.CommandType = System.Data.CommandType.StoredProcedure;


                OracleParameter refsParam = new OracleParameter("p_refs", OracleDbType.Array, model.Refs.Count(), model.Refs.ToArray(), ParameterDirection.Input);
                refsParam.UdtTypeName = "BARS.NUMBER_LIST";

                cmd.Parameters.Add(refsParam);
                cmd.Parameters.Add(new OracleParameter("p_opr_vid1", OracleDbType.Varchar2, model.Data.OprVid1, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_opr_vid2", OracleDbType.Varchar2, model.Data.OprVid2, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_comm2", OracleDbType.Varchar2, model.Data.CommVid2, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_opr_vid3", OracleDbType.Varchar2, model.Data.OprVid3, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_comm3", OracleDbType.Varchar2, model.Data.CommVid3, ParameterDirection.Input));

                cmd.Parameters.Add(new OracleParameter("p_mode", OracleDbType.Decimal, model.Data.Md, ParameterDirection.Input));
                cmd.Parameters.Add(ToOraDict(model.Vids2, "p_vid2"));
                cmd.Parameters.Add(ToOraDict(model.Vids3, "p_vid3"));
                cmd.ExecuteNonQuery();
            }
        }

        /// <summary>
        /// Приведення значення строкового параметру "Додаткові коди моніторингу" до типу BARS.T_DICTIONARY для передачі в процедуру
        /// </summary>
        /// <param name="val">строка зі значеннями розділеними пробілом ("5252 1452 1478")</param>
        /// <param name="paramName">Назва параметра в процедурі</param>
        private OracleParameter ToOraDict(string val, string paramName)
        {
            List<OraDictionaryItem> mainParamsDict = new List<OraDictionaryItem>();
            string[] _val = val.Split(' ');
            if (string.IsNullOrWhiteSpace(val)) _val = new string[] { };

            for (int i = 0; i < _val.Length; i++)
            {
                mainParamsDict.Add(new OraDictionaryItem { Key = Convert.ToString(i), Value = _val[i] });
            }

            OracleParameter dictionaryMainParameter = new OracleParameter(paramName, OracleDbType.Array, ParameterDirection.Input);
            dictionaryMainParameter.Value = mainParamsDict.Count() > 0 ? (OraDictionary)mainParamsDict : null;
            dictionaryMainParameter.UdtTypeName = "BARS.T_DICTIONARY";

            return dictionaryMainParameter;
        }
        #endregion
        /// <summary>
        /// Пошук клієнта
        /// </summary>
        private ClientData SearchClientData(long? rnk, string nls, int kv, string mfo, string okpo)
        {
            BarsSql sql = SqlCreator.GetClientData(rnk, nls, kv, mfo, okpo);
            return _entities.ExecuteStoreQuery<ClientData>(sql.SqlText, sql.SqlParams).FirstOrDefault();
        }

        #region private
        /// <summary>
        /// Встановлення статусу масиву документів
        /// </summary>
        private void SetStatus(List<Document> documents, string status, string comment = "")
        {
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            {
                for (int i = 0; i < documents.Count; i++)
                {
                    SetStatus(con, refference: documents[i].Ref, status: status, comment: comment);
                }
            }
        }
        /// <summary>
        /// Встановлення статусу документу
        /// </summary>
        private void SetStatus(OracleConnection con, decimal? refference = null, decimal? rec = null, string status = null, string comment = "", decimal? blk = null)
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandText = "bars.p_fm_set_status";
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.BindByName = true;

                cmd.Parameters.Add("p_ref", OracleDbType.Decimal, refference, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_rec", OracleDbType.Decimal, rec, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_status", OracleDbType.Varchar2, status, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_comments", OracleDbType.Varchar2, comment, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_blk", OracleDbType.Decimal, blk, System.Data.ParameterDirection.Input);

                cmd.ExecuteNonQuery();
            }
        }

        /// <summary>
        /// Формування об'єкту dataSource для kendo-гріда
        /// </summary>
        private KendoGridDs<T> GetKendoGridDs<T>(DataSourceRequest request, BarsSql sql)
        {
            return new KendoGridDs<T>
            {
                Total = CountGlobal(request, sql),
                Data = SearchGlobal<T>(request, sql)
            };
        }

        private IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _sqlTransformer.TransformSql(searchQuery, request);
            var item = _entities.ExecuteStoreQuery<T>(query.SqlText, query.SqlParams);
            return item;
        }
        private decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _kendoSqlCounter.TransformSql(searchQuery, request);
            ObjectResult<decimal> res = _entities.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams);
            decimal count = res.Single();
            return count;
        }
        #endregion
    }
}