using System;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Areas.InsUi.Infrastructure.DI.Abstract;
using Areas.InsUi.Models;
using BarsWeb.Areas.InsUi.Models;
using BarsWeb.Controllers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System.Security.Cryptography;
using System.Text;

namespace BarsWeb.Areas.InsUi.Controllers
{
    [AuthorizeUser]
    public class AdministrationController : ApplicationController
    {
        private readonly IInsRepository _insRepository;

        public AdministrationController(IInsRepository insRepository)
        {
            _insRepository = insRepository;
        }

        public ViewResult Index()
        {
            return View();
        }

        public ActionResult GetParams()
        {
            IQueryable<INS_PARAMS_INTG> session;
            session = _insRepository.GetParams();
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetParamMfo(string kf)
        {
            IQueryable<INS_PARAMS_INTG> session;
            session = _insRepository.GetParamMfo(kf);
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        public ActionResult CheckUrlApi(string url)
        {
            int session = _insRepository.CheckUrlApi(url);
            return Json(session, JsonRequestBehavior.AllowGet);
        }

        //[HttpPost]
        public void CreateSyncParam([DataSourceRequest] DataSourceRequest request, CreateParams param)
        {
            SHA1CryptoServiceProvider sh = new SHA1CryptoServiceProvider();
            sh.ComputeHash(ASCIIEncoding.ASCII.GetBytes(param.HPASSWORD));
            byte[] bt = sh.Hash;
            StringBuilder sb = new StringBuilder();
            foreach (byte item in bt)
            {
                sb.Append(item.ToString("x2"));
            }
            param.HPASSWORD = sb.ToString();
            _insRepository.CreateSyncParams(param);
        }

        public void UpdateSyncParam([DataSourceRequest] DataSourceRequest request, CreateParams param)
        {
            SHA1CryptoServiceProvider sh = new SHA1CryptoServiceProvider();
            sh.ComputeHash(ASCIIEncoding.ASCII.GetBytes(param.HPASSWORD));
            byte[] bt = sh.Hash;
            StringBuilder sb = new StringBuilder();
            foreach (byte item in bt)
            {
                sb.Append(item.ToString("x2"));
            }
            param.HPASSWORD = sb.ToString();
            _insRepository.UpdateSyncParams(param);
        }

        public void DeleteSyncParam([DataSourceRequest] DataSourceRequest request, CreateParams param)
        {
            _insRepository.DeleteSyncParams(param);
        }
    }
}