using BarsWeb.Areas.ValuePapers.Infrastructure.DI.Abstract;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Script.Serialization;

namespace BarsWeb.Areas.ValuePapers.Controllers.Api
{
    public class CPToAnotherBagApiController : ApiController
    {
        private readonly ICPToAnotherBagRepository _repository;

        public CPToAnotherBagApiController(ICPToAnotherBagRepository repository)
        {
            _repository = repository;
        }
        [HttpGet]
        public HttpResponseMessage GetInputs(decimal id)
        {
            var data = _repository.GetInputs(id);
            return Request.CreateResponse(HttpStatusCode.OK, data);
        }
        [HttpGet]
        public HttpResponseMessage GetInputs(decimal id, decimal ryn, decimal emi, decimal pf, decimal vidd, decimal kv)
        {
            var data = _repository.GetInputs(id, ryn, emi, pf, vidd, kv);
            return Request.CreateResponse(HttpStatusCode.OK, data);
        }
        [HttpGet]
        public HttpResponseMessage GetFirstComboBox(decimal id)
        {
            var data = _repository.GetFirstComboBox(id);
            return Request.CreateResponse(HttpStatusCode.OK, data);
        }
        [HttpGet]
        public HttpResponseMessage GetSecondComboBox(decimal id, decimal vidd)
        {
            var data = _repository.GetSecondComboBox(id, vidd);
            return Request.CreateResponse(HttpStatusCode.OK, data);
        }
        [HttpGet]
        public HttpResponseMessage GetThirdComboBox(decimal emi, decimal dox, decimal pf)
        {
            var data = _repository.GetThirdComboBox(emi, dox, pf);
            return Request.CreateResponse(HttpStatusCode.OK, data);
        }
        [HttpGet]
        public HttpResponseMessage GetFourthComboBox(decimal emi, decimal dox, decimal vidd)
        {
            var data = _repository.GetFourthComboBox(emi, dox, vidd);
            return Request.CreateResponse(HttpStatusCode.OK, data);
        }
        [HttpGet]
        public HttpResponseMessage GetNlsa(decimal ryn, decimal emi, decimal pf, decimal vidd)
        {
            var data = _repository.GetNlsa(ryn, emi, pf, vidd);
            return Request.CreateResponse(HttpStatusCode.OK, data);
        }
        [HttpGet]
        public HttpResponseMessage MakeMDTable(decimal id, decimal pf, decimal ryn)
        {
            _repository.MakeMDTable(id, pf, ryn);
            return Request.CreateResponse(HttpStatusCode.OK);
        }
        [HttpGet]
        public HttpResponseMessage InsertValuePaper(string valuepaper)
        {
            InsertValuePaperData paper_data = new JavaScriptSerializer().Deserialize<InsertValuePaperData>(valuepaper);
            return Request.CreateResponse(HttpStatusCode.OK, 
                _repository.InsertValuePaper(paper_data.id, paper_data.pf_1, paper_data.ryn_1, paper_data.pf_2, 
                paper_data.ryn_2, paper_data.sum, paper_data._ref, paper_data.nazn, paper_data.kor)
                );
        }

        [HttpGet]
        public HttpResponseMessage UpdateTicketNumber(int REF_MAIN, string ticket_number)
        {
            _repository.UpdateTicketNumber(REF_MAIN, ticket_number);
            return Request.CreateResponse(HttpStatusCode.OK);
        }
    }
}
