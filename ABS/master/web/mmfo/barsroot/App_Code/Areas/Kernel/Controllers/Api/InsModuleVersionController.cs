using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;

namespace BarsWeb.Areas.Kernel.Controllers.Api
{
    public class InsModuleVersionController : ApiController
    {
        private readonly IUpdateHistoryRepository _updHistoryRepo;
        public InsModuleVersionController(IUpdateHistoryRepository updHistoryRepo)
        {
            _updHistoryRepo = updHistoryRepo;
        }

        public HttpResponseMessage Post(BarsUpdateInfo updInfo)
        {
            try
            {
                _updHistoryRepo.InsertModuleVersion(updInfo);
            }
            catch (Exception)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest);
            }
            return Request.CreateResponse(HttpStatusCode.OK);
        }
    }
}