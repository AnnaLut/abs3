using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using AttributeRouting.Web.Http;
using Bars.Classes;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Admin.Models.EditRecords;
using Dapper;
using Oracle.DataAccess.Client;
using Org.BouncyCastle.Asn1;

namespace BarsWeb.Areas.Admin.Controllers.Api
{
    [AuthorizeApi]
    public class EditRecordController : ApiController
    {
        private IRecordsRepository _repository;
        public EditRecordController(IRecordsRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        [GET("api/editrecord/list")]
        public HttpResponseMessage GetList()
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, _repository.GetListId());
            }
            catch (HttpResponseException ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        [GET("api/editrecord/leftgrid")]
        public HttpResponseMessage GetLeftGrid(decimal id)
        {
            try
            {
                return Request.CreateResponse(HttpStatusCode.OK, _repository.GetLeftGrid(id));
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex);
            }
        }

    }
}