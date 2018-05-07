using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Clients.Infrastructure.Repository;
using BarsWeb.Areas.Clients.Models;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Enums;

namespace BarsWeb.Areas.Clients.Controllers.Api.V1
{
    public class ClearAddressController : ApiController
    {

        private readonly IClearAddressRepository _repository;
        private readonly ActionStatus _actionStatus;

        public ClearAddressController(IClearAddressRepository repository)
        {
            _repository = repository;
            _actionStatus = new ActionStatus(ActionStatusCode.Ok);
        }

        [HttpGet]
        public HttpResponseMessage Get(decimal rnk)
        {
            var clearAddress = _repository.GetClearAddressByRnk(rnk);
            return Request.CreateResponse(HttpStatusCode.OK, clearAddress);
        }

        [HttpPost]
        public HttpResponseMessage Post(List<ClearAddress> clearAddress)
        {
            try
            {
                 _repository.SaveClearAddress(clearAddress);
                return Request.CreateResponse(HttpStatusCode.OK, _actionStatus);
            }
            catch (Exception ex)
            {
                _actionStatus.Status = ActionStatusCode.Error;
                _actionStatus.Message = ex.Message;
                return Request.CreateResponse(HttpStatusCode.OK, _actionStatus);
            }

        }

    }
}