﻿using System;
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
                var sql = @"select kv as CurrId, kv || ' ' || name as Name from tabval where d_close is null order by kv";
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var list = connection.Query<BaseCurrency>(sql).ToList();
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
                var sql = @"select mfo as BankId, nb as Name from banks where nvl(blk,0)<>4";
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var list = connection.Query<BaseBank>(sql).ToList();
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
                var sql = @"select tt as Id, name from tts";
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var list = connection.Query<BaseDictionary>(sql).ToList();
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
                var sql = @"select vob as Id, name from vob";
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var list = connection.Query<BaseDictionary>(sql).ToList();
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
                var sql = @"select idg as GroupId, name from perekr_g order by name";
                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var list = connection.Query<SchemeGroup>(sql).ToList();
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
                var sql = @"select acc as AccId, nls as AccNum, nms as Name, kv as CurrId from accounts where nls=:p_accNum and kv=:p_currId";

                var p = new DynamicParameters();
                p.Add("p_accNum", dbType:DbType.String,value:accNum,direction:ParameterDirection.Input);
                p.Add("p_currId", dbType: DbType.Decimal, value: currId, direction: ParameterDirection.Input);

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    //var account = connection.Query<BaseAccount>(sql, new { accNum, currId }).FirstOrDefault();
                    //var account = connection.Query<BaseAccount>(sql).FirstOrDefault();
                    var account = connection.Query<BaseAccount>(sql,p).SingleOrDefault();
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
                var sql = @"SELECT a.nls as AccNum, a.kv as CurrId, a.nms as Name, s.idg as GroupId, s.ids as SchemaId, s.sps as CalcMethod, a.acc as AccId, c.okpo CustCode
                            FROM bars.accounts a, bars.specparam s, customer c 
                            WHERE a.acc=s.acc AND c.rnk=a.rnk and s.idg = :groupId ORDER BY a.nbs";

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var list = connection.Query<SchemeAccount>(sql, new { groupId }).ToList();
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
                var sql = @"select id, ids as SchemaId, idr as Scale,  vob as OpType, tt as OpCode, kv as CurrId, koef as Coefficient, mfob as RecipientBankId, nlsb as RecipientAccNum,  polu as RecipientName, nazn as Narrative, okpo as RecipienCustCode
                            FROM perekr_b WHERE ids=:schemeId";

                using (var connection = OraConnector.Handler.UserConnection)
                {
                    var list = connection.Query<SchemeDetail>(sql, new { schemeId }).ToList();
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
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
                p.Add("p_id", id, DbType.Decimal, ParameterDirection.Input);
                connection.Execute("bars.sps.delete_scheme_side_b", p, commandType: CommandType.StoredProcedure);
            }

            return Request.CreateResponse(HttpStatusCode.OK);
        }

        [HttpDelete]
        [DELETE("api/gl/SchemeBuilder/deleteSchemeAccount")]
        public HttpResponseMessage DeleteShemeAccount(decimal accId)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
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
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var p = new DynamicParameters();
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
            using (var connection = OraConnector.Handler.UserConnection)
            {
                foreach (var schemeDetail in schemeDetails)
                {
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
                    connection.Execute("bars.sps.add_scheme_side_b", p, commandType: CommandType.StoredProcedure);
                }
            }

            return Request.CreateResponse(HttpStatusCode.OK, schemeDetails);
        }

        [HttpPost]
        [POST("api/gl/SchemeBuilder/editSchemeSideB")]
        public HttpResponseMessage EditSchemeSideB(SchemeDetail schemeDetail)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                // validate data
                // vob 
                var sql = @"select vob from vob where vob=:OpType";
                var result = connection.Query(sql, new { schemeDetail.OpType }).FirstOrDefault();
                if (result == null)
                    return Request.CreateResponse(HttpStatusCode.NotFound, string.Format("Вказаного типу операції ({0}) не знайдено в довіднику", schemeDetail.OpType));
                decimal totalCoef = 0, prevCoef = 0;
                // все коефициенты на сейчас
                if (schemeDetail.SchemaId.HasValue)
                    totalCoef = connection.Query<decimal>("select nvl(sum(koef), 0) from perekr_b where ids=:SchemaId", new { schemeDetail.SchemaId }).FirstOrDefault();

                // меняем существующий, сначала нужно прошлое значения
                if (schemeDetail.Id.HasValue) 
                    prevCoef = connection.Query<decimal>("select koef from perekr_b where id=:Id", new { schemeDetail.Id }).First();

                if (totalCoef  - prevCoef  + schemeDetail.Coefficient > 1)
                    return Request.CreateResponse(HttpStatusCode.BadRequest, string.Format("Сума коефіцієнтів має бути не більша 1.", schemeDetail.OpType));

                // control sum 
                sql = "select VKRZN(substr(:RecipientBankId, 1, 5), :RecipientAccNum) from dual";
                var accNum = connection.Query<string>(sql, new { schemeDetail.RecipientBankId, schemeDetail.RecipientAccNum }).FirstOrDefault();
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
                connection.Execute("bars.sps.add_scheme_side_b", p, commandType: CommandType.StoredProcedure);
            }

            return Request.CreateResponse(HttpStatusCode.OK, schemeDetail);
        }

    }
}