using BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Abstract;
using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.IO;
using Bars.Configuration;
using barsroot.core;
using System.Net.Http.Headers;

namespace BarsWeb.Areas.BpkW4.Controllers.Api
{
    public class AutoOfficialNoteApiController : ApiController
    {
        //readonly IActivationReservedAccountsRepository _repo;
        //public AutoOfficialNoteApiController(IActivationReservedAccountsRepository repository) { _repo = repository; }

        [HttpGet]
        public HttpResponseMessage GetOfficialNote(string id_ticket, string reason)
        {
            UserMap user = ConfigurationSettings.GetCurrentUserInfo;

            FrxParameters pars = new FrxParameters();
            pars.Add(new FrxParameter("ticket_id", TypeCode.String, id_ticket));
            pars.Add(new FrxParameter("Inc", TypeCode.Int32, Convert.ToInt32(reason)));
            pars.Add(new FrxParameter("staff_id", TypeCode.Int32, Convert.ToInt32(user.user_id)));

            FrxDoc doc = new FrxDoc(FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID("DKBOEA_DELTICKET_FRX")), pars, null);

            if (doc != null)
                return FileAsAttachment(doc);
            else
                return new HttpResponseMessage(HttpStatusCode.NotFound);
        }

        private HttpResponseMessage FileAsAttachment(FrxDoc doc)
        {
            using (var stream = new MemoryStream())
            {
                doc.ExportToMemoryStream(FrxExportTypes.Pdf, stream);

                var result = new HttpResponseMessage(HttpStatusCode.OK);            
                result.Content = new ByteArrayContent(stream.ToArray());
                result.Content.Headers.ContentType = new MediaTypeHeaderValue("application/pdf"); 
                result.Content.Headers.ContentDisposition = new ContentDispositionHeaderValue("attachment");
                result.Content.Headers.ContentDisposition.FileName = "example.pdf";
                return result;
            }
        }
    }
}

