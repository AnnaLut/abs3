using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Cdm.Models.Transport;
using BarsWeb.Core.Models.Binders.Api;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;

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

        public HttpResponseMessage Get(string gcif) {
            var param = new ClientSearchParams
            {
                Gcif = gcif
            };

            var customers = _findRepo.RequestEbkClient(param);
            if (customers.Any())
            {
                var result = customers.Select(c => c.ClientCard);
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }

            return Request.CreateResponse(HttpStatusCode.NotFound, new { Message = "Клієнта (GCIF:"+gcif+") незнайдено"});
        }

        public HttpResponseMessage Get(
            string customerCode,
            string firstName,
            string lastName,
            string documentSerial,
            string documentNumber,
            [ModelBinder(typeof(DateModelBinder))] DateTime? birthDate,
            string gcif)
        {
            var param = new ClientSearchParams
            {
                Inn = customerCode,
                FirstName = firstName,
                LastName = lastName,
                DocSerial = documentSerial,
                DocNumber= documentNumber,
                BirthDate = birthDate,
                Gcif = gcif
            };

            var customers = _findRepo.RequestEbkClient(param);
            if (customers.Any())
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

            return Request.CreateResponse(HttpStatusCode.OK, new List<QualityClientsContainer>());
        }
    }
}