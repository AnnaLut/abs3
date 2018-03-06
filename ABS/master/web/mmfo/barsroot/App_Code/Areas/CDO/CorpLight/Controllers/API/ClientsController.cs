using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.Clients.Infrastructure.Repository;
using BarsWeb.Core.Logger;
using System;
using System.Web;
using System.Xml.Serialization;
using System.IO;
using BarsWeb.Areas.CDO.Common.Services;
using BarsWeb.Areas.CDO.CorpLight.Repository;
using BarsWeb.Areas.CDO.CorpLight.Services;

// ReSharper disable once CheckNamespace
namespace BarsWeb.Areas.CDO.CorpLight.Controllers.Api
{
    /// <summary>
    /// Controller for managing Related customers
    /// </summary>
    public class ClientsController : ApiController
    {
        ICustomersRepository _custRepository;
        private ICLRelatedCustomersRepository _relaredCustRepository;
        private ICLRelatedCustomerValidator _relCustValidator;
        private IUserCertificateService _userCertificateService;
        //private readonly IDbLogger _logger;

        public ClientsController(
            ICustomersRepository custRepository,
            ICLRelatedCustomersRepository relaredCustRepository,
            ICLRelatedCustomerValidator relCustValidator,
            IUserCertificateService userCertificateService
            /*,IDbLogger logger*/)
        {
            _relaredCustRepository = relaredCustRepository;
            _relCustValidator = relCustValidator;
            _custRepository = custRepository;
            _userCertificateService = userCertificateService;
            //_logger = logger;
        }

        /// <summary>
        /// Get related customer by id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet]
        [GET("api/corpLight/getClients")]
        public HttpResponseMessage GetClietns(String dateFrom, String dateTo, string banks, string logName)
        {
            try
            {
                var context = HttpContext.Current;
                _relaredCustRepository.LoginUser(logName, context);
                var result = _relaredCustRepository.GetClients(dateFrom, dateTo, banks, logName, context);
                if (result == null)
                {
                    return Request.CreateResponse(HttpStatusCode.OK);
                }

                StringWriter sw = new StringWriter();
                XmlSerializer s = new XmlSerializer(result.GetType());
                s.Serialize(sw, result);
                String xmlList = sw.ToString();
                return Request.CreateResponse(HttpStatusCode.OK, xmlList);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
    }
}
