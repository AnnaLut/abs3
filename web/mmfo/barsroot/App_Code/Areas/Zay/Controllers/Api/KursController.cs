using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;

namespace BarsWeb.Areas.Zay.Models
{
    public class KursController : ApiController
    {
        private readonly ICurrencyDictionary _dictionary;
        public KursController(ICurrencyDictionary dictionary)
        {
            _dictionary = dictionary;
        }
        public HttpResponseMessage Get()
        {
            try
            {
                var data = _dictionary.KursDictionary();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data);
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.NoContent, ex.Message);
            }
        }
    }

}