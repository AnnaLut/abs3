using System;
using BarsWeb.Areas.Clients.Models;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Enums;
using System.Collections.Generic;
using System.Web.Http;
using System.Net.Http;
using System.Net;
using BarsWeb.Areas.Clients.Infrastructure.Repository;
using BarsWeb.Areas.Clients.Models.Enums;
using AttributeRouting.Web.Http;

namespace BarsWeb.Areas.Clients.Controllers.Api.V1
{
   
    [Authorize]
    public class GeneralClearAddressController : ApiController
    {

        private readonly IGeneralClearAddressRepository _repository;
        private readonly ActionStatus _actionStatus;

        public GeneralClearAddressController(IGeneralClearAddressRepository repository)
        {
            _repository = repository;
            _actionStatus = new ActionStatus(ActionStatusCode.Ok);
        }


        [POST("api/v1/clients/generalclearaddress/save")]
        public HttpResponseMessage Save(GeneralClearAddress generalClearAddress)
        {
            try
            {
                _repository.InstallConformity(generalClearAddress);
                return Request.CreateResponse(HttpStatusCode.OK, _actionStatus);
             }
            catch (Exception ex)
            {
                _actionStatus.Status = ActionStatusCode.Error;
                _actionStatus.Message = ex.Message;
                return Request.CreateResponse(HttpStatusCode.OK, _actionStatus);
            }

        }

        public HttpResponseMessage Delete(GeneralClearAddress generalClearAddress)
        {
            try
            {
                _repository.DeleteConformity(generalClearAddress);
                return Request.CreateResponse(HttpStatusCode.OK, _actionStatus);
            }
            catch (Exception ex)
            {
                _actionStatus.Status = ActionStatusCode.Error;
                _actionStatus.Message = ex.Message;
                return Request.CreateResponse(HttpStatusCode.OK, _actionStatus);
            }

        }

        [POST("api/v1/clients/generalclearaddress/confirmsave")]
        public HttpResponseMessage ConfirmSave([FromBody] GeneralClearAddressType type)
        {
            try
            {
                _repository.ConfirmSave(type);
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