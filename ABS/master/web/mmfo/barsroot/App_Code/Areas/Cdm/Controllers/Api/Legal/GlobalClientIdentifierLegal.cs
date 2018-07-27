﻿using System;
using BarsWeb.Areas.Cdm.Models.Transport;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web.Http;
using BarsWeb.Areas.Cdm.Infrastructure.DI.Abstract.Legal;

namespace BarsWeb.Areas.Cdm.Controllers.Api
{
    public class GlobalClientIdentifierLegalController : ApiController
    {
        private readonly ICdmLegalRepository _repo;

        public GlobalClientIdentifierLegalController(ICdmLegalRepository repository)
        {
            _repo = repository;
        }
        public HttpResponseMessage PostGcif(DupesAndGcifs data)
        {
            Response resp = new Response();
            resp.SetStatus(ResponseStatus.ERROR);
            if (ModelState.IsValid)
            {
                try
                {
                    _repo.SaveGcifs(data.MasterCards, data.BatchId);
                    _repo.SaveDuplicates(data.DuplicatedClients, data.BatchId);
                    resp.SetStatus(ResponseStatus.OK);
                }
                catch (Exception e)
                {
                    resp.Msg = e.InnerException == null ? e.Message : e.InnerException.Message;
                    if (e.StackTrace != null)
                    {
                        resp.Msg = resp.Msg + Environment.NewLine + e.StackTrace;
                    }
                    if (e.InnerException != null && e.InnerException.StackTrace != null)
                    {
                        resp.Msg = resp.Msg + Environment.NewLine + e.InnerException.StackTrace;
                    }
                    var logger = BarsWeb.Core.Logger.DbLoggerConstruct.NewDbLogger();
                    logger.Error("EBK. Помилка збереження пакету! --" + resp.Msg);

                }
            }
            else
            {
                resp.Msg = GetModelErrors();
            }
            return Request.CreateResponse(HttpStatusCode.OK, resp);
        }

        public HttpResponseMessage DeleteMany(string[] gсifs)
        {
            var resp = new Response();
            resp.SetStatus(ResponseStatus.ERROR);
            try
            {
                _repo.DeleteGcifs(gсifs);
                resp.SetStatus(ResponseStatus.OK);
            }
            catch (Exception e)
            {
                resp.Msg = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Request.CreateResponse(HttpStatusCode.OK, resp);
        }

        public HttpResponseMessage DeleteOne(string id)
        {
            var resp = new Response();
            resp.SetStatus(ResponseStatus.ERROR);
            try
            {
                _repo.DeleteGcif(id);
                resp.SetStatus(ResponseStatus.OK);
            }
            catch (Exception e)
            {
                resp.Msg = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Request.CreateResponse(HttpStatusCode.OK, resp);
        }


        //TODO вынести в базовый какойто ЕБК класс
        private string GetModelErrors()
        {
            var result = new StringBuilder();
            foreach (var modelState in ModelState.Values)
            {
                foreach (var error in modelState.Errors)
                {
                    result.Append((string.IsNullOrEmpty(error.ErrorMessage) ? error.Exception.Message : error.ErrorMessage) + Environment.NewLine);
                }
            }
            return result.ToString();
        }
    }
}