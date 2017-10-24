using System;
using System.Net;
using System.Web.Http;
using System.Net.Http;
using System.Collections.Generic;
using BarsWeb.Areas.Admin.Models.Enums;
using BarsWeb.Areas.Admin.Models.AssignmentSpecParams;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;

namespace BarsWeb.Areas.Admin.Controllers.Api
{
    [AuthorizeApi]
    public class AssignmentSpecParamsController : ApiController
    {
        private readonly IAssignmentSpecParamsRepository _repository;
        public AssignmentSpecParamsController(IAssignmentSpecParamsRepository repository)
        {
            _repository = repository;
        }

        [HttpDelete]
        public HttpResponseMessage Delete(List<Parameter> paramsToDelete)
        {
            try
            {
                _repository.EditBalanceAccount(paramsToDelete, Operation.Delete);
                return Request.CreateResponse(HttpStatusCode.OK, new { Message = "Операція прошла успішно." });
                
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, new { Message = exception.Message });
            }
        }

        [HttpPost]
        public HttpResponseMessage Post(List<Parameter> paramsToAdd)
        {
            try
            {
                _repository.EditBalanceAccount(paramsToAdd, Operation.Insert);
                return Request.CreateResponse(HttpStatusCode.OK, new { Message = "Операція прошла успішно." });

            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, new { Message = exception.Message });
            }
        }

        [HttpPut]
        public HttpResponseMessage Put(List<Parameter> paramsToUpdate)
        {
            try
            {
                _repository.EditBalanceAccount(paramsToUpdate, Operation.Update);
                return Request.CreateResponse(HttpStatusCode.OK, new { Message = "Операція прошла успішно." });

            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, new { Message = exception.Message });
            }
        }
    }
}
