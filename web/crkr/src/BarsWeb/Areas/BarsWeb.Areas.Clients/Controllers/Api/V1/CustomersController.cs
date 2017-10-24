using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.Clients.Infrastructure.Repository;
using BarsWeb.Areas.Clients.Models;
using BarsWeb.Areas.Clients.Models.Enums;
using BarsWeb.Areas.Clients.Resources;

using BarsWeb.Core.Models;
using BarsWeb.Core.Extensions;
using BarsWeb.Core.Models.Binders.Api;
using System;
using BarsWeb.Core.Models.Enums;

namespace BarsWeb.Areas.Clients.Controllers.Api.V1
{
    [Authorize]
    public class CustomersController : ApiController
    {
        private readonly ICustomersRepository _repository;
        public CustomersController(ICustomersRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        //[ODataQueryable(AllowedQueryOptions = AllowedQueryOptions.All)]
        public DataSourceResult Get(
            [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request,
            CustomerType type = CustomerType.All,
            bool showClosed = false,
            string likeClause = null,
            int? systemFilterId = null,
            int? userFilterId = null,
            string whereClause = null)
        {
            var customers = _repository.GetAllByType(type);
            if (!showClosed)
            {
                customers = customers.Where(i => i.DateClosed == null);
            }
            if (!string.IsNullOrEmpty(likeClause))
            {
                //customers = customers.Where(i => i.SearchColumn.Contains(likeClause));
            }
            return customers.ToDataSource(request);
        }

        [HttpGet]
        [GET("api/v1/clients/customers/search")]
        public HttpResponseMessage Search(
            string customerCode,
            string firstName,
            string lastName,
            string documentSerial,
            string documentNumber,
            [ModelBinder(typeof(DateModelBinder))] DateTime? birthDate,
            string gcif)
        {

            if (string.IsNullOrEmpty(customerCode)
                    && string.IsNullOrEmpty(firstName)
                    && string.IsNullOrEmpty(lastName)
                    && string.IsNullOrEmpty(documentSerial)
                    && string.IsNullOrEmpty(documentNumber)
                    && string.IsNullOrEmpty(gcif)
                    && birthDate == null)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, new { Message = ClientsResource.AllSearchParametersIsNull});
            }

            SearchParams parameters = new SearchParams
            {
                CustomerCode= customerCode,
                FirstName = firstName,
                LastName = lastName,
                DocumentSerial = documentSerial,
                DocumentNumber = documentNumber,
                BirthDate = birthDate,
                Gcif = gcif
            };
            var customers = _repository.Search(parameters);

            return Request.CreateResponse(HttpStatusCode.OK, customers);
        }

        [HttpGet]
        public HttpResponseMessage Get(int id)
        {
            var dbCuctomer = _repository.Get(id);
            if (dbCuctomer == null)
            {
                return CustomerNotFound();
            }
            return Request.CreateResponse(HttpStatusCode.OK, dbCuctomer);
        }
        [HttpPost]
        [POST("api/v1/clients/customers/restore")]
        [POST("api/clients/customers/restore")]
        public HttpResponseMessage Post(int id)
        {
            var dbCuctomer = _repository.Get(id);
            if (dbCuctomer == null)
            {
                return CustomerNotFound();
            }
            var status = _repository.RestoreCustomer(id);
            if (status.Status != ActionStatusCode.Ok)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, new { status.Message });
            }
            return Request.CreateResponse(HttpStatusCode.OK);
        }
        public HttpResponseMessage Post(Customer customer)
        {
            return Request.CreateResponse(HttpStatusCode.OK);
        }
        public HttpResponseMessage Put(int id, Customer customer)
        {
            var dbCuctomer = _repository.Get(id);
            if (dbCuctomer == null)
            {
                return CustomerNotFound();
            }
            customer = _repository.Update(customer);
            return Request.CreateResponse(HttpStatusCode.OK,customer);
        }

        public HttpResponseMessage Delete(int id)
        {
            var dbCuctomer = _repository.GetAll().Count(i => i.Id == id);
            if (dbCuctomer == 0)
            {
                return CustomerNotFound();
            }
            var status = _repository.Delete(id);
            if (status.Status != ActionStatusCode.Ok)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, new {status.Message});
            }
            return Request.CreateResponse(HttpStatusCode.OK);

        }

        private HttpResponseMessage CustomerNotFound()
        {
            return Request.CreateResponse(
                    HttpStatusCode.BadRequest, new { Message = ClientsResource.ClientNotFound });
        }
    }
}