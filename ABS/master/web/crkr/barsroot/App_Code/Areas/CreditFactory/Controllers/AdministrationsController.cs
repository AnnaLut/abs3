using System;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Areas.CreditFactory.Infrastructure.Repository.DI.Abstract;
using Areas.CreditFactory.Models;
using BarsWeb.Controllers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using BarsWeb.Areas.CreditFactory.ViewModels;

namespace BarsWeb.Areas.CreditFactory.Controllers
{
    [AuthorizeUser]
    public class AdministrationsController : ApplicationController
    {
        private readonly ICreditFactoryRepository _cfRepository;

        public AdministrationsController(ICreditFactoryRepository cfRepository)
        {
            _cfRepository = cfRepository;
        }

        public ViewResult Index()
        {
            return View();
        }

        public ViewResult LogList()
        {
            var logList = _cfRepository.GetReqRespLog();
            return View(logList);
        }

        public ViewResult SyncParams()
        {
            var sParams = _cfRepository.GetSetingsBranch();
            return View(sParams);
        }
        public ActionResult GetLogList([DataSourceRequest] DataSourceRequest request, string logDir)
        {
            IQueryable<CF_REQUEST_LOG> session;
            session = String.IsNullOrEmpty(logDir) ? _cfRepository.GetReqRespLog() : _cfRepository.GetReqRespLogDir(logDir);
            return Json(session.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetSyncParam([DataSourceRequest] DataSourceRequest request)
        {
            IQueryable<V_CF_SETINGS> session;
            session = _cfRepository.GetSetingsBranch();
            return Json(session.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult CreateSyncParam([DataSourceRequest] DataSourceRequest request, SyncParams syncParams)
        {
            syncParams = _cfRepository.CreateSyncParam(syncParams);
            return Json(new[] { syncParams }.ToDataSourceResult(request, ModelState));
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult UpdateSyncParam([DataSourceRequest] DataSourceRequest request, SyncParams syncParams)
        {
            if (syncParams != null)
            {
                try
                {
                    _cfRepository.UpdateSyncParams(syncParams);
                }
                catch (Exception ex)
                {
                    return DataSourceErrorResult(ex);
                }
            }

            return Json(new[] { syncParams }.ToDataSourceResult(request, ModelState));
        }
        
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult DestroySyncParam([DataSourceRequest] DataSourceRequest request, SyncParams syncParams)
        {
            if (syncParams != null)
            {
                try
                {
                    _cfRepository.DestroySyncParam(syncParams.Mfo);
                }
                catch (Exception ex)
                {
                    return DataSourceErrorResult(ex);
                }
            }

            return Json(new[] { syncParams }.ToDataSourceResult(request, ModelState));
        }

        public void Ping()
        {
            _cfRepository.Ping();
        }

        private JsonResult DataSourceErrorResult(Exception ex)
        {
            return Json(new DataSourceResult
            {
                Errors = new
                {
                    message = ex.ToString(),
                },
            });
        }
    }
}