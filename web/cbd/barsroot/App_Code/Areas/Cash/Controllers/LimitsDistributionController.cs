using System;
using System.IO;
using System.Web;
using System.Web.Mvc;
using BarsWeb.Areas.Cash.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Cash.Models;
using BarsWeb.Controllers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Cash.Controllers
{
    /// <summary>
    /// Розподіл лімітів
    /// </summary>
    [AuthorizeUser]
    public class LimitsDistributionController : ApplicationController
    {
        private readonly ILimitsDistributionAccRepository _accLimDistRepository;
        private readonly ILimitsDistributionAtmRepository _atmLimDistRepository;
        private readonly ILimitsDistributionMfoRepository _mfoLimDistRepository;

        public LimitsDistributionController(
            ILimitsDistributionAccRepository accLimDistRepository, 
            ILimitsDistributionAtmRepository atmLimDistRepository,
            ILimitsDistributionMfoRepository mfoLimDistRepository)
        {
            _accLimDistRepository = accLimDistRepository;
            _atmLimDistRepository = atmLimDistRepository;
            _mfoLimDistRepository = mfoLimDistRepository;
        }

        /// <summary>
        /// Головна форма
        /// </summary>
        /// <returns></returns>
        public ViewResult Acc()
        {
            return View();
        }
        public ViewResult Atm()
        {
            return View();
        }
        public ViewResult Mfo()
        {
            return View();
        }
        [HttpGet]
        public ActionResult FileUpload(string date, string type)
        {
            ViewBag.Date = date;
            ViewBag.Type = type;
            return View();
        }
        [HttpPost]
        public ActionResult FileUpload(HttpPostedFileBase file, string date, string type)
        {
            ViewBag.Date = date;
            ViewBag.Type = type;
            var result = new UpdateDbStatus();
            if (file == null || file.InputStream == null)
            {
                result.Status = "ERROR";
                result.Message = "Не вибрано файл";
                ViewBag.UploadResult = result;

                return View();
            }
            if (string.IsNullOrEmpty(date))
            {
                result.Status = "ERROR";
                result.Message = "Не вибрано дату";
                ViewBag.UploadResult = result;

                return View();
            }
            byte[] fileData;
            using (var binaryReader = new BinaryReader(file.InputStream))
            {
                fileData = binaryReader.ReadBytes(file.ContentLength);
            }
            
            try
            {
                switch (type.ToUpper())
                {
                    case "ACC":
                        result = _accLimDistRepository.UploadFile(ToDateTime(date), fileData);
                        break;
                    case "ATM":
                        result = _atmLimDistRepository.UploadFile(ToDateTime(date), fileData);
                        break;
                    case "MFO":
                        result = _mfoLimDistRepository.UploadFile(ToDateTime(date), fileData);
                        break;
                    default:
                        result.Status = "ERROR";
                        result.Message = "Невірно вказано тип завантаження";
                        break;
                }
            }
            catch (Exception e)
            {
                result.Status = "ERROR";
                result.Message = e.InnerException == null ? e.Message : e.InnerException.Message;

            }

            ViewBag.UploadResult = result;

            return View();
        }

        public ActionResult ShowAccProtocol(decimal id)
        {
            return View(model: id);
        }

        public ActionResult GetAccProtocolData(
            [DataSourceRequest] DataSourceRequest request,
            decimal id)
        {
            var data = _accLimDistRepository.GetAccProtocolData(id);

            return Json(data.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        private DateTime ToDateTime(string date)
        {
            var dateArray = date.Split(' ')[0].Replace(".", "/").Split('/');
            return new DateTime(
                Convert.ToInt32(dateArray[2]),
                Convert.ToInt32(dateArray[1]),
                Convert.ToInt32(dateArray[0]));
        }

    }
}