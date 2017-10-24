using BarsWeb;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using BarsWeb.Areas.Ndi.Infrastructure;
using BarsWeb.Areas.Ndi.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Ndi.Models;
using AttributeRouting.Web.Http;
using Kendo.Mvc.UI;
using System.Web.Http.ModelBinding;
using System.Web.Mvc;
using BarsWeb.Models;
using System.Data;
using Kendo.Mvc.Extensions;

/// <summary>
/// Summary description for ReferenceBookController
/// </summary>
/// 
[AuthorizeApi]
//[CheckAccessPage]
public class ReferenceBookController : ApiController
{
    readonly private IReferenceBookRepository _repository;
	public ReferenceBookController(IReferenceBookRepository repository)
	{
        _repository = repository;
		//
		// TODO: Add constructor logic here
		//
	}
    //[GET("api/ndi/ReferenceBook/GetData")]
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