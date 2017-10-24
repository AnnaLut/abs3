using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Areas.Admin.Models;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;

namespace BarsWeb.Areas.Admin.Controllers.Api
{
    public class CConfirmController : ApiController
    {
        private readonly IConfirmRepository _repo;
        public CConfirmController(IConfirmRepository repo)
        {
            _repo = repo;
        }
        public HttpResponseMessage GetConfirm(string id, string approveList, string rejectList, string comment)
        {
            //var typeId = Decimal.Parse(id);
            try
            {
                if (!String.IsNullOrEmpty(approveList))
                {
                    _repo.ApproveResourceAccess(id, approveList, comment);
                }
                if (!String.IsNullOrEmpty(rejectList))
                {
                    _repo.RejectResourceAccess(id, rejectList, comment);
                }
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK);
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }
    }

    public class ConfirmModel
    {
        public string id { get; set; }
        public string approveList { get; set; }
        public string rejectList { get; set; }
        public string comment { get; set; }
    }
}