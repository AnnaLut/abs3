using BarsWeb.Areas.ExternalServices.Services;
using Ionic.Zip;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Web;
using System.Web.Http;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.ExternalServices.Controllers
{
    [AuthorizeApi]
    public class ExternalServicesController : ApiController
    {
        private readonly IExternalServices externalServices;
        public ExternalServicesController(IExternalServices externalServices)
        {
            this.externalServices = externalServices;
        }
        #region CorpLight
        public HttpResponseMessage GetCorpLightFilesInfo(decimal? bidId)
        {
            if (!bidId.HasValue) return Request.CreateResponse(HttpStatusCode.OK, new { error = "Відсутній ідентифікатор заявки." });
            try
            {
                var files = externalServices.CorpLightServices.FileLoaderService.GetSupportDocuments(bidId.Value);
                //var files = new List<CorpLight.Users.Models.SupportDocument>();
                //files.Add(new CorpLight.Users.Models.SupportDocument { Id = "111", FileName = "asdfgghjkj", Comment = "aaaaaaaaaa" });
                //files.Add(new CorpLight.Users.Models.SupportDocument { Id = "222", FileName = "zxcvbn", Comment = "bbbbbbb" });
                if (files.Count() == 0) return Request.CreateResponse(HttpStatusCode.OK, new { nodata = true });

                return Request.CreateResponse(HttpStatusCode.OK, files);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { error = ex.Message + Environment.NewLine + ex.StackTrace });
            }
        }
        public HttpResponseMessage GetCorpLightFile(string fileId)
        {
            if (string.IsNullOrEmpty(fileId)) throw new Exception("Відсутній ідентифікатор файла.");

            try
            {
                var zipEntries = new List<ZipEntry>();
                var file = externalServices.CorpLightServices.FileLoaderService.GetSupportDocumentFile(fileId);
                if (file != null && file.FileBody != null && file.FileBody.Length != 0)
                {
                    zipEntries.Add(new ZipEntry { Name = string.Format("{0}.{1}", file.FileName, file.FileExtension), Content = file.FileBody });

                    try
                    {
                        var signaturefile = externalServices.CorpLightServices.FileLoaderService.GetSupDocumentSignature(fileId);
                        if (signaturefile != null && signaturefile.Body != null && signaturefile.Body.Length != 0)
                            zipEntries.Add(new ZipEntry { Name = string.Format("{0}.{1}", signaturefile.SupDocName, signaturefile.Extension), Content = signaturefile.Body });
                    }
                    catch (Exception)
                    {
                    }

                    var zipName = string.Format("{0}", file.FileName ?? "file");

                    var response = CreateZipResponse(zipName, zipEntries);

                    return response;
                }
                else
                {
                    throw new Exception(string.Format("Не вдалося отримати файл (Id: {0}) з КорпЛайт або файл відсутній.", fileId));
                    //return Request.CreateResponse(HttpStatusCode.InternalServerError, 
                    //    string.Format("Не вдалося отримати файл (Id: {0}) з КорпЛайт або файл відсутній.", fileId.Value));
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message + Environment.NewLine + ex.StackTrace);
                //return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
        //public HttpResponseMessage GetCorpLightDocumentSignature(string fileId)
        //{
        //    if (string.IsNullOrEmpty(fileId)) throw new Exception("Відсутній ідентифікатор файла.");

        //    try
        //    {
        //        var file = externalServices.CorpLightServices.FileLoaderService.GetSupDocumentSignature(fileId);
        //        if (file != null && file.Body != null && file.Body.Length != 0)
        //        {
        //            var result = new HttpResponseMessage(HttpStatusCode.OK)
        //            {
        //                Content = new ByteArrayContent(file.Body)
        //            };
        //            result.Content.Headers.ContentDisposition = new ContentDispositionHeaderValue("attachment")
        //            {
        //                FileNameStar = string.Format("{0}.{1}", file.SupDocName ?? "file", file.Extension)
        //            };
        //            result.Content.Headers.ContentType = new MediaTypeHeaderValue("application/octet-stream");

        //            return result;
        //        }
        //        else
        //        {
        //            throw new Exception(string.Format("Не вдалося отримати файл підпису для файлу (Id: {0}) з КорпЛайт або файл відсутній.", fileId));
        //            //return Request.CreateResponse(HttpStatusCode.InternalServerError, 
        //            //    string.Format("Не вдалося отримати файл (Id: {0}) з КорпЛайт або файл відсутній.", fileId.Value));
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new Exception(ex.Message + Environment.NewLine + ex.StackTrace);
        //        //return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
        //    }
        //}
        public HttpResponseMessage GetCorpLightAllFiles(/*[ModelBinder]string[] fileIds,*/ decimal? bidId)
        {
            if (!bidId.HasValue) return Request.CreateResponse(HttpStatusCode.OK, new { error = "Відсутній ідентифікатор заявки." });
            string[] fileIds = externalServices.CorpLightServices.FileLoaderService.GetSupportDocuments(bidId.Value).Select(item => item.Id).ToArray();
            if (fileIds.Length == 0) throw new Exception("Відсутні ідентифікатори файлів.");
            try
            {
                var files = new List<CorpLight.Users.Models.SupportDocumentFile>();
                var signaturefiles = new List<CorpLight.Users.Models.SupDocumentSignature>();
                for (int i = 0; i < fileIds.Length; i++)
                {
                    if (!string.IsNullOrEmpty(fileIds[i]))
                    {
                        var file = externalServices.CorpLightServices.FileLoaderService.GetSupportDocumentFile(fileIds[i]);
                        if (file != null && file.FileBody != null && file.FileBody.Length != 0)
                            files.Add(file);

                        try
                        {
                            var signaturefile = externalServices.CorpLightServices.FileLoaderService.GetSupDocumentSignature(fileIds[i]);
                            if (signaturefile != null && signaturefile.Body != null && signaturefile.Body.Length != 0)
                                signaturefiles.Add(signaturefile);
                        }
                        catch (Exception)
                        {
                        }
                    }
                }

                if (files.Count == 0)
                {
                    throw new Exception("Не вдалося отримати файли з КорпЛайт або файли відсутні.");
                }

                var zipEntries = files.Select(f => new ZipEntry { Name = string.Format("{0}.{1}", f.FileName, f.FileExtension), Content = f.FileBody }).
                    Concat(signaturefiles.Select(s => new ZipEntry { Name = string.Format("{0}.{1}", s.SupDocName, s.Extension), Content = s.Body }));

                var zipName = string.Format("Attachments_{0}_{1}", bidId, DateTime.Now.ToShortDateString());

                var response = CreateZipResponse(zipName, zipEntries);

                return response;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message + Environment.NewLine + ex.StackTrace);
                //return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }
        public HttpResponseMessage GetCorpLightFileInfo(long? fileId)
        {
            if (fileId == null) return Request.CreateResponse(HttpStatusCode.OK, new { error = "Відсутній ідентифікатор файла." });

            try
            {
                Zay.Models.GetFileFromClModel requestModel = externalServices.CorpLightServices.InternalDbHelper.CurrencyRepo.GetModelFileForCl(fileId.Value);
                if (requestModel == null)
                    return Request.CreateResponse(HttpStatusCode.OK, new { error = string.Format("інформації по файлу (Id: {0}) з немає.", fileId) });
                if (string.IsNullOrEmpty(requestModel.FNAMEKB) || requestModel.FNAMEKB.ToUpper() != "CL")
                   return Request.CreateResponse(HttpStatusCode.OK, new { error = "Оберіть зявку по Клієнт-Банку(СДО - CL) " });

                double a = 0.5;
                var zipEntries = new List<ZipEntry>();
                string custAdr = "04070, Україна, Замасковано RNK=97407801";
                string cusFullName = "Клієнт RNK=97407801";
                string bankName = string.Empty;
                string bankAdress = "01001, Київ, Госпітальна, 12-Г";
                string custPhone = string.Empty;
                byte[] file = externalServices.CorpLightServices.FileLoaderServiceByApi.GetApplicationFile(requestModel.ID, requestModel.ADR, 
                                          requestModel.NMK, requestModel.BANK_NAME, requestModel.ADDRESS_BANK,requestModel.PHONE, requestModel.KOM);

                if (file != null && file.Length != 0)
                {
                    return Request.CreateResponse(HttpStatusCode.OK, new { fileId = fileId });
                   
                }
                else
                {
                    //throw new Exception(string.Format("Не вдалося отримати файл (Id: {0}) з КорпЛайт або файл відсутній.", "test"));
                    return Request.CreateResponse(HttpStatusCode.OK, new { error = string.Format("Не вдалося отримати файл(Id: { 0}) з КорпЛайт або файл відсутній.", fileId) });

                }
            }
            catch (Exception ex)
            {
                //throw new Exception(ex.Message + Environment.NewLine + ex.StackTrace);
                return Request.CreateResponse(HttpStatusCode.OK, new { error = ex.Message + Environment.NewLine + ex.StackTrace }); 
            }
        }
        [HttpGet]
        public HttpResponseMessage DownLoadCorpLightFile(long? fileId)
        {
            if (fileId == null) throw new Exception("Відсутній ідентифікатор файла.");

            try
            {
                var zipEntries = new List<ZipEntry>();
                Zay.Models.GetFileFromClModel requestModel = externalServices.CorpLightServices.InternalDbHelper.CurrencyRepo.GetModelFileForCl(fileId.Value);
                byte[] file = externalServices.CorpLightServices.FileLoaderServiceByApi.GetApplicationFile(requestModel.ID, requestModel.ADR,
                    requestModel.NMK, requestModel.BANK_NAME, requestModel.ADDRESS_BANK, requestModel.PHONE, requestModel.KOM);
                if (file != null && file.Length != 0)                     
                {
                    zipEntries.Add(new ZipEntry { Name = string.Format("{0}.{1}", "Заявка" + fileId.ToString(), "pdf"), Content = file});

                    try
                    {
                        var signaturefile = externalServices.CorpLightServices.FileLoaderService.GetSupDocumentSignature(fileId.Value.ToString());
                        if (signaturefile != null && signaturefile.Body != null && signaturefile.Body.Length != 0)
                            zipEntries.Add(new ZipEntry { Name = string.Format("{0}.{1}", signaturefile.SupDocName, signaturefile.Extension), Content = signaturefile.Body });
                    }
                    catch (Exception)
                    {
                    }

                    // var zipName = string.Format("{0}", fileId.Value.ToString() + "Arc" ?? "file");

                    //var response = CreateZipResponse(zipName, zipEntries);
                    var result = new HttpResponseMessage(HttpStatusCode.OK);
                    
                        result.Content = new ByteArrayContent(file);
                    result.Content.Headers.ContentDisposition = new ContentDispositionHeaderValue("attachment")
                    {
                        FileNameStar = string.Format("{0}.{1}", "Заявка_" + fileId.ToString(), ".doc")
                    };
                    result.Content.Headers.ContentType = new MediaTypeHeaderValue("application/msword");
                    return result;
                 
                }
                else
                {
                    throw new Exception(string.Format("Не вдалося отримати файл (Id: {0}) з КорпЛайт або файл відсутній.", fileId));
                    //return Request.CreateResponse(HttpStatusCode.InternalServerError, 
                    //    string.Format("Не вдалося отримати файл (Id: {0}) з КорпЛайт або файл відсутній.", fileId.Value));
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message + Environment.NewLine + ex.StackTrace);
                //return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        private HttpResponseMessage CreateZipResponse(string zipName, IEnumerable<ZipEntry> files)
        {
            ZipFile zip = new ZipFile();
            zip.AlternateEncoding = Encoding.UTF8;
            zip.AlternateEncodingUsage = ZipOption.AsNecessary;
            foreach (var file in files)
            {
                zip.AddEntry(file.Name, file.Content);
            }
            var stream = new MemoryStream();
            zip.Save(stream);
            stream.Seek(0, SeekOrigin.Begin);

            var result = new HttpResponseMessage(HttpStatusCode.OK)
            {
                Content = new StreamContent(stream)
            };
            result.Content.Headers.ContentDisposition = new ContentDispositionHeaderValue("attachment")
            {
                FileNameStar = string.Format("{0}.zip", zipName)
            };
            result.Content.Headers.ContentType = new MediaTypeHeaderValue("application/zip");
            return result;
        }

        class ZipEntry
        {
            public string Name { get; set; }
            public byte[] Content { get; set; }
        }
        #endregion
        #region Corp2
        #endregion
    }
}