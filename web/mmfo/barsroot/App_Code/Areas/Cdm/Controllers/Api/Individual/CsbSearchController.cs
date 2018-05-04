using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Cdm.Models.Transport;
using BarsWeb.Areas.Cdm.Models.Transport.Individual;
using BarsWeb.Core.Models.Binders.Api;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Areas.Cdm.Models.Transport.PrivateEn;
using System.Globalization;

namespace BarsWeb.Areas.Cdm.Controllers.Api
{
    [AuthorizeApi]
    public class CsbSearchController : ApiController
    {
        IEbkFindRepository _findRepo;
        public CsbSearchController(IEbkFindRepository ebkFindRepository)
        {
            _findRepo = ebkFindRepository;
        }

        public HttpResponseMessage Get(string gcif)
        {
            var param = new ClientSearchParams
            {
                Gcif = gcif
            };

            ErrorMessage errorMessage = new ErrorMessage() { };

            var customers = _findRepo.RequestEbkClient(param, errorMessage);
            if (null != customers && customers.Any())
            {
                var result = customers.Select(c => c.ClientCard);
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }

            return Request.CreateResponse(HttpStatusCode.NotFound, new { Message = "Клієнта (GCIF:" + gcif + ") незнайдено" });
        }

        public HttpResponseMessage Get(
            string customerType,
            decimal? customerRnk,
            string customerCode,
            string firstName,
            string lastName,
            string documentSerial,
            string documentNumber,
            string birthDate,
            string gcif,
            string eddrId)
        {
            DateTime? dateBirth = string.IsNullOrEmpty(birthDate) ? (DateTime?)null : DateTime.ParseExact(birthDate, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            var param = new ClientSearchParams
            {
                CustomerType = customerType,
                Rnk = customerRnk,
                Inn = customerCode,
                FirstName = firstName,
                LastName = lastName,
                DocSerial = documentSerial,
                DocNumber = documentNumber,
                BirthDate = dateBirth,
                Gcif = gcif,
                EddrId = eddrId
            };

            ErrorMessage errorMessage = new ErrorMessage() { };

            var customers = _findRepo.RequestEbkClient(param, errorMessage);

            if (customers == null)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Message = errorMessage.Message });
            }
            if (customers.Any())
            {
                if (customerType == "person")
                {
                    var result = new List<BufClientData>();
                    foreach (var item in customers)
                    {
                        if (item.ClientCard == null)
                        {
                            throw new Exception("Клієнт знайдений але його картка пуста (ClientCard == null)");
                        }
                        result.Add(item.ClientCard);
                    }
                    var clients = result.Select(i => new
                    {
                        Id = i.Rnk,
                        TypeId = 3,
                        Code = i.Okpo,
                        TypeName = "Фізична особа",
                        Sed = "",
                        Name = i.Nmk,
                        DateOpen = i.DateOn,
                        DateClosed = i.DateOff,
                        Branch = i.Branch,
                        Gcif = i.Gcif
                    });

                    return Request.CreateResponse(HttpStatusCode.OK, clients);
                }
                else if (customerType == "personspd")
                {
                    var result = new List<PrivateEnPerson>();
                    foreach (var item in customers)
                    {
                        if (item.ClientPrivateEnCard == null)
                        {
                            throw new Exception("Клієнт знайдений але його картка пуста (ClientPrivateEnCard == null)");
                        }
                        result.Add(item.ClientPrivateEnCard);
                    }
                    var clients = result.Select(i => new
                    {
                        Id = i.Rnk,
                        TypeId = 3,
                        Code = i.Okpo,
                        TypeName = "Фізична особа - СПД",
                        Sed = "91",
                        Name = i.fullName,
                        DateOpen = i.DateOn,
                        DateClosed = i.DateOff,
                        Branch = i.Branch,
                        Gcif = i.Gcif
                    });

                    return Request.CreateResponse(HttpStatusCode.OK, clients);
                }

            }

            return Request.CreateResponse(HttpStatusCode.OK, new List<QualityClientsContainer>());
        }
    }
}