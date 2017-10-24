using Areas.Swift.Models;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Swift.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Swift.Infrastructure.DI.Implementation;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.Swift.Controllers.Api
{
    public class Stmt950Controller : ApiController
    {
        readonly ISwiftRepository _repo;
        public Stmt950Controller(ISwiftRepository repo) { _repo = repo; }

        [HttpGet]
        [GET("/api/stmt950search")]
        public HttpResponseMessage Stmt950Search([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request)
        {
            try
            {
                BarsSql sql = SqlCreatorStmt950.SearchMain();
                IEnumerable<Stmt950Main> data = _repo.SearchGlobal<Stmt950Main>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        [POST("/api/stmt950createcustomerstatementmessage")]
        public HttpResponseMessage Stmt950CreateCustomerStatementMessage(Stmt950CustomerStatementMessage obj)
        {
            try
            {
                DateTime dt1 = DateTime.ParseExact(obj.dat1, "dd.MM.yyyy", CultureInfo.InvariantCulture);
                DateTime dt2 = DateTime.ParseExact(obj.dat2, "dd.MM.yyyy", CultureInfo.InvariantCulture);

                BarsSql sql = SqlCreatorStmt950.CreateCustomerStatementMessage(obj.bic, obj.rnk, dt1, dt2, obj.stmt);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                return Request.CreateResponse(HttpStatusCode.OK, new { });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }        
    }
}