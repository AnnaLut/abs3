using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.AdmSecurity.Infrastructure.Repository.DI.Abstract;

namespace BarsWeb.Areas.AdmSecurity.Controllers.Api
{
    [AuthorizeApi]
    public class ConfirmController : ApiController
    {
        private readonly ISecurityConfirmRepository _repo;
        public ConfirmController(ISecurityConfirmRepository repo)
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
}