using System;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web.Http;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract.Individual;
using BarsWeb.Areas.Cdm.Models.Transport;

namespace BarsWeb.Areas.Cdm.Controllers.Api.Individual
{
    public class IndividualPersonV2Controller : ApiController
    {
        private readonly ICdmRepository _cdmRepository;
        private int _allowedCardsPerRequest = 10000;

        public IndividualPersonV2Controller(ICdmRepository cdmRepository)
        {
            _cdmRepository = cdmRepository;
        }

        public HttpResponseMessage PutIndividualPersonCardsChanges(RequestFromEbkV2 request)
        {
            var response = new ResponseV2();
            response.SetStatus(ResponseStatus.ERROR);
            if (ModelState.IsValid)
            {
                try
                {
                    _cdmRepository.SavePersonCardsFast(request, _allowedCardsPerRequest);
                    response.SetStatus(ResponseStatus.OK);
                }
                catch (Exception e)
                {
                    response.Message = e.InnerException == null ? e.Message : e.InnerException.Message;
                }
            }
            else
            {
                response.Message = GetModelErrors();
            }
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        public HttpResponseMessage PostGcif(RequestFromEbkV2 data)
        {
            ResponseV2 response = new ResponseV2();
            response.SetStatus(ResponseStatus.ERROR);
            if (ModelState.IsValid)
            {
                try
                {
                    if (null != data.Entries)
                    {
                        foreach (var entry in data.Entries)
                        {
                            if (null != entry.Cards)
                            {
                                _cdmRepository.SaveGcifs(entry.Cards.ToArray(), data.BatchId);
                            }
                        }
                    }
                    
                    response.SetStatus(ResponseStatus.OK);
                }
                catch (Exception e)
                {
                    response.Message = e.InnerException == null ? e.Message : e.InnerException.Message;
                    if (e.StackTrace != null)
                    {
                        response.Message = response.Message + Environment.NewLine + e.StackTrace;
                    }
                    if (e.InnerException != null && e.InnerException.StackTrace != null)
                    {
                        response.Message = response.Message + Environment.NewLine + e.InnerException.StackTrace;
                    }
                    var logger = BarsWeb.Core.Logger.DbLoggerConstruct.NewDbLogger();
                    logger.Error("ЕБК. Помилка збереження пакету! --" + response.Message);

                }
            }
            else
            {
                response.Message = GetModelErrors();
            }
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }

        public HttpResponseMessage DeleteMany(string[] gcifs)
        {
            var responce=new ResponseV2();
            responce.SetStatus(ResponseStatus.ERROR);
            try
            {
                _cdmRepository.DeleteGcifs(gcifs);
                responce.SetStatus(ResponseStatus.OK);
            }
            catch (Exception e)
            {
                responce.Message=
                    e.InnerException==null
                        ?e.Message
                        :e.InnerException.Message;

            }

            return Request.CreateResponse(HttpStatusCode.OK, responce);
        }

        public HttpResponseMessage DeleteOne(string id)
        {
            var response = new Response();
            response.SetStatus(ResponseStatus.ERROR);
            try
            {
                _cdmRepository.DeleteGcif(id);
                response.SetStatus(ResponseStatus.OK);
            }
            catch (Exception e)
            {
                response.Msg = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Request.CreateResponse(HttpStatusCode.OK, response);
        }
        
        private string GetModelErrors()
        {
            var result = new StringBuilder();
            foreach (var modelState in ModelState.Values)
            {
                foreach (var error in modelState.Errors)
                {
                    result.Append((string.IsNullOrEmpty(error.ErrorMessage)
                                      ? error.Exception.Message
                                      : error.ErrorMessage) + Environment.NewLine);
                }
            }
            return result.ToString();
        }
    }
}