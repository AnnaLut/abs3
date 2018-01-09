using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;

namespace BarsWeb.Areas.Kernel.Controllers.Api
{
    /// <summary>
    /// Banck adtes API
    /// </summary>
    [AuthorizeApi]
    public class BankDatesController : ApiController
    {
        private readonly IBankDatesRepository _repository;

        public BankDatesController(IBankDatesRepository repository)
        {
            _repository = repository;
        }
        /// <summary>
        /// Get list bank dates
        /// </summary>
        /// <param name="year">Filter by year</param>
        /// <returns></returns>
        public HttpResponseMessage GetAll(int year)
        {
            var bankDates = _repository.GetAllBankDates(year, null);
            return Request.CreateResponse(HttpStatusCode.OK, bankDates);
        }
        /// <summary>
        /// Get list bank dates
        /// </summary>
        /// <param name="year">Filter by year</param>
        /// <param name="month">Filter by month (nullable)</param>
        /// <returns></returns>
        public HttpResponseMessage GetAll(int year, int month)
        {
            var bankDates = _repository.GetAllBankDates(year, month);
            return Request.CreateResponse(HttpStatusCode.OK, bankDates);
        }
        /// <summary>
        /// Get current bank date
        /// </summary>
        /// <returns></returns>
        public HttpResponseMessage Get()
        {
            var date = _repository.GetBankDate();
            return Request.CreateResponse(HttpStatusCode.OK, new { Date = date});
        }
    }
}