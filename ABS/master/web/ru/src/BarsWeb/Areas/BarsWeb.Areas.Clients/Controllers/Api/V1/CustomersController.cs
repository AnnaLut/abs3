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
using System.Globalization;
using System.Collections.Generic;

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
        [GET("api/v1/clients/customers/getcustomers")]
        public HttpResponseMessage GetCustomers([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, 
            CustomerType type = CustomerType.All,
            bool showClosed = false,
            string likeClause = null,
            int? systemFilterId = null,
            int? userFilterId = null,
            string whereClause = null)
        {
            try
            {
                List<Customer> data = _repository.GetCustomers(request, type, showClosed);
                data.ForEach((c) => c.PHOTO_WEB = _repository.GetCustomerImage(c.Id, "PHOTO_WEB"));

                return Request.CreateResponse(HttpStatusCode.OK, new {
                    Data = data,
                    Total = (request.Page * request.PageSize) + 1
                });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        [GET("api/v1/clients/customers/search")]
        public HttpResponseMessage Search(
            string customerRnk,
            string customerCode,
            string firstName,
            string lastName,
            string documentSerial,
            string documentNumber,
            string birthDate,
            string dateOn,
            string gcif,
            string fullName,
            string fullNameInternational,
            string eddrId,
            CustomerType customerType = CustomerType.All)
        {

            if (string.IsNullOrEmpty(customerCode)
                    && string.IsNullOrEmpty(firstName)
                    && string.IsNullOrEmpty(lastName)
                    && string.IsNullOrEmpty(documentSerial)
                    && string.IsNullOrEmpty(documentNumber)
                    && string.IsNullOrEmpty(gcif)
                    && string.IsNullOrEmpty(birthDate)
                    && string.IsNullOrEmpty(fullName)
                    && string.IsNullOrEmpty(fullNameInternational)
                    && string.IsNullOrEmpty(dateOn))
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, new { Message = ClientsResource.AllSearchParametersIsNull });
            }

            DateTime? dateBirth = string.IsNullOrEmpty(birthDate) ? (DateTime?)null : DateTime.ParseExact(birthDate, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            DateTime? dateRegistation = string.IsNullOrEmpty(dateOn) ? (DateTime?)null : DateTime.ParseExact(dateOn, "yyyy-MM-dd", CultureInfo.InvariantCulture);

            SearchParams parameters = new SearchParams
            {
                CustomerType = customerType,
                CustomerCode = customerCode,
                FirstName = firstName,
                LastName = lastName,
                DocumentSerial = documentSerial,
                DocumentNumber = documentNumber,
                BirthDate = dateBirth,
                Gcif = gcif,
                FullName = fullName,
                DateOn = dateRegistation,
                FullNameInternational = fullNameInternational
            };
            var customers = _repository.Search(parameters);

            if (customerType == CustomerType.PersonSpd)
            {
                customers = customers.Where(i => i.Sed.Contains("91") && (i.VED != "00000" || i.VED == null) && (i.ISE == "14200" || i.ISE == "14100" || i.ISE == "14201" || i.ISE == "14101")).ToList();
            }
            else if (customerType == CustomerType.Person)
            {
                customers = customers.Where(i => i.Sed.Contains("00") && (i.ISE != "14200" || i.ISE != "14100" || i.ISE != "14201" || i.ISE != "14101")).ToList();
            }
            else if (customerType == CustomerType.Corp)
            {
                customers = customers.Where(i => i.TypeId == 2).ToList();
            }

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
        public HttpResponseMessage Restore(int id)
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
            return Request.CreateResponse(HttpStatusCode.OK, customer);
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
                return Request.CreateResponse(HttpStatusCode.BadRequest, new { status.Message });
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