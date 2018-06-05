using AttributeRouting.Web.Http;
using System;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web;
using System.Web.Http;
using BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using Newtonsoft.Json;
using System.Linq;
using Kendo.Mvc.UI;
using Kendo.Mvc.Extensions;
using System.Web.Http.ModelBinding;


namespace BarsWeb.Areas.BpkW4.Controllers.Api
{
    public class BatchBranchingApiController : ApiController
    {
        private readonly IBatchBranchingRepository _repository;
        private readonly IBranchesRepository _branches;

        public BatchBranchingApiController(IBatchBranchingRepository repository, IBranchesRepository branches)
        {
            _repository = repository;
            _branches = branches;
        }

        //[GET("api/BpkW4/BatchBranchingApi/GetAllFiles")]
        public HttpResponseMessage GetAllFiles([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request)
        {
            Kendo.Mvc.SortDescriptor sort = new Kendo.Mvc.SortDescriptor();
            var fileQuery = _repository.GetRebranchedFiles();
            var fileList = fileQuery.ToList();
            var sortParametr = request.Sorts;
            if (sortParametr.Count == 0)
            {
                sort.Member = "ID";
                sort.SortDirection = System.ComponentModel.ListSortDirection.Descending;
                sortParametr.Add(sort);
            }
            return Request.CreateResponse(HttpStatusCode.OK, fileList.ToDataSourceResult(request));
        }

        //[GET("api/BpkW4/BatchBranchingApi/GetContentFile")]
        public HttpResponseMessage GetFileContent([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, decimal? id)
        {
            var fileQuery = _repository.GetFileContent(id);
            var fileList = fileQuery.ToList();
            return Request.CreateResponse(HttpStatusCode.OK, fileList.ToDataSourceResult(request));
        }


        //[POST("api/BpkW4/BatchBranchingApi/Upload")]
        public HttpResponseMessage Upload()
        {
            HttpPostedFile file = HttpContext.Current.Request.Files[0];

            if (file != null && file.ContentLength > 0)
            {
                string result = new StreamReader(file.InputStream).ReadToEnd();
                string fileName = Path.GetFileName(file.FileName);
                byte[] array = Encoding.ASCII.GetBytes(result);
                using (MemoryStream mstream = new MemoryStream())
                {
                    using (System.IO.Compression.GZipStream gZipStream = new System.IO.Compression.GZipStream(mstream, System.IO.Compression.CompressionMode.Compress, true))
                    {
                        gZipStream.Write(array, 0, array.Length);
                    }
                    string id = _repository.ImportRebranchFile(fileName, mstream.ToArray());
                }
            }
            else throw new Exception("Файл не вибрано");

            return new HttpResponseMessage()
            {
                StatusCode = HttpStatusCode.OK,
            };
        }


    }
}
