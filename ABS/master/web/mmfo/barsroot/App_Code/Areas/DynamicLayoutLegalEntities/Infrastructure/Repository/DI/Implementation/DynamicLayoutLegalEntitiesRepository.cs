using Areas.DynamicLayoutLegalEntities.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.DynamicLayoutLegalEntities.Infrastructure.DI.Abstract;
using BarsWeb.Core.Models;
using BarsWeb.Models;
using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using System.Data;
using Bars.Classes;
using Dapper;
using System.Text;
using System.Globalization;

namespace BarsWeb.Areas.DynamicLayoutLegalEntities.Infrastructure.DI.Implementation
{
    public class DynamicLayoutLegalEntitiesRepository : IDynamicLayoutLegalEntitiesRepository
    {
        readonly DynamicLayoutLegalEntitiesModel _DynamicLayoutLegalEntities;
        readonly IKendoSqlTransformer _sqlTransformer;
        readonly IKendoSqlCounter _kendoSqlCounter;
        readonly IParamsRepository _globalData;
        public DynamicLayoutLegalEntitiesRepository(IKendoSqlTransformer sqlTransformer, IKendoSqlCounter kendoSqlCounter, IParamsRepository globalData)
        {
            _DynamicLayoutLegalEntities = new DynamicLayoutLegalEntitiesModel(EntitiesConnection.ConnectionString("DynamicLayoutLegalEntitiesModel", "DynamicLayoutLegalEntities"));

            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
            _globalData = globalData;
        }
        private const string _errorRes = "ERROR";
        public string ErrorResult
        {
            get
            {
                return _errorRes;
            }
        }


        #region layout functions
        public void ClearDynamicLayout()
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                connection.Execute("DYNAMIC_LAYOUT_UI.CLEAR_DYNAMIC_LAYOUT", p, commandType: CommandType.StoredProcedure);
            }
        }
        public void CreateDynamicLayout(decimal? pMode, decimal? pDk, string pNls, string pBs, string pOb, decimal? pGrp, int flag)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_mode", pMode, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_dk", pDk, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_nls", pNls, DbType.String, ParameterDirection.Input);
                p.Add("p_bs", pBs, DbType.String, ParameterDirection.Input);
                p.Add("p_ob", pOb, DbType.String, ParameterDirection.Input);
                p.Add("p_grp", pGrp, DbType.Decimal, ParameterDirection.Input);
                p.Add("flag", flag, DbType.Decimal, ParameterDirection.Input);

                connection.Execute("DYNAMIC_LAYOUT_UI.CREATE_DYNAMIC_LAYOUT", p, commandType: CommandType.StoredProcedure);
            }
        }

        private void CreateDateFormatExeption(string name, string value)
        {
            if (string.IsNullOrWhiteSpace(value))
                value = "null or empty value";
            string msg = string.Format("Не коректний формат дати '{0}' : '{1}'<br/>Очікувався формат : 'dd/MM/yyyy'", name, value);

            throw new Exception(msg);
        }

        public void UpdateDynamicLayout(UpdateDynamicLayoutDataModel model)
        {
            DateTime pDatd, pDatFrom, pDatTo;

            //if (!DateTime.TryParseExact(model.pDatd, "dd/MM/yyyy", null, System.Globalization.DateTimeStyles.None, out pDatd)) CreateDateFormatExeption("Дата документу(розпорядження)", model.pDatd);
            //if (!DateTime.TryParseExact(model.pDatFrom, "dd/MM/yyyy", null, System.Globalization.DateTimeStyles.None, out pDatFrom)) CreateDateFormatExeption("Дата 'З'", model.pDatFrom);
            //if (!DateTime.TryParseExact(model.pDatTo, "dd/MM/yyyy", null, System.Globalization.DateTimeStyles.None, out pDatTo)) CreateDateFormatExeption("Дата 'По'", model.pDatTo);

            CultureInfo ci = CultureInfo.CreateSpecificCulture("en-GB");
            ci.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            ci.DateTimeFormat.DateSeparator = "/";

            pDatd = Convert.ToDateTime(model.pDatd, ci);
            pDatFrom = Convert.ToDateTime(model.pDatFrom, ci);
            pDatTo = Convert.ToDateTime(model.pDatTo, ci);

            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_nd", model.pNd, DbType.String, ParameterDirection.Input);
                p.Add("p_datd", pDatd, DbType.Date, ParameterDirection.Input);
                p.Add("p_dat_from", pDatFrom, DbType.Date, ParameterDirection.Input);
                p.Add("p_dat_to", pDatTo, DbType.Date, ParameterDirection.Input);
                p.Add("p_dates_to_nazn", model.pDatesToNazn, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_nazn", model.pNazn, DbType.String, ParameterDirection.Input);
                p.Add("p_summ", model.pSum, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_corr", model.pCorr, DbType.Decimal, ParameterDirection.Input);

                connection.Execute("DYNAMIC_LAYOUT_UI.UPDATE_DYNAMIC_LAYOUT", p, commandType: CommandType.StoredProcedure);
            }
        }

        public string ExeptionProcessing(Exception ex)
        {
            return ex.Message;

            //string txt = "";
            //var ErrorText = ex.Message.ToString();

            //byte[] strBytes = Encoding.UTF8.GetBytes(ErrorText);
            //ErrorText = Encoding.UTF8.GetString(strBytes);

            //var x = ErrorText.IndexOf("ORA");
            //var ora = ErrorText.Substring(x + 4, 5); //-20001

            //if (x < 0) return ErrorText;

            //if (Convert.ToDecimal(ora) >= 20000)
            //{
            //    var ora1 = ErrorText.Substring(x + 11);
            //    var y = ora1.IndexOf("ORA");
            //    if (x > -1 && y > 0)
            //    {
            //        txt = ErrorText.Substring(x + 11, y - 1);
            //    }
            //    else
            //    {
            //        txt = ErrorText;
            //    }

            //    string tmpResult = txt.Replace('ы', 'і');
            //    return tmpResult;
            //}
            //else
            //    return ErrorText;
        }

        public ResponseDL ErrorResponse(Exception ex)
        {
            return new ResponseDL()
            {
                Result = ErrorResult,
                ErrorMsg = ExeptionProcessing(ex)
            };
        }

        public void CalculateDynamicLayout(decimal? pId, int flag)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_id", pId, DbType.Decimal, ParameterDirection.Input);
                p.Add("flag", flag, DbType.Decimal, ParameterDirection.Input);

                connection.Execute("DYNAMIC_LAYOUT_UI.CALCULATE_DYNAMIC_LAYOUT", p, commandType: CommandType.StoredProcedure);
            }
        }
        public void CalculateStaticLayout()
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute("DYNAMIC_LAYOUT_UI.CALCULATE_STATIC_LAYOUT", new DynamicParameters(), commandType: CommandType.StoredProcedure);
            }
        }

        public void PayStaticLayout(decimal? pMak)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_mak", pMak, DbType.Decimal, ParameterDirection.Input);

                connection.Execute("DYNAMIC_LAYOUT_UI.PAY_STATIC_LAYOUT", p, commandType: CommandType.StoredProcedure);
            }
        }

        private string Right(string value, int length)
        {
            return value.Substring(value.Length - length);
        }
        public void PaySelectedStaticLayout(SLDetailA model)
        {
            Currents dateAndMfo = currentBDateMfo();
            DateTime bDate = DateTime.Parse(dateAndMfo.BDate);

            var _dk = getDK((decimal)model.ID, (decimal)model.USERID);

            using (var connection = OraConnector.Handler.UserConnection)
            {

                Bars.Doc.cDoc document = new Bars.Doc.cDoc(
                    connection,
                    0,
                    model.TT,
                    (byte)_dk,
                    Convert.ToInt16(model.VOB),
                    string.IsNullOrWhiteSpace(model.ND) ? "" : model.ND,
                    bDate,
                    bDate,
                    bDate,
                    bDate,
                    model.NLS_A.NullToEmpty(),
                    model.NAMA.NullToEmpty(),
                    GetParam("MFO").Value,
                    "",
                    Convert.ToInt16(model.KV),
                    (decimal)model.SUMM_A,
                    model.OKPOA.NullToEmpty(),
                    model.NLS_B.NullToEmpty(),
                    model.NAMB.NullToEmpty(),
                    model.MFOB.NullToEmpty(),
                    model.MFOB_NAME.NullToEmpty(),
                    Convert.ToInt16(model.KV),
                    (decimal)model.SUMM_A,
                    model.OKPOB.NullToEmpty(),
                    model.NAZN.NullToEmpty(),
                    "",
                    "",
                    null, 0, 0, 0, "", "", "", "");
                if (document.oDocument())
                {
                    var _ref = document.Ref;

                    var p = new DynamicParameters();
                    p.Add("new_ref", (long)_ref, DbType.Decimal, ParameterDirection.Input);
                    p.Add("model_id", model.ID, DbType.Decimal, ParameterDirection.Input);
                    p.Add("model_user_id", model.USERID, DbType.Decimal, ParameterDirection.Input);
                    string updateSql = @"update TMP_DYNAMIC_LAYOUT_DETAIL set REF = :new_ref where id = :model_id and USERID = :model_user_id";
                    connection.Execute(updateSql, p);
                }
                else
                    throw new System.Exception("При спробі оплати відбулась непередбачувана помилка");
            }

        }

        private Currents currentBDateMfo()
        {
            var sql = @"SELECT bankdate() BDate , BARS.gl.kf Mfo FROM dual";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<Currents>(sql).ToList().FirstOrDefault();
            }
        }

        private int getDK(decimal modelId, decimal userId)
        {
            var sql = @"select DK from TMP_DYNAMIC_LAYOUT_DETAIL where id = :model_id and USERID = :model_user_id";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("model_id", modelId, DbType.Decimal, ParameterDirection.Input);
                p.Add("model_user_id", userId, DbType.Decimal, ParameterDirection.Input);

                return connection.Query<int>(sql, p).ToList().FirstOrDefault();
            }
        }

        public void DeleteStaticLayout(decimal? pGrp, decimal? pId)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_grp", pGrp, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_id", pId, DbType.Decimal, ParameterDirection.Input);

                connection.Execute("DYNAMIC_LAYOUT_UI.DELETE_STATIC_LAYOUT", p, commandType: CommandType.StoredProcedure);
            }
        }

        public void AddStaticLayout(AddStaticLayoutDataModel model)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_id", model.pId, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_dk", model.pDk, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_nd", model.pNd, DbType.String, ParameterDirection.Input);
                p.Add("p_kv", model.pKv, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_nlsa", model.pNlsa, DbType.String, ParameterDirection.Input);
                p.Add("p_nam_a", model.pNamA, DbType.String, ParameterDirection.Input);
                p.Add("p_okpo_a", model.pOkpoA, DbType.String, ParameterDirection.Input);
                p.Add("p_mfo_b", model.pMfoB, DbType.String, ParameterDirection.Input);
                p.Add("p_nls_b", model.pNlsB, DbType.String, ParameterDirection.Input);
                p.Add("p_nam_b", model.pNamB, DbType.String, ParameterDirection.Input);
                p.Add("p_okpo_b", model.pOkpoB, DbType.String, ParameterDirection.Input);
                p.Add("p_percent", model.pPercent, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_sum_a", model.pSumA, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_sum_b", model.pSumB, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_delta", model.pDelta, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_tt", model.pTt, DbType.String, ParameterDirection.Input);
                p.Add("p_vob", model.pVob, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_nazn", model.pNazn, DbType.String, ParameterDirection.Input);
                p.Add("p_ord", model.pOrd, DbType.Decimal, ParameterDirection.Input);
                p.Add("flag", model.Flag, DbType.Decimal, ParameterDirection.Input);

                connection.Execute("DYNAMIC_LAYOUT_UI.ADD_STATIC_LAYOUT", p, commandType: CommandType.StoredProcedure);
            }
        }

        #region commented
        //public void UPDATE_DYNAMIC_LAYOUT(string P_ND, DateTime? P_DATD, DateTime? P_DAT_FROM, DateTime? P_DAT_TO, decimal? P_DATES_TO_NAZN, string P_NAZN, decimal? P_SUMM, decimal? P_CORR)
        //{
        //    List<OracleParameter> parameters = new List<OracleParameter>();
        //    parameters.Add(new OracleParameter("P_ND", OracleDbType.Varchar2, P_ND, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_DATD", OracleDbType.Date, P_DATD, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_DAT_FROM", OracleDbType.Date, P_DAT_FROM, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_DAT_TO", OracleDbType.Date, P_DAT_TO, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_DATES_TO_NAZN", OracleDbType.Decimal, P_DATES_TO_NAZN, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_NAZN", OracleDbType.Varchar2, P_NAZN, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_SUMM", OracleDbType.Decimal, P_SUMM, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_CORR", OracleDbType.Decimal, P_CORR, ParameterDirection.Input));
        //    object ReturnValue = null;
        //    ExecuteNonQuery("DYNAMIC_LAYOUT_UI.UPDATE_DYNAMIC_LAYOUT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        //}
        //public void UPDATE_DYNAMIC_LAYOUT_DETAIL(decimal? P_ID, decimal? P_PERSENTS, decimal? P_SUMM_A, decimal? P_TOTAL_SUM)
        //{
        //    List<OracleParameter> parameters = new List<OracleParameter>();
        //    parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal, P_ID, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_PERSENTS", OracleDbType.Decimal, P_PERSENTS, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_SUMM_A", OracleDbType.Decimal, P_SUMM_A, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_TOTAL_SUM", OracleDbType.Decimal, P_TOTAL_SUM, ParameterDirection.Input));
        //    object ReturnValue = null;
        //    ExecuteNonQuery("DYNAMIC_LAYOUT_UI.UPDATE_DYNAMIC_LAYOUT_DETAIL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        //}
        //public void UPDATE_KV_B(decimal? P_KVB)
        //{
        //    List<OracleParameter> parameters = new List<OracleParameter>();
        //    parameters.Add(new OracleParameter("P_KVB", OracleDbType.Decimal, P_KVB, ParameterDirection.Input));
        //    object ReturnValue = null;
        //    ExecuteNonQuery("DYNAMIC_LAYOUT_UI.UPDATE_KV_B", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        //}
        //public void CALCULATE_DYNAMIC_LAYOUT(decimal? P_ID)
        //{
        //    List<OracleParameter> parameters = new List<OracleParameter>();
        //    parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal, P_ID, ParameterDirection.Input));
        //    object ReturnValue = null;
        //    ExecuteNonQuery("DYNAMIC_LAYOUT_UI.CALCULATE_DYNAMIC_LAYOUT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        //}
        //public void CALCULATE_STATIC_LAYOUT()
        //{
        //    List<OracleParameter> parameters = new List<OracleParameter>();
        //    object ReturnValue = null;
        //    ExecuteNonQuery("DYNAMIC_LAYOUT_UI.CALCULATE_STATIC_LAYOUT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        //}
        //public void ADD_STATIC_LAYOUT(decimal? P_ID, decimal? P_DK, string P_ND, decimal? P_KV, string P_NLSA, string P_NAM_A, string P_OKPO_A, string P_MFO_B, 
        //    string P_NLS_B, string P_NAM_B, string P_OKPO_B, decimal? P_PERCENT, decimal? P_SUM_A, decimal? P_SUM_B, decimal? P_DELTA, string P_TT, decimal? P_VOB, 
        //    string P_NAZN, decimal? P_ORD)
        //{
        //    List<OracleParameter> parameters = new List<OracleParameter>();
        //    parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal, P_ID, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_DK", OracleDbType.Decimal, P_DK, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_ND", OracleDbType.Varchar2, P_ND, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_KV", OracleDbType.Decimal, P_KV, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_NLSA", OracleDbType.Varchar2, P_NLSA, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_NAM_A", OracleDbType.Varchar2, P_NAM_A, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_OKPO_A", OracleDbType.Varchar2, P_OKPO_A, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_MFO_B", OracleDbType.Varchar2, P_MFO_B, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_NLS_B", OracleDbType.Varchar2, P_NLS_B, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_NAM_B", OracleDbType.Varchar2, P_NAM_B, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_OKPO_B", OracleDbType.Varchar2, P_OKPO_B, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_PERCENT", OracleDbType.Decimal, P_PERCENT, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_SUM_A", OracleDbType.Decimal, P_SUM_A, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_SUM_B", OracleDbType.Decimal, P_SUM_B, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_DELTA", OracleDbType.Decimal, P_DELTA, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_TT", OracleDbType.Varchar2, P_TT, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_VOB", OracleDbType.Decimal, P_VOB, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_NAZN", OracleDbType.Varchar2, P_NAZN, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_ORD", OracleDbType.Decimal, P_ORD, ParameterDirection.Input));
        //    object ReturnValue = null;
        //    ExecuteNonQuery("DYNAMIC_LAYOUT_UI.ADD_STATIC_LAYOUT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        //}
        //public void DELETE_STATIC_LAYOUT(decimal? P_GRP, decimal? P_ID)
        //{
        //    List<OracleParameter> parameters = new List<OracleParameter>();
        //    parameters.Add(new OracleParameter("P_GRP", OracleDbType.Decimal, P_GRP, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal, P_ID, ParameterDirection.Input));
        //    object ReturnValue = null;
        //    ExecuteNonQuery("DYNAMIC_LAYOUT_UI.DELETE_STATIC_LAYOUT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        //}
        //public void PAY_DYNAMIC_LAYOUT(Decimal? P_MAK, String P_ND)
        //{
        //    List<OracleParameter> parameters = new List<OracleParameter>();
        //    parameters.Add(new OracleParameter("P_MAK", OracleDbType.Decimal, P_MAK, ParameterDirection.Input));
        //    parameters.Add(new OracleParameter("P_ND", OracleDbType.Varchar2, P_ND, ParameterDirection.Input));
        //    object ReturnValue = null;
        //    ExecuteNonQuery("DYNAMIC_LAYOUT_UI.PAY_DYNAMIC_LAYOUT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        //}
        //public void PAY_STATIC_LAYOUT(Decimal? P_MAK)
        //{
        //    List<OracleParameter> parameters = new List<OracleParameter>();
        //    parameters.Add(new OracleParameter("P_MAK", OracleDbType.Decimal, P_MAK, ParameterDirection.Input));
        //    object ReturnValue = null;
        //    ExecuteNonQuery("DYNAMIC_LAYOUT_UI.PAY_STATIC_LAYOUT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        //}
        //public String HEADER_VERSION()
        //{
        //    List<OracleParameter> parameters = new List<OracleParameter>();
        //    parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
        //    object ReturnValue = null;
        //    ExecuteNonQuery("DYNAMIC_LAYOUT_UI.HEADER_VERSION", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        //    OracleString res = (OracleString)ReturnValue;
        //    return res.IsNull ? (String)null : res.Value;
        //}
        //public String BODY_VERSION()
        //{
        //    List<OracleParameter> parameters = new List<OracleParameter>();
        //    parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
        //    object ReturnValue = null;
        //    ExecuteNonQuery("DYNAMIC_LAYOUT_UI.BODY_VERSION", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        //    OracleString res = (OracleString)ReturnValue;
        //    return res.IsNull ? (String)null : res.Value;
        //} 
        #endregion
        #endregion
        #region Global search & Count
        public IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _sqlTransformer.TransformSql(searchQuery, request);
            var item = _DynamicLayoutLegalEntities.ExecuteStoreQuery<T>(query.SqlText, query.SqlParams);
            return item;
        }
        public decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _kendoSqlCounter.TransformSql(searchQuery, request);
            ObjectResult<decimal> res = _DynamicLayoutLegalEntities.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams);
            decimal count = res.Single();
            return count;
        }
        public IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery)
        {
            return _DynamicLayoutLegalEntities.ExecuteStoreQuery<T>(searchQuery.SqlText, searchQuery.SqlParams);
        }

        public int ExecuteStoreCommand(string commandText, params object[] parameters)
        {
            return _DynamicLayoutLegalEntities.ExecuteStoreCommand(commandText, parameters);
        }

        public Params GetParam(string id)
        {
            return _globalData.GetParam(id);
        }
        #endregion
    }
    public static class StringEx
    {
        public static string NullToEmpty(this string val)
        {
            if (string.IsNullOrWhiteSpace(val)) return string.Empty;
            return val;
        }
    }
}
