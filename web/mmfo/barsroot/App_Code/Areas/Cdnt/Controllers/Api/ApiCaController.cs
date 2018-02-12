using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Areas.Cdnt.Models;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.Cdnt.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Cdnt.Models;
using BarsWeb.Areas.Cdnt.Models.Transport;

// ReSharper disable once CheckNamespace
namespace BarsWeb.Areas.Cdnt.Controllers
{
    [AuthorizeApi]
    public class ApiCaController : ApiController
    {
        private readonly ICdntRepository _repo;
        private const string DateFormat = "dd.MM.yyyy";

        public ApiCaController(ICdntRepository repo)
        {
            _repo = repo;
        }

        [HttpGet]
        [GET("api/nota/getsingle/{id}")]
        public HttpResponseMessage GetSingleNotary(decimal id)
        {
            var nota = _repo.GetNotary().Where(n => n.ID == id);
            var result = CombineTransportPack(nota);
            if (!result.Any())
            {
                var message = string.Format("Notarius with id = {0} not found", id);
                HttpError err = new HttpError(message);
                return Request.CreateResponse(HttpStatusCode.NotFound, err);
            }
            return Request.CreateResponse(HttpStatusCode.OK, result);
        }
        [HttpGet]
        [GET("api/nota/count")]
        public int GetCount()
        {
            var result = _repo.GetNotaryCount();
            return Convert.ToInt32(result);
        }

        [HttpGet]
        [GET("api/nota/getsome/{from}-{to}")]
        public HttpResponseMessage GetNota(int from, int to)
        {
            if (from < 1 || to < 1 || from > to)
            {
                var message = string.Format("Bad range bounds {0}-{1}", from, to);
                HttpError err = new HttpError(message);
                return Request.CreateResponse(HttpStatusCode.Forbidden, err);
            }
            var page = _repo.GetNotary().OrderBy(n => n.ID).Skip(from - 1).Take(to - from + 1);
            var result = CombineTransportPack(page);
            if (!result.Any())
            {
                var message = string.Format("Notariuses at range {0}-{1} not found", from, to);
                HttpError err = new HttpError(message);
                return Request.CreateResponse(HttpStatusCode.NotFound, err);
            }
            return Request.CreateResponse(HttpStatusCode.OK, result);
        }

        [HttpPost]
        [POST("api/nota/accr_cancel/{id}")]
        public HttpResponseMessage CancelAccreditation(decimal id)
        {
            if (id < 0)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest,
                    String.Format("Invalid accreditation id={0}.", id));
            }
            var accr = _repo.GetAccreditation(id);
            if (accr == null)
            {
                return Request.CreateErrorResponse(HttpStatusCode.NotFound,
                    String.Format("Accreditation with id={0} not found.", id));
            }
            _repo.CancelAccreditation(id);
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        [HttpPost]
        [POST("api/nota/new_query_accreditation")]
        public HttpResponseMessage ReceiveNewAccreditation(AccreditationQuery query)
        {
            if (query == null)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest,
                    String.Format("Nothing to save."));
            }
            _repo.AddAccreditationQuery(query);
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        [HttpPost]
        [POST("api/nota/alter_query_accreditation")]
        public HttpResponseMessage ReceiveOldAccreditation(AccreditationQuery query)
        {
            if (query == null)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest,
                    String.Format("Nothing to save."));
            }
            _repo.AlterAccreditationQuery(query);
            return Request.CreateResponse(HttpStatusCode.OK);
        }
        
        [HttpPost]
        [POST("api/nota/add_profit")]
        public HttpResponseMessage ReceiveNotaryPrifit(V_NOTARY_PROFIT profit)
        {
            if (profit == null)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest,
                    String.Format("Nothing to save."));
            }
            _repo.AddProfit(profit);
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        private List<Notary> CombineTransportPack(IQueryable<NOTARY> notary)
        {
            var notaryList = notary.ToList();
            var result = notaryList.Select(n => new Notary()
            {
                Id = Convert.ToInt32(n.ID),
                NotaryType = n.NOTARY_TYPE,
                Tin = n.TIN,
                FirstName = n.FIRST_NAME,
                LastName = n.LAST_NAME,
                MiddleName = n.MIDDLE_NAME,
                DateOfBirth = n.DATE_OF_BIRTH != null ? n.DATE_OF_BIRTH.Value.ToString(DateFormat) : null,
                PassportSeries = n.PASSPORT_SERIES,
                PassportNumber = n.PASSPORT_NUMBER,
                PassportIssued = n.PASSPORT_ISSUED,
                PassportIssuer = n.PASSPORT_ISSUER,
                Address = n.ADDRESS,
                PhoneNumber = n.PHONE_NUMBER,
                MobilePhoneNumber = n.MOBILE_PHONE_NUMBER,
                Email = n.EMAIL,
                DocumentType = n.DOCUMENT_TYPE,
                IdcardDocumentNumber = n.IDCARD_DOCUMENT_NUMBER,
                IdcardNotationNumber = n.IDCARD_NOTATION_NUMBER,
                PassportExpiry = n.PASSPORT_EXPIRY
            }).ToList();

            foreach (var resItem in result)
            {
                var accrList = _repo.GetNotaryAccreditations(resItem.Id).ToList();
                resItem.Accreditations = accrList.Select(a => new Accreditation()
                {
                    Id = Convert.ToInt32(a.ID),
                    AccreditationTypeId = Convert.ToInt32(a.ACCREDITATION_TYPE_ID),
                    StartDate = a.START_DATE != null ? a.START_DATE.Value.ToString(DateFormat) : null,
                    ExpiryDate = a.EXPIRY_DATE != null ? a.EXPIRY_DATE.Value.ToString(DateFormat) : null,
                    CloseDate = a.CLOSE_DATE != null ? a.CLOSE_DATE.Value.ToString(DateFormat) : null,
                    AccountNumber = a.ACCOUNT_NUMBER,
                    AccountMfo = a.ACCOUNT_MFO,
                    StateId = Convert.ToInt32(a.STATE_ID)
                }).ToList();
            }

            return result;
        }
    }
}