using System;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using Bars.Classes;
using BarsWeb.Areas.GL.Models;
using Dapper;
using BarsWeb.Core.Models;
using BarsWeb.Core.Extensions;
using AttributeRouting.Web.Http;
using BarsWeb.Core.Models.Binders.Api;
using Dapper;
using System.Collections.Generic;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.GL.Controllers.Api
{
    [AuthorizeApi]
    public class SchemeBuilderController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage GetCurrenciesList()
        {
            try
            {
                string sql = @"select kv as CurrId, kv || ' ' || name as Name from tabval where d_close is null order by kv";
                using (OracleConnection connection = OraConnector.Handler.UserConnection)
                {
                    List<BaseCurrency> list = connection.Query<BaseCurrency>(sql).ToList();
                    return Request.CreateResponse(HttpStatusCode.OK, list);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public DataSourceResult GetBanksList([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                string sql = @"select mfo as BankId, nb as Name from banks where nvl(blk,0)<>4";
                using (OracleConnection connection = OraConnector.Handler.UserConnection)
                {
                    List<BaseBank> list = connection.Query<BaseBank>(sql).ToList();
                    return list.ToDataSource(request);
                }
            }
            catch (Exception ex)
            {
                return new DataSourceResult
                {
                    Errors = new { message = ex.Message, stackTrace = ex.StackTrace },
                };
            }
        }

        [HttpGet]
        public DataSourceResult GetOperationList([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                string sql = @"select tt as Id, name from tts";
                using (OracleConnection connection = OraConnector.Handler.UserConnection)
                {
                    List<BaseDictionary> list = connection.Query<BaseDictionary>(sql).ToList();
                    return list.ToDataSource(request);
                }
            }
            catch (Exception ex)
            {
                return new DataSourceResult
                {
                    Errors = new { message = ex.Message, stackTrace = ex.StackTrace },
                };
            }
        }

        [HttpGet]
        public DataSourceResult GetOpTypeList([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                string sql = @"select vob as Id, name from vob";
                using (OracleConnection connection = OraConnector.Handler.UserConnection)
                {
                    List<BaseDictionary> list = connection.Query<BaseDictionary>(sql).ToList();
                    return list.ToDataSource(request);
                }
            }
            catch (Exception ex)
            {
                return new DataSourceResult
                {
                    Errors = new { message = ex.Message, stackTrace = ex.StackTrace },
                };
            }
        }


        [HttpGet]
        public HttpResponseMessage GetSchemeGroupList()
        {
            try
            {
                string sql = @"select idg as GroupId, name from perekr_g order by name";
                using (OracleConnection connection = OraConnector.Handler.UserConnection)
                {
                    List<SchemeGroup> list = connection.Query<SchemeGroup>(sql).ToList();
                    return Request.CreateResponse(HttpStatusCode.OK, list);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        /// <summary>
        /// Try find account by num and currency code
        /// </summary>
        /// <param name="accNum"></param>
        /// <param name="currId"></param>
        /// <returns></returns>
        [HttpGet]
        public HttpResponseMessage GetAccount(string accNum, int currId)
        {
            try
            {
                string sql = @"select acc as AccId, nls as AccNum, nms as Name, kv as CurrId from accounts where nls=:p_accNum and kv=:p_currId";

                DynamicParameters p = new DynamicParameters();
                p.Add("p_accNum", dbType: DbType.String, value: accNum, direction: ParameterDirection.Input);
                p.Add("p_currId", dbType: DbType.Decimal, value: currId, direction: ParameterDirection.Input);

                using (OracleConnection connection = OraConnector.Handler.UserConnection)
                {
                    //var account = connection.Query<BaseAccount>(sql, new { accNum, currId }).FirstOrDefault();
                    //var account = connection.Query<BaseAccount>(sql).FirstOrDefault();
                    BaseAccount account = connection.Query<BaseAccount>(sql, p).SingleOrDefault();
                    if (account == null)
                        return Request.CreateResponse(HttpStatusCode.NotFound, string.Format("Рахунок {0}({1}) не знайдено.", accNum, currId));

                    return Request.CreateResponse(HttpStatusCode.OK, account);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public DataSourceResult GetSchemeAccounts([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string groupId)
        {
            try
            {
                string sql = @" SELECT 
                                    a.nls as AccNum, 
                                    a.kv as CurrId, 
                                    a.nms as Name, 
                                    s.idg as GroupId, 
                                    s.ids as SchemaId, 
                                    s.sps as CalcMethod, 
                                    a.acc as AccId, 
                                    c.okpo CustCode
                                FROM 
                                    bars.accounts a, 
                                    bars.specparam s, 
                                    customer c 
                                WHERE 
                                    a.acc = s.acc 
                                    and c.rnk=a.rnk 
                                    and s.idg = :groupId 
                                ORDER BY a.nbs";

                using (OracleConnection connection = OraConnector.Handler.UserConnection)
                {
                    List<SchemeAccount> list = connection.Query<SchemeAccount>(sql, new { groupId }).ToList();
                    return list.ToDataSource(request);
                }
            }
            catch (Exception ex)
            {
                return new DataSourceResult
                {
                    Errors = new { message = ex.Message, stackTrace = ex.StackTrace },
                };
            }
        }

        [HttpGet]
        public DataSourceResult GetSchemeDetail([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string schemeId)
        {
            try
            {
                var sql = @"select 
                                id, 
                                ids as SchemaId, 
                                idr as Scale,  
                                vob as OpType, 
                                tt as OpCode, 
                                kv as CurrId, 
                                koef as Coefficient, 
                                mfob as RecipientBankId, 
                                nlsb as RecipientAccNum,  
                                polu as RecipientName, 
                                nazn as Narrative, 
                                okpo as RecipienCustCode,
                                kod as Kod,
                                formula as Formula
                            FROM perekr_b WHERE ids = :schemeId";

                using (OracleConnection connection = OraConnector.Handler.UserConnection)
                {
                    List<SchemeDetail> list = connection.Query<SchemeDetail>(sql, new { schemeId }).ToList();
                    return list.ToDataSource(request);
                }
            }
            catch (Exception ex)
            {
                return new DataSourceResult
                {
                    Errors = new { message = ex.Message, stackTrace = ex.StackTrace },
                };
            }
        }

        [HttpDelete]
        [DELETE("api/gl/SchemeBuilder/deleteSideB")]
        public HttpResponseMessage DeleteSideB(decimal id)
        {
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                DynamicParameters p = new DynamicParameters();
                p.Add("p_id", id, DbType.Decimal, ParameterDirection.Input);
                connection.Execute("bars.sps.delete_scheme_side_b", p, commandType: CommandType.StoredProcedure);
            }

            return Request.CreateResponse(HttpStatusCode.OK);
        }

        [HttpDelete]
        [DELETE("api/gl/SchemeBuilder/deleteSchemeAccount")]
        public HttpResponseMessage DeleteShemeAccount(decimal accId)
        {
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                DynamicParameters p = new DynamicParameters();
                p.Add("p_acc", accId, DbType.Decimal, ParameterDirection.Input);
                connection.Execute("bars.sps.delete_scheme_account", p, commandType: CommandType.StoredProcedure);
            }

            return Request.CreateResponse(HttpStatusCode.OK);
        }

        [HttpPost]
        [POST("api/gl/SchemeBuilder/editSchemeAccount")]
        public HttpResponseMessage EditSchemeAccount(SchemeAccount schemeAccount)
        {
            if (!schemeAccount.AccId.HasValue)
                return Request.CreateResponse(HttpStatusCode.NotFound, string.Format("Не передано рахунок для привязки."));
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                DynamicParameters p = new DynamicParameters();
                p.Add("p_acc", schemeAccount.AccId, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_group_id", schemeAccount.GroupId, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_scheme_id", schemeAccount.SchemaId, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_sps", schemeAccount.CalcMethod, DbType.Decimal, ParameterDirection.Input);

                connection.Execute("bars.sps.add_scheme_account", p, commandType: CommandType.StoredProcedure);
            }

            return Request.CreateResponse(HttpStatusCode.OK);
        }

        [HttpPost]
        [POST("api/gl/SchemeBuilder/batchEditSchemeSideB")]
        public HttpResponseMessage BatchEditSchemeSideB(List<SchemeDetail> schemeDetails)
        {
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                foreach (SchemeDetail item in schemeDetails)
                {
                    DynamicParameters p = new DynamicParameters();
                    p.Add("p_id", item.Id, DbType.Decimal, ParameterDirection.Input);
                    p.Add("p_scheme_id", item.SchemaId, DbType.Decimal, ParameterDirection.Input);
                    p.Add("p_op_type", item.OpType, DbType.Decimal, ParameterDirection.Input);
                    p.Add("p_op_code", item.OpCode, DbType.String, ParameterDirection.Input);
                    p.Add("p_mfob", item.RecipientBankId, DbType.String, ParameterDirection.Input);
                    p.Add("p_nlsb", item.RecipientAccNum, DbType.String, ParameterDirection.Input);
                    p.Add("p_kv", item.CurrId, DbType.Decimal, ParameterDirection.Input);
                    p.Add("p_koef", item.Coefficient, DbType.Decimal, ParameterDirection.Input);
                    p.Add("p_polu", item.RecipientName, DbType.String, ParameterDirection.Input);
                    p.Add("p_nazn", item.Narrative, DbType.String, ParameterDirection.Input);
                    p.Add("p_okpo", item.RecipienCustCode, DbType.String, ParameterDirection.Input);
                    p.Add("p_idr", item.Scale, DbType.Decimal, ParameterDirection.Input);
                    
                    p.Add("p_kod", item.Kod, DbType.Decimal, ParameterDirection.Input);
                    p.Add("p_formula", item.Formula, DbType.String, ParameterDirection.Input);

                    connection.Execute("bars.sps.add_scheme_side_b", p, commandType: CommandType.StoredProcedure);
                }
            }

            return Request.CreateResponse(HttpStatusCode.OK, schemeDetails);
        }

        [HttpPost]
        [POST("api/gl/SchemeBuilder/editSchemeSideB")]
        public HttpResponseMessage EditSchemeSideB(SchemeDetail schemeDetail)
        {
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                // validate data
                // vob 
                string sql = @"select vob from vob where vob=:OpType";
                var result = connection.Query(sql, new { schemeDetail.OpType }).FirstOrDefault();
                if (result == null)
                    return Request.CreateResponse(HttpStatusCode.NotFound, string.Format("Вказаного типу операції ({0}) не знайдено в довіднику", schemeDetail.OpType));
                decimal totalCoef = 0, prevCoef = 0;
                // все коефициенты на сейчас
                if (schemeDetail.SchemaId.HasValue)
                    totalCoef = connection.Query<decimal>("select nvl(sum(koef), 0) from perekr_b where ids=:SchemaId and (formula is null or formula = '')", new { schemeDetail.SchemaId }).FirstOrDefault();

                // меняем существующий, сначала нужно прошлое значения
                if (schemeDetail.Id.HasValue)
                    prevCoef = connection.Query<decimal>("select koef from perekr_b where id=:Id", new { schemeDetail.Id }).First();

                decimal? coef = null;

                if (!string.IsNullOrWhiteSpace(schemeDetail.Formula))
                    coef = totalCoef;
                else
                    coef = totalCoef - prevCoef + schemeDetail.Coefficient;

                if (1 != coef && 0 != coef)
                    return Request.CreateResponse(HttpStatusCode.BadRequest, string.Format("Сума коефіцієнтів має бути ріною 1 або 0.", schemeDetail.OpType));

                // control sum 
                sql = "select VKRZN(substr(:RecipientBankId, 1, 5), :RecipientAccNum) from dual";
                string accNum = connection.Query<string>(sql, new { schemeDetail.RecipientBankId, schemeDetail.RecipientAccNum }).FirstOrDefault();
                if (accNum != schemeDetail.RecipientAccNum)
                    return Request.CreateResponse(HttpStatusCode.BadRequest, string.Format("Невірний контрольний розряд (рахунок {0}, МФО {1}), коректний рахунок {2}", schemeDetail.RecipientAccNum, schemeDetail.RecipientBankId, accNum));

                var p = new DynamicParameters();
                p.Add("p_id", schemeDetail.Id, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_scheme_id", schemeDetail.SchemaId, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_op_type", schemeDetail.OpType, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_op_code", schemeDetail.OpCode, DbType.String, ParameterDirection.Input);
                p.Add("p_mfob", schemeDetail.RecipientBankId, DbType.String, ParameterDirection.Input);
                p.Add("p_nlsb", schemeDetail.RecipientAccNum, DbType.String, ParameterDirection.Input);
                p.Add("p_kv", schemeDetail.CurrId, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_koef", schemeDetail.Coefficient, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_polu", schemeDetail.RecipientName, DbType.String, ParameterDirection.Input);
                p.Add("p_nazn", schemeDetail.Narrative, DbType.String, ParameterDirection.Input);
                p.Add("p_okpo", schemeDetail.RecipienCustCode, DbType.String, ParameterDirection.Input);
                p.Add("p_idr", schemeDetail.Scale, DbType.Decimal, ParameterDirection.Input);

                p.Add("p_kod", schemeDetail.Kod, DbType.Decimal, ParameterDirection.Input);
                p.Add("p_formula", schemeDetail.Formula, DbType.String, ParameterDirection.Input);

                connection.Execute("bars.sps.add_scheme_side_b", p, commandType: CommandType.StoredProcedure);
            }

            return Request.CreateResponse(HttpStatusCode.OK, schemeDetail);
        }

    }
}