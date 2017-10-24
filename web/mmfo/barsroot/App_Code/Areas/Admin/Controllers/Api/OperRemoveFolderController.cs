using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;

namespace BarsWeb.Areas.Admin.Controllers.Api
{
    public class OperRemoveFolderController : ApiController
    {
        private readonly IOperRepository _repo;
        public OperRemoveFolderController(IOperRepository repo)
        {
            _repo = repo;
        }

        [HttpPost]
        public HttpResponseMessage Post(DelFolder item)
        {
            try
            {
                _repo.DeleteFolder(item.id, item.idfo);
                return Request.CreateResponse(HttpStatusCode.OK, "Видалення успішно виконано");
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }
    }

    public class DelFolder
    {
        public string id { get; set; }
        public decimal idfo { get; set; }
    }
}