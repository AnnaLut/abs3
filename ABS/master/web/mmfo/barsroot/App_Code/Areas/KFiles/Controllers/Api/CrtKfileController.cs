using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.IO;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using System.IO.Compression;

namespace BarsWeb.Areas.KFiles.Controllers
{
    [AuthorizeApi]
    public class CrtKfileController : ApiController
    {
        [HttpPost]
        public HttpResponseMessage CrtKfile()
        {

            byte[] kfile = Request.Content.ReadAsByteArrayAsync().Result;

            KeyValuePair<string, string>[] get_params = Request.GetQueryNameValuePairs().ToArray();

            using (MemoryStream compressedStream = new MemoryStream(Convert.FromBase64String(Encoding.UTF8.GetString(kfile))))
            using (GZipStream zipStream = new GZipStream(compressedStream, CompressionMode.Decompress))
            using (MemoryStream resultStream = new MemoryStream())
            {

                zipStream.CopyTo(resultStream);
                kfile = resultStream.ToArray();

            }

            string filename = String.Empty;
            string path = String.Empty;

            foreach (KeyValuePair<string, string> get_param in get_params)
            {

                if (get_param.Key == "filename")
                    filename = get_param.Value;

                if (get_param.Key == "path")
                    path = get_param.Value;
            }

            if (kfile != null && kfile.Length > 0)
            {

                if (!Directory.Exists(path))
                {
                    DirectoryInfo di = Directory.CreateDirectory(path);
                }
                File.WriteAllBytes(path + "\\" + filename, kfile);

            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.OK, "Процедура повернула пусте значення");
            }

            return Request.CreateResponse(HttpStatusCode.OK);
        }
    }
}