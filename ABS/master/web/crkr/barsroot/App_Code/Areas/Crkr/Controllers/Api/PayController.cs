using System;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Services;
using Bars.Classes;
using BarsWeb.Areas.Crkr.Models;
using Dapper;
using CommandType = System.Data.CommandType;
using BarsWeb.Areas.Crkr.Infrastructure.DI.Abstract;

namespace BarsWeb.Areas.Crkr.Controllers.Api
{
    [AuthorizeApi]
    public class PayController : ApiController
    {
        private IRegisterRepository _repository;
        public PayController(IRegisterRepository repository)
        {
            _repository = repository;
        }

        [HttpPost]
        public HttpResponseMessage CreateReg(Registry item)
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, _repository.CreateRegister(item));
            }
            catch(Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage SendPay(Registry item)
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, _repository.SendRegister(item));
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }

        [HttpPost]
        [WebMethod]
        public HttpResponseMessage BlockUnBlockpay(Registry item)
        {
            return Request.CreateResponse(HttpStatusCode.OK, _repository.BlockOrUnBlock(item));
        }
        
        [HttpGet]
        public HttpResponseMessage Statistic(string type)
        {
            var p = new DynamicParameters();
            #region DONT OPEN
            if (type == "dep")
            {
                p.Add("p_regcode ", "PAY_DEP", DbType.String, ParameterDirection.Input);
            }
            else if (type == "bur")
            {
                p.Add("p_regcode ", "PAY_BUR", DbType.String, ParameterDirection.Input);
            }
            p.Add("p_count_compen_all", null, DbType.Int64, ParameterDirection.Output);
            p.Add("p_count_act_all", null, DbType.Int64, ParameterDirection.Output);
            p.Add("p_count_act_reg", null, DbType.Int64, ParameterDirection.Output);
            p.Add("p_count_compen_reg", null, DbType.Int64, ParameterDirection.Output);
            p.Add("p_count_compen_new", null, DbType.Int64, ParameterDirection.Output);
            p.Add("p_sum_state_new", null, DbType.Int64, ParameterDirection.Output);
            p.Add("p_sum_state_formed", null, DbType.Int64, ParameterDirection.Output);
            p.Add("p_sum_state_payed", null, DbType.Int64, ParameterDirection.Output);
            p.Add("p_sum_state_block", null, DbType.Int64, ParameterDirection.Output);
            p.Add("p_date_first", null, DbType.DateTime, ParameterDirection.Output);
            p.Add("p_date_last", null, DbType.DateTime, ParameterDirection.Output);
            #endregion

            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute("crkr_compen_web.get_stat_registry", p, commandType: CommandType.StoredProcedure);
                var obj = new
                {
                    compenAll = p.Get<long?>("p_count_compen_all"),
                    actAll = p.Get<long?>("p_count_act_all"),
                    actReg = p.Get<long?>("p_count_act_reg"),
                    compenReg = p.Get<long?>("p_count_compen_reg"),
                    compenNew = p.Get<long?>("p_count_compen_new"),
                    stateNew = p.Get<long?>("p_sum_state_new"),
                    stateFormed = p.Get<long?>("p_sum_state_formed"),
                    statePayed = p.Get<long?>("p_sum_state_payed"),
                    stateBlock = p.Get<long?>("p_sum_state_block"),
                    dateFirst = p.Get<DateTime?>("p_date_first").ToString(),
                    dateLast = p.Get<DateTime?>("p_date_last").ToString()
                };
                return Request.CreateResponse(HttpStatusCode.OK, obj);
            }
        }

        [HttpPost]
        public HttpResponseMessage OnlyPlanDepos(Registry item)
        {
            return Request.CreateResponse(HttpStatusCode.OK, _repository.GetPeyments(item));
        }

        [HttpGet]
        public HttpResponseMessage GetOperActual(string startDate, string endDate, bool funeral)
        {
            var query = "select * from v_compen_actual_compens v where v.user_id = bars.user_id ";
            object param = null;
            if (!string.IsNullOrEmpty(startDate) && !string.IsNullOrEmpty(endDate))
            {
                query = query.Insert(query.Length, " and l_date >= to_date(:startDate, 'dd.mm.yyyy') and l_date <= to_date(:endDate, 'dd.mm.yyyy')");
                param = new { startDate, endDate };
            }
            if (funeral)
            {
                query = query.Insert(query.Length, " and v.oper_type = 6 ");
            }
            else
            {
                query = query.Insert(query.Length, " and v.oper_type = 5 ");
            }


            using (var connection = OraConnector.Handler.UserConnection)
            {
                return Request.CreateResponse(HttpStatusCode.OK, connection.Query(query, param).ToList());
            }
        }

        [HttpGet]
        public HttpResponseMessage OperWay(decimal regid)
        {
            var query = "select FIO, OST, AMOUNT from v_compen_operpay where REG_ID = :regid";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return Request.CreateResponse(HttpStatusCode.OK, connection.Query(query, new { regid }).ToList());
            }
        }
    }
}
