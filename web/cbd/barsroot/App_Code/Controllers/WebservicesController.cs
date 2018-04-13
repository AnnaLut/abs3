using System;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Models;
using Models;

namespace BarsWeb.Controllers
{
    [AuthorizeUser]
    [CheckAccessPage]
    public class WebservicesController : ApplicationController
    {
        EntitiesBars _entities;

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Calculator()
        {
            return View();
        }
        /// <summary>
        /// форма конвертора валют
        /// </summary>
        /// <returns></returns>
        public ActionResult Converter()
        {
            _entities = new EntitiesBarsCore().NewEntity();
            var date = _entities.ExecuteStoreQuery<DateTime>("SELECT bankdate FROM dual").FirstOrDefault();
            ViewBag.Date = date.Day + "/" + date.Month + "/" +date.Year;
            var tabval = _entities.TABVAL_GLOBAL.OrderBy(i=>i.NAME);
            return View(tabval);
        }
        /// <summary>
        /// конвертація валют
        /// </summary>
        /// <param name="valFrom">валюта конвертації</param>
        /// <param name="summFrom">сума конвертації</param>
        /// <param name="date">дата встановленого курсу</param>
        /// <param name="valTo">валюта в яку конвертувати</param>
        /// <param name="sourse">тип курсу (О-офіційний,В-купівлі,S-продажу)</param>
        /// <returns>JSON з результатом конвертації</returns>
        [HttpPost]
        public ActionResult Converter(decimal valFrom,decimal summFrom, string date, decimal valTo, decimal sourse)
        {
            var dateArr = date.Split('/');
            var dateFrom = new DateTime(Convert.ToInt32(dateArr[2]),Convert.ToInt32(dateArr[1]),Convert.ToInt32(dateArr[0]));
            var sourseFrom = "O"; 
            if (sourse != 1)
            {
                sourseFrom = "B";
            }
            string result;
            using (_entities = new EntitiesBarsCore().NewEntity())
            {
                try
                {
                    result = _entities.FConvertVal(valFrom, summFrom, dateFrom, valTo, sourseFrom);
                }
                catch (Exception e)
                {
                    return ErrorJson(e);
                }
            }
            return Json(new JsonResponse(JsonResponseStatus.Ok,result), JsonRequestBehavior.AllowGet);
        }

        public ActionResult Messages()
        {
            _entities = new EntitiesBarsCore().NewEntity();

            const string sql = "select um.*, f_get_userfio(um.MSG_SENDER_ID) as MSG_SENDER_FIO from V_USER_MESSAGES um";
            var mess = _entities.ExecuteStoreQuery<V_USER_MESSAGES>(sql).ToList();
            return View(mess);
        }
            
        public FileResult ConvertSvg(decimal? width, decimal? height, string svg,string type = "image/png")
        {
            var file = new FileStream("",FileMode.Open);
            return File(file,type);
        }
    }
}