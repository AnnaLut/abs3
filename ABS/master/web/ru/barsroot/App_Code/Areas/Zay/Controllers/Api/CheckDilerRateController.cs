using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Zay.Models;

namespace BarsWeb.Areas.Zay.Controllers.Api
{
    [AuthorizeApi]
    public class CheckDilerRateController : ApiController
    {
        private readonly ICurrencyDictionary _dictionary;
        public CheckDilerRateController(ICurrencyDictionary dictionary)
        {
            _dictionary = dictionary;
        }
        [HttpPost]
        public HttpResponseMessage Post(RequestModel item)
        {
            try
            {
                bool isInd = Convert.ToInt32(item.id) == 1 ? true : false;
                var dataIndResp = new DilerIndCurrentRate();
                var dataFactResp = new DilerFactCurrentRate();
                switch (Convert.ToInt32(item.id))
                {
                    case 1:
                        var data = _dictionary.DilerIndRate(item.kv);
                        dataIndResp.kursB = data != null ? data.kursB : null;
                        dataIndResp.kursS = data != null ? data.kursS : null;
                        dataIndResp.vipB = data != null ? data.vipB : null;
                        dataIndResp.vipS = data != null ? data.vipS : null;
                        dataIndResp.blk = data != null ? data.blk : null;
                        break;
                    case 2:
                        var dataF = _dictionary.DilerFactRate(item.kv);
                        dataFactResp.kursB = dataF != null ? dataF.kursB : null;
                        dataFactResp.kursS = dataF != null ? dataF.kursS : null;
                        break;
                }

                HttpResponseMessage response = isInd ? 
                    Request.CreateResponse(HttpStatusCode.OK, dataIndResp) : Request.CreateResponse(HttpStatusCode.OK, dataFactResp);
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Msg = ex.Message });
            }
        }

        public class RequestModel
        {
            public decimal id { get; set; }
            public decimal kv { get; set; }
        }
    }
}