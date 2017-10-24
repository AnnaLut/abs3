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

namespace BarsWeb.Areas.Way.Controllers.Api
{
    [AuthorizeApi]
    public class FileController : ApiController
    {
        private readonly IWayRepository _repository;
        public FileController(IWayRepository repository)
        {
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
            var result = new UpdateStatusDb();
            var inPath = _repository.GetGlobalOption("OWINDIR");
            var arcPath = Path.Combine(_repository.GetGlobalOption("OWARCDIR"), DateTime.Now.ToString("dd.MM.yyyy"));
            StringBuilder resultMessage = new StringBuilder();
            foreach (var fileName in fileNames)
            {
                byte[] fileData;
                var file = File.OpenRead(Path.Combine(inPath, fileName));
                using (var binaryReader = new BinaryReader(file))
                {
                    fileData = binaryReader.ReadBytes((int)file.Length);
                }
                try
                {
                    result = _repository.ImportFile(fileName, fileData);                    
                    if (!Directory.Exists(arcPath))
                    {
                        Directory.CreateDirectory(arcPath);
                    }                    
                    Directory.Move(Path.Combine(inPath,fileName), Path.Combine(arcPath, fileName));
                }
                catch (Exception e)
                {
                    result.Status = "ERROR";
                    result.Message = e.InnerException == null ? e.Message : e.InnerException.Message;

                }
                resultMessage.Append(result.Message);
                resultMessage.Append("<br>");
            }
            result.Message = resultMessage.ToString();
            return Request.CreateResponse(HttpStatusCode.OK, result);
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