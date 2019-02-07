﻿using System.Web.Http;
using BarsWeb.Core.Logger;
using System.Net;
using System.Net.Http;
using BarsWeb.Areas.WebApi.Subvention.Infrastructure.DI.Abstract;
using System.Xml;
using System;
using System.Text;
using AttributeRouting.Web.Http;
using System.Collections.Generic;
using BarsWeb.Areas.WebApi.Subvention.Models;
using System.Globalization;
using Newtonsoft.Json;
using BarsWeb.Areas.WebApi.Subvention.Infrastructure.DI.Implementation;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.WebApi.Subvention
{
    public class SubventionController : ApiController
    {
        readonly ISubventionRepository _repo;
        private readonly IDbLogger _logger;

        public SubventionController(ISubventionRepository repo, IDbLogger logger)
        {
            _logger = logger;
            _repo = repo;
        }

        private HttpResponseMessage Error(Exception ex)
        {
            _logger.Info(ex.Message + ex.StackTrace, "SubventionApi");
            Response r = new Response();
            r.ErrorMessage = ex.Message;
            r.ResultCode = 666;
            HttpStatusCode s = HttpStatusCode.OK;

            if (ex is SubException)
            {
                SubException _ex = (SubException)ex;
                r.ResultCode = _ex.Code == 10 ? 20000 : Convert.ToInt32(_ex.Code);

                if (r.ResultCode == 20000)
                    r.ErrorMessage = _ex.Code + " : " + _ex.Message;
                else
                    r.ErrorMessage = _ex.Message;

                s = HttpStatusCode.OK;
            }
            else if (ex is FormatException)
            {
                r.ResultCode = 20001;
                r.ErrorMessage = "Не коректний формат дати. " + Environment.NewLine + ex.Message;
            }
            else if (ex is OracleException)
            {
                r.ResultCode = 20002;
            }
            else if (ex is JsonSerializationException)
            {
                r.ResultCode = 20003;
                r.ErrorMessage = "Помилка при десеріалізації. " + Environment.NewLine + ex.Message;
            }
            else if (ex is ArgumentNullException)
            {
                r.ResultCode = 20004;
            }
            else s = HttpStatusCode.InternalServerError;

            return Request.CreateResponse(s, r);
        }

        [HttpGet]
        [GET("api/Subvention/GetAccBalance/{from}/{to}")]
        public HttpResponseMessage GetAccBalance([FromUri] string from, [FromUri] string to)
        {
            try
            {
                AccBalance result = _repo.GetAccBalance(from, to);
                Response<AccBalance> resp = new Response<AccBalance>();
                resp.ResultMessage = result;

                return Request.CreateResponse(HttpStatusCode.OK, resp);
            }
            catch (Exception ex) { return Error(ex); }
        }

        [HttpPost]
        [POST("api/Subvention/HouseholdPayments")]
        public HttpResponseMessage HouseholdPayments(HttpRequestMessage request)
        {
            try
            {
                throw new NotImplementedException("Метод HouseholdPayments не доступний.");

                string data = request.Content.ReadAsStringAsync().Result;
                if (string.IsNullOrWhiteSpace(data)) throw new ArgumentNullException("Content", "Тіло запиту не може бути пустим");

                HHPayments _data = JsonConvert.DeserializeObject<HHPayments>(data);

                string requestId = _repo.HouseholdPayments(_data);
                Response<string> resp = new Response<string>();
                resp.ResultMessage = requestId;

                return Request.CreateResponse(HttpStatusCode.OK, resp);
            }
            catch (Exception ex) { return Error(ex); }
        }

        [HttpGet]
        [GET("api/Subvention/HouseholdReceive/{requestId}")]
        public HttpResponseMessage HouseholdReceive([FromUri] string requestId)
        {
            try
            {
                throw new NotImplementedException("Метод HouseholdReceive не доступний.");

                Response<string> resp = new Response<string>();
                resp.ResultMessage = _repo.GetTicket(requestId);

                return Request.CreateResponse(HttpStatusCode.OK, resp);
            }
            catch (Exception ex) { return Error(ex); }
        }
    }
}
