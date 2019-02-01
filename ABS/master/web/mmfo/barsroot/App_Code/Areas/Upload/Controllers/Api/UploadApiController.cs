using BarsWeb.Areas.Upload.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Upload.Infrastructure.DI.Implementation;
using System;
using System.Drawing;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;

namespace BarsWeb.Areas.Upload.Controllers.Api
{
    public class UploadApiController : ApiController
    {
        readonly IUploadRepository _repo;
        public UploadApiController(IUploadRepository repo) { _repo = repo; }
        #region Photo
        const string imageSessionKey = "BYTES_IMAGE_DATA_KEY_{0}";
        const int imgW = 480;
        const int imgH = 640;
        const int imgSize = 150 * 1000;   // bytes

        [HttpPost]
        public HttpResponseMessage PhotoUpload()
        {
            HttpRequest r = HttpContext.Current.Request;
            string rnk = r.Form.Get("rnk");

            var file = r.Files.Count > 0 ? r.Files[0] : null;
            if (file != null && file.ContentLength > 0)
            {
                byte[] bytes = new byte[file.InputStream.Length];
                long data = file.InputStream.Read(bytes, 0, (int)file.InputStream.Length);
                file.InputStream.Close();

                if (bytes.Length > imgSize)
                {
                    return Request.CreateResponse(HttpStatusCode.InternalServerError,
                        string.Format("Розмір має бути меньшим {0} кб", imgSize / 1000));
                }

                Bitmap newBitmap;
                using (MemoryStream memoryStream = new MemoryStream(bytes))
                using (Image newImage = Image.FromStream(memoryStream))
                    newBitmap = new Bitmap(newImage);

                if (newBitmap != null)
                {
                    if (newBitmap.Width > imgW || newBitmap.Height > imgH)
                    {
                        return Request.CreateResponse(HttpStatusCode.InternalServerError,
                            string.Format("Розмір має бути {0}x{1} пікселів", imgW, imgH));
                    }
                    else
                    {
                        HttpContext.Current.Session[string.Format(imageSessionKey, rnk)] = bytes;
                        return new HttpResponseMessage() { StatusCode = HttpStatusCode.OK };
                    }
                }
            }
            return Request.CreateResponse(HttpStatusCode.InternalServerError, "Невірний формат");
        }

        [HttpPost]
        public HttpResponseMessage PhotoSave(PhotoData obj)
        {
            try
            {
                bool isSaved = false;
                byte[] bytes = (byte[])HttpContext.Current.Session[string.Format(imageSessionKey, obj.rnk)];
                if (bytes.Length > 0)
                {
                    isSaved = true;
                    SaveImage(obj.imgType, bytes, obj.rnk);
                    HttpContext.Current.Session.Remove(string.Format(imageSessionKey, obj.rnk));
                }
                return Request.CreateResponse(HttpStatusCode.OK, new { isSaved = isSaved });
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpPost]
        public void CheckMesssage()
        {
            //пустий метод для виклику з js , щоб не падала сесія
        }

        [HttpPost]
        public HttpResponseMessage ScanUpload()
        {
            HttpRequest r = HttpContext.Current.Request;
            string SessionID = r.Form.Get("SessionID");

            var file = r.Files.Count > 0 ? r.Files[0] : null;
            if (file != null && file.ContentLength > 0)
            {
                byte[] bytes = new byte[file.InputStream.Length];
                long data = file.InputStream.Read(bytes, 0, (int)file.InputStream.Length);
                file.InputStream.Close();

                string path = Path.Combine(Path.GetTempPath(), SessionID);
                File.WriteAllBytes(path, bytes);
            }
            return new HttpResponseMessage() { StatusCode = HttpStatusCode.OK };
        }

        void SaveImage(string imgType, byte[] imgData, string rnk)
        {
            decimal clientRnk = decimal.Parse(rnk);

            var sql = SqlCreator.SaveImage(imgType, imgData, clientRnk);
            _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
        }
        #endregion
    }
}
