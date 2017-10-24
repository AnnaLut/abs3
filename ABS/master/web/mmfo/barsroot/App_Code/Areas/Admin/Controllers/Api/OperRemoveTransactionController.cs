using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;

namespace BarsWeb.Areas.Admin.Controllers.Api
{
    public class OperRemoveTransactionController : ApiController
    {
        private readonly IOperRepository _repo;
        public OperRemoveTransactionController(IOperRepository repo)
        {
            _repo = repo;
        }
        [HttpPost]
        public HttpResponseMessage Post(RemTransaction item)
        {
            try
            {
                _repo.DeleteTransaction(item.id, item.ttap);
                return Request.CreateResponse(HttpStatusCode.OK, "Видалення успішно виконано");
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }
    }
    public class RemTransaction
    {
        public string id { get; set; }
        public string ttap { get; set; }
    }
}