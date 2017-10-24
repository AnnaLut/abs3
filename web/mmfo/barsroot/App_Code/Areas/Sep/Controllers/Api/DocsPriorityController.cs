using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Zay.Models;

namespace BarsWeb.Areas.Sep.Controllers.Api
{
    [AuthorizeApi]
    public class DocsPriorityController : ApiController
    {
        private readonly ISepLockDocsRepository _repo;
        public DocsPriorityController(ISepLockDocsRepository repo)
        {
            _repo = repo;
        }

        /*[HttpPost]
        public HttpResponseMessage Post(UpdatePrty item)
        {
            try
            {
                _repo.UpdateDocPrty(item.rec, item.blk, item.prty);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Status = "Ok", Message = "Зміни збережено" });
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.OK,
                    new { Status = "Nok", Message = exception.Message });
            }
        }*/

        [HttpPost]
        public HttpResponseMessage Post(List<UpdatePrty> items)
        {
            IList<VisaResponse> vResponseList = new List<VisaResponse>();
            foreach (var item in items)
            {
                try
                {
                    _repo.UpdateDocPrty(item.rec, item.blk, item.prty);
                    vResponseList.Add(new VisaResponse() { Id = item.rec, Msg = "Зміни збережено", Status = 1 });
                }
                catch (Exception ex)
                {
                    vResponseList.Add(new VisaResponse() { Id = item.rec, Msg = ex.Message, Status = 0 });
                }
            }
            HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                vResponseList);
            return response;
        }
    }

    public class UpdatePrty
    {
        public decimal rec { get; set; }
        public decimal blk { get; set; }
        public decimal prty { get; set; }
    }
}