using BarsWeb;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Http;
using System.Text;
using System.Web.Http;
using AttributeRouting.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb;
using System.Web.Http;
using BarsWeb.Areas.MetaDataAdmin.Infrastructure.Repository.DI.Abstract;
using Newtonsoft.Json;
using BarsWeb.Areas.MetaDataAdmin.Models;
using System.Net;
/// <summary>
/// Summary description for MetaTablesInfoController
/// </summary>

[Authorize]
[AuthorizeApi]
[CheckAccessPage]
public class ReferenceBookAdminController : ApiController
{
    readonly private IReferenceBookRepository _repository;
	public ReferenceBookAdminController(IReferenceBookRepository repository)
	{
        _repository = repository;
		//
		// TODO: Add constructor logic here
		//
	}

    [HttpPost]
    [POST("api/MetadataAdmin/ReferenceBook/InsertData")]
    public HttpResponseMessage InsertData(int tableId, string tableName, string jsonInsertableRow)
    {
        try
        {
            var insertableRow = JsonConvert.DeserializeObject<List<FieldProperties>>(jsonInsertableRow);
            bool success = _repository.InsertData(tableId, tableName, insertableRow);
            if (success)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new { status = "ok", msg = "Новий рядок успішно додано" });
            }
            return Request.CreateResponse(HttpStatusCode.OK, new { status = "error", msg = "Виникла помилка при оновленні даних.\r\n" });
        }
        catch (Exception e)
        {
            return Request.CreateResponse(HttpStatusCode.OK, new { status = "error", msg = "Помилка при оновленні даних.<br />" + e.Message });
        }
    }
    //[GET("api/ndi/ReferenceBookAdmin/GetData")]
    //public DataSourceResult GetData(DataSourceRequest request)
    //{
    //    var data = _repository.ArchiveGrid("01").Tables[0].AsEnumerable().FirstOrDefault();
    //    if (data != null)
    //    {
    //        return  data.Table.ToDataSourceResult(request);
    //    }

    //    return new DataSourceResult(); 
    //}

}