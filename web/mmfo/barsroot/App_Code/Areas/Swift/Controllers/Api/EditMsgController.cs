using Areas.Swift.Models;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Swift.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Swift.Infrastructure.DI.Implementation;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.Swift.Controllers.Api
{
    public class EditMsgController : ApiController
    {
        readonly ISwiftRepository _repo;
        public EditMsgController(ISwiftRepository repo) { _repo = repo; }

        [HttpGet]
        [GET("/api/swieditmsg")]
        public HttpResponseMessage SwiEditMsg([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, decimal swref)
        {
            try
            {
                BarsSql sql = SqlCreatorEditMsg.SwiEditMsgSearch(swref);
                IEnumerable<SwiEditMsg> data = _repo.SearchGlobal<SwiEditMsg>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        [POST("/api/swieditmsgswopt")]
        public HttpResponseMessage SwOpt(UnlockMsgsEdit obj)
        {
            try
            {
                IEnumerable<string> opt = _repo.ExecuteStoreQuery<string>(SqlCreatorEditMsg.SwOpt());
                IEnumerable<SwModelOpt> optByMt = _repo.ExecuteStoreQuery<SwModelOpt>(SqlCreatorEditMsg.SwOpt(obj.MT));

                return Request.CreateResponse(HttpStatusCode.OK, new { DataOpt = opt, DataOptByMt = optByMt });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        [POST("/api/swireceiversender")]
        public HttpResponseMessage SwiReceiverSender(UnlockMsgsEdit obj)
        {
            try
            {
                BarsSql sql = SqlCreatorEditMsg.SwiReceiverSender(obj.SWREF);
                IEnumerable<SwiEditReceiverSender> data = _repo.ExecuteStoreQuery<SwiEditReceiverSender>(sql);
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data.FirstOrDefault() });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        [POST("/api/swieditmsgsave")]
        public HttpResponseMessage SwiEditMsgSave(SwiEditSave obj)
        {
            try
            {
                BarsSql sql;
                foreach (SwiEditMsg o in obj.data)
                {
                     sql = SqlCreatorEditMsg.Save(o);
                    _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
                }
                sql = SqlCreatorEditMsg.UpdateMsg(obj.swref, obj.mt);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                return Request.CreateResponse(HttpStatusCode.OK, new { });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        [POST("/api/swieditmsgcleartmp")]
        public HttpResponseMessage SwiEditMsgClearTmp(UnlockMsgsEdit obj)
        {
            try
            {
                BarsSql sql = SqlCreatorEditMsg.ClearTmpMsg(obj.SWREF);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
                return Request.CreateResponse(HttpStatusCode.OK, new {  });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
    }
}