using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BarsWeb.Areas.Way.Infrastructure.DI.Abstract;
using System.IO;
using System.Linq;
using System.Collections.Generic;
using BarsWeb.Areas.Way.Models;
using System.Text;
using Ionic.Zip;
using Ninject;
using BarsWeb.Core.Logger;

namespace BarsWeb.Areas.Way.Controllers.Api
{
    [AuthorizeApi]
    public class FileController : ApiController
    {
        [Inject]
        public IDbLogger Logger { get; set; }
        readonly string LoggerPrefix;

        private readonly IWayRepository _repository;
        public FileController(IWayRepository repository)
        {
            LoggerPrefix = GetType().ToString();
            _repository = repository;            
        }
        [HttpGet]
        public HttpResponseMessage GetFileList()
        {
            var path = _repository.GetGlobalOption("OWINDIR");

            return Request.CreateResponse(HttpStatusCode.OK, new
            {
                Data = Directory.GetFiles(path).Select(file => new
                {
                    fileName = Path.GetFileName(file)
                }),
                Message = "Ok"
            });
        }

        [HttpPost]
        public HttpResponseMessage UploadFiles(IEnumerable<string> fileNames)
        {
            byte[] fileData;
            var result = new UpdateStatusDb();
            var inPath = _repository.GetGlobalOption("OWINDIR");
            var arcPath = Path.Combine(_repository.GetGlobalOption("OWARCDIR"), DateTime.Now.ToString("dd.MM.yyyy"));
            StringBuilder resultMessage = new StringBuilder();
            foreach (var fileName in fileNames)
            {
                string in_ = Path.Combine(inPath, fileName);
                using (var file = File.OpenRead(in_))
                {
                    using (var binaryReader = new BinaryReader(file))
                    {
                        Logger.Info(string.Format("Read file: {0}", fileName), LoggerPrefix);
                        fileData = binaryReader.ReadBytes((int)file.Length);                        
                    }
                }
                try
                {
                    FileInfo fi = new FileInfo(in_);
                    string ext = fi.Extension;                  
                    //if (ext == ".zip")  // need extract
                    //{
                    //    using (ZipFile zip1 = ZipFile.Read(in_))
                    //    {
                    //        foreach (ZipEntry e in zip1)
                    //        {
                    //            using (MemoryStream data = new MemoryStream())
                    //            {
                    //                e.Extract(data);
                    //                fileData = data.ToArray();
                    //            }
                    //            Logger.Info(string.Format("Start import ZIP file: {0} unZipFile: {1}", fileName, e.FileName), LoggerPrefix);
                    //            result = ImportFile(fileName, fileData, inPath, arcPath, e.FileName);
                    //        }
                    //    }
                    //}
                    //else
                    //{
                    //    Logger.Info(string.Format("Start import file: {0}", fileName), LoggerPrefix);
                    //    result = ImportFile(fileName, fileData, inPath, arcPath, null);
                    //}
                    Logger.Info(string.Format("Start import file: {0}", fileName), LoggerPrefix);
                    result = ImportFile(fileName, fileData, inPath, arcPath, ext.ToUpper() == ".ZIP");
                    fi.Delete();                    
                }
                catch (Exception e)
                {
                    result.Status = "ERROR";
                    result.Message = e.InnerException == null ? e.Message : e.InnerException.Message;
                    result.Message += "  StackTrace:";
                    result.Message += e.StackTrace;
                    Logger.Error(result.Message, LoggerPrefix);

                }
                finally
                {
                    fileData = null;
                }
                resultMessage.Append(result.Message);
                resultMessage.Append("<br>");
            }
            result.Message = resultMessage.ToString();
            return Request.CreateResponse(HttpStatusCode.OK, result);
        }

        UpdateStatusDb ImportFile(string fileName, byte[] fileData, string inPath, string arcPath, bool isZip)
        {
            //bool isUnzip = !string.IsNullOrEmpty(unzipFName);
            UpdateStatusDb result = _repository.ImportFile(fileName, fileData, isZip);
            if (!Directory.Exists(arcPath))
            {
                Directory.CreateDirectory(arcPath);
            }
            File.Copy(Path.Combine(inPath, fileName), Path.Combine(arcPath, fileName), true);

            Logger.Info(string.Format("End import file: {0}", fileName), LoggerPrefix);

            return result;
        }

        [HttpDelete]
        public HttpResponseMessage Delete(decimal id)
        {
            try
            {
                //_repository.DeleteFile(item.id);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = 1, Message = "Файл успішно видалено" });
                return response;
            }
            catch (Exception exception)
            {
                return Request.CreateResponse(HttpStatusCode.OK,
                    new { Data = 0, Message = exception.Message });
            }
        }
    }
}