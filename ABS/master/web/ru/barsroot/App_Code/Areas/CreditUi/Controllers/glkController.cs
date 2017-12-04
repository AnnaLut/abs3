using System.Web.Mvc;
using System.Linq;
using BarsWeb.Controllers;
using BarsWeb.Areas.CreditUi.Infrastructure.DI.Abstract;
using BarsWeb.Areas.CreditUi.Models;
using Kendo.Mvc.UI;
using Kendo.Mvc.Extensions;
using System.Collections.Generic;
using System;
using System.Web.Script.Serialization;

/// <summary>
/// Summary description for glkController
/// </summary>
namespace BarsWeb.Areas.CreditUi.Controllers
{
    [AuthorizeUser]
    public class glkController : ApplicationController
    {
        private readonly IglkRepository _glkRepository;

        public glkController(IglkRepository glkRepository)
        {
            _glkRepository = glkRepository;
        }

        public ActionResult Index(decimal id)
        {
            return View("~/Areas/CreditUi/Views/glk/Index.cshtml");
        }

        public ActionResult GetGLK(decimal id, [DataSourceRequest]DataSourceRequest request)
        {
            IQueryable<GLK> session = _glkRepository.GetGLK(id);
            return Json(session.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetStaticData(decimal nd)
        {
            return Json(_glkRepository.GetStaticData(nd));
        }

        public void BeforeGPK(decimal nd)
        {
            _glkRepository.PreGpkOpen(nd);
        }

        public void BalanceGLK(decimal nd)
        {
            _glkRepository.BalanceGLK(nd);
        }

        public ActionResult CreateGLKProject(decimal nd, decimal acc)
        {  
            string Status = "ok";
            try
            {
                _glkRepository.CreateGLKProject(nd, acc);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status });
        }

        public ActionResult AddGLK(string glkString)
        {
            string Status = "ok";
            try
            {
                var serializer = new JavaScriptSerializer();
                UpdateGLK glk = serializer.Deserialize<UpdateGLK>(glkString);
                List<UpdateGLK> list = new List<UpdateGLK>();
                list.Add(glk);
                _glkRepository.GroupUpdateGLK(0, list);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status });
        }

        public ActionResult UpdateGLK(string glkString)
        {
            string Status = "ok";
            try
            {
                var serializer = new JavaScriptSerializer();
                UpdateGLK glk = serializer.Deserialize<UpdateGLK>(glkString);
                List<UpdateGLK> list = new List<UpdateGLK>();
                list.Add(glk);
                _glkRepository.GroupUpdateGLK(1, list);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status });
        }

        public ActionResult GroupDelete(string glkString)
        {
            string Status = "ok";
            try
            {
                var serializer = new JavaScriptSerializer();
                List<UpdateGLK> glk = serializer.Deserialize<List<UpdateGLK>>(glkString);
                _glkRepository.GroupUpdateGLK(2,glk);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status });

        }

        public ActionResult GetArchive(decimal id, [DataSourceRequest]DataSourceRequest request)
        {
            IQueryable<glkArchive> session = _glkRepository.GetArchive(id);
            return Json(session.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetArchiveBody(decimal id, [DataSourceRequest]DataSourceRequest request)
        {
            IQueryable<glkArchiveBody> session = _glkRepository.GetArchiveBody(id);
            return Json(session.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult RestoreGLK(decimal id)
        {
            string Status = "ok";
            try
            {
                _glkRepository.RestoreGLK(id);
            }
            catch (Exception e) { Status = e.Message + " StackTrace=" + e.StackTrace; }
            return Json(new { Status = Status });
        }
    }
}