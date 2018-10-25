using BarsWeb.Areas.PRVN.Infrastructure.DI.Abstract;
using System;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using Areas.PRVN.Models;
using System.Text;
using System.Net.Http.Headers;
using System.Collections.Generic;

namespace BarsWeb.Areas.PRVN.Controllers.Api
{
    [AuthorizeApi]
    public class SrrCostController : ApiController
    {
        readonly ISrrCostRepository _repo;

        public SrrCostController(ISrrCostRepository repo)
        {
            _repo = repo;
        }

        [HttpPost]
        public HttpResponseMessage RecieveFile()
        {
            try
            {
                var httpRequest = HttpContext.Current.Request;
                HttpPostedFile httpPostedFile = HttpContext.Current.Request.Files[0];

                List<InsertRowResult> errors = _repo.UploadSrrCostFile(httpPostedFile);

                return Request.CreateResponse(HttpStatusCode.OK, new { hasErrors = errors.Count, errors = errors });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ExeptionProcessing(ex), new MediaTypeHeaderValue("text/json"));
            }
        }

        #region Private methods
        private string ExeptionProcessing(Exception ex)
        {
            string txt = "";
            var ErrorText = ex.Message.ToString();

            byte[] strBytes = Encoding.UTF8.GetBytes(ErrorText);
            ErrorText = Encoding.UTF8.GetString(strBytes);

            var x = ErrorText.IndexOf("ORA");
            var ora = ErrorText.Substring(x + 4, 5); //-20001

            if (x < 0)
                return ErrorText;

            decimal oraErrNumber;
            if (!decimal.TryParse(ora, out oraErrNumber))
                return ErrorText;

            if (oraErrNumber >= 20000)
            {
                var ora1 = ErrorText.Substring(x + 11);
                var y = ora1.IndexOf("ORA");
                if (x > -1 && y > 0)
                {
                    txt = ErrorText.Substring(x + 11, y - 1);
                }
                else
                {
                    txt = ErrorText;
                }

                string tmpResult = txt.Replace('û', '³');
                return tmpResult;
            }
            else
                return ErrorText;
        }
        #endregion
    }
}
