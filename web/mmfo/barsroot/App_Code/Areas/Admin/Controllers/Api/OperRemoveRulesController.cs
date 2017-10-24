using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;


namespace BarsWeb.Areas.Admin.Controllers.Api
{
    public class OperRemoveRulesController : ApiController
    {
        private readonly IOperRepository _repo;
        public OperRemoveRulesController(IOperRepository repo)
        {
            _repo = repo;
        }

        [HttpPost]
        public HttpResponseMessage Post(RemItem item)
        {
            try
            {
                _repo.RemoveProp(item.id, item.tag);
                var result = "Видалення успішно виконано";
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }
    }

    public class RemItem
    {
        public string id { get; set; }
        public string tag { get; set; }
    }
}