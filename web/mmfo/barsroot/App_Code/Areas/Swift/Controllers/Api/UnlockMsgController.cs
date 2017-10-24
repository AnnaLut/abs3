using Areas.Swift.Models;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Swift.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Swift.Infrastructure.DI.Implementation;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using Kendo.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.Swift.Controllers.Api
{
    public class UnlockMsgController: ApiController
    {
        readonly ISwiftRepository _repo;
        readonly string[] _filterMembers4UpperCase;
        public UnlockMsgController(ISwiftRepository repo)
        {
            _repo = repo;

            _filterMembers4UpperCase = new string[]  { "RECEIVER", "SENDER", "TRN" };
        }

        [HttpGet]
        [GET("/api/swiunlockmsg")]
        public HttpResponseMessage SwiUnlockMsg([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string mt)
        {
            try
            {
                if (request.Filters != null && request.Filters.Count > 0)
                {
                    SetFiltersUpperCase(request.Filters);                                    
                }
                BarsSql sql = SqlCreatorUnlockMsg.SwiUnlockMsg(mt);
                IEnumerable<UnlockMsgs> data = _repo.SearchGlobal<UnlockMsgs>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        [POST("/api/swiunlockmsgdetail")]
        public HttpResponseMessage SwiUnlockMsgDetail(СlaimsRowRequestData obj)
        {
            try
            {
                var data = _repo.ExecuteStoreQuery<ClaimsRowData>(SqlCreatorUnlockMsg.SwiUnlockMsgView(obj.SWREF));
                var senderTitle = _repo.ExecuteStoreQuery<ClaimsRowTitle>(SqlCreator.ClaimsRowTitle(obj.SENDER));
                var receiverTitle = _repo.ExecuteStoreQuery<ClaimsRowTitle>(SqlCreator.ClaimsRowTitle(obj.RECEIVER));

                return Request.CreateResponse(HttpStatusCode.OK, new
                {
                    Data = data,
                    SenderTitle = senderTitle,
                    ReceiverTitle = receiverTitle
                });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        [POST("/api/swiunlockmsgaction")]
        public HttpResponseMessage SwiUnlockMsgAction(SwiUnlockMsgAction obj)
        {
            try
            {
                foreach (decimal swref in obj.swrefs)
                {
                    BarsSql sql = SqlCreatorUnlockMsg.SwiUnlockMsgAction(obj.aType, swref, obj.p_retOpt);
                    _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
                }

                return Request.CreateResponse(HttpStatusCode.OK, new { });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        [POST("/api/swiunlockmsgedit")]
        public HttpResponseMessage SwiUnlockMsgEdit(UnlockMsgsEdit obj)
        {
            try
            {
                BarsSql sql = SqlCreatorApprovals.GenFullMessage(obj.SWREF, obj.MT);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);

                return Request.CreateResponse(HttpStatusCode.OK, new { });
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        void SetFiltersUpperCase(IEnumerable<IFilterDescriptor> filters)
        {
            foreach (IFilterDescriptor fd in filters)
            {
                if (fd is CompositeFilterDescriptor)
                {
                    SetFiltersUpperCase(((CompositeFilterDescriptor)fd).FilterDescriptors);
                }
                else
                {
                    ((FilterDescriptor)fd).Value = SetFilterUpperCase((FilterDescriptor)fd).Value;
                }
            }
        }

        FilterDescriptor SetFilterUpperCase(FilterDescriptor f)
        {
            if (_filterMembers4UpperCase.Contains(f.Member))
            {
                string v = f.Value as string;
                if (!string.IsNullOrEmpty(v))
                {
                    f.Value = v.ToUpper();
                }
            }
            return f;
        }
    }
}

