using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Cdm.Models.Transport;
using BarsWeb.Areas.Cdm.Models.Transport.Legal;
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
    public class CsbSearchLegalController : ApiController
    {
        IEbkFindRepository _findRepo;
        public CsbSearchLegalController(IEbkFindRepository ebkFindRepository)
        {
            _findRepo = ebkFindRepository;
        }

        public HttpResponseMessage Get(string gcif) {
            var param = new ClientSearchParams
            {
                Gcif = gcif
            };

            ErrorMessage errorMessage = new ErrorMessage() { };

            var customers = _findRepo.RequestEbkClient(param, errorMessage);
            if (customers.Any())
            {
                var result = customers.Select(c => c.ClientCard);
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }

            return Request.CreateResponse(HttpStatusCode.NotFound, new { Message = "Клієнта (GCIF:"+gcif+") незнайдено"});
        }

        public HttpResponseMessage Get(
           string customerType,
            decimal? customerRnk,
            string customerCode,
            string fullName,
            string fullNameInternational,
            [ModelBinder(typeof(DateModelBinder))] DateTime? dateOn,
            string gcif)
        {
            var param = new ClientSearchParams
            {
                CustomerType = customerType,
                Rnk = customerRnk,
                Inn = customerCode,
                FullName = fullName,
                FullNameInternational = fullNameInternational,
                DateOn = dateOn,
                Gcif = gcif
            };

            ErrorMessage errorMessage = new ErrorMessage() { };

            var customers = _findRepo.RequestEbkClient(param, errorMessage);

            if (customers == null)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { Message = errorMessage.Message });
            }
            else if (customers.Any())
            {
                var result = new List<LegalPerson>();
                foreach (var item in customers)
                {
                    if (item.ClientLegalCard == null)
                    {
                        throw new Exception("Клієнт знайдений але його картка пуста (ClientLegalCard == null)");
                    }
                    result.Add(item.ClientLegalCard);
                }
                var clients = result.Select(i => new
                {
                    Id = i.Rnk,
                    TypeId = 2,
                    Code = i.Okpo,
                    TypeName = "Юридична  особа",
                    Sed = i.EconomicRegulations == null ? "" : i.EconomicRegulations.K051,
                    Name = i.FullName,
                    DateOpen = i.DateOn,
                    DateClosed = i.DateOff,
                    Branch = i.OffBalanceDepCode,
                    Gcif = i.Gcif
                });

                return Request.CreateResponse(HttpStatusCode.OK, clients);

            }
            return Request.CreateResponse(HttpStatusCode.OK, new List<QualityClientsContainer>());
        }
    }
}