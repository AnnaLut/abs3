using System.Net;
using System.Web.Http;
using System.Web;
using System.IO;

namespace BarsWeb.Areas.WebSMS.Controllers.Api
{
    public class WebSMSController : ApiController
    {
        // GET api/<controller>/5
        public string Get()
        {
            return "Invalid request";
        }

     // POST api/<controller>
        public HttpStatusCode Post()
        {
           string xml = new StreamReader(HttpContext.Current.Request.InputStream).ReadToEnd();
            WebSMS.Models.WebSMS sms = new Models.WebSMS(xml);
            return HttpStatusCode.OK;

        }
    }
}