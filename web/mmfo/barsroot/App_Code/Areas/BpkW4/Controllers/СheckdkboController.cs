using System;
using System.Web.Mvc;
using BarsWeb.Controllers;
using Kendo.Mvc.UI;
using System.IO;
using BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.BpkW4.Models;
using System.Collections.Generic;
using Newtonsoft.Json;
using System.Collections;
using BarsWeb.Core.Models.Json;
using Kendo.Mvc;
using System.Linq;

namespace BarsWeb.Areas.BpkW4.Controllers
{
    [AuthorizeUser]
    public class CheckdkboController : ApplicationController
    {
        private readonly ICheckdkboRepository _repository;
        public CheckdkboController(ICheckdkboRepository repository)
        {
            _repository = repository;
        }

        // 1). ИНИЦИАЛИЗАЦИЯ ОСНОВНОГО VIEW 
        public ActionResult Index(W4_DKBO_WEB_FilterParams fp)
        {
            //Параметр приходить из портфеля БПК
            var rnk = Request.Params.Get("rnk");

            if (rnk != null)
            {
                fp.CUSTOMER_ID = rnk;
            }

            return View(fp);
        }

        // 2). ОТОБРАЖЕНИЕ АНКЕТЫ
        [HttpGet]
        public ActionResult QuestItemsShow(W4_DKBO_WEB_FilterParams fp, Hashtable htResult)
        {
            ViewBag.CUSTOMER_BDAY = fp.CUSTOMER_BDAY;
            ViewBag.CUSTOMER_NAME = fp.CUSTOMER_NAME_HIDDEN;
            ViewBag.CUSTOMER_ID = fp.CUSTOMER_ID;
            ViewBag.CUSTOMER_ZKPO = fp.CUSTOMER_ZKPO;
            ViewBag.PASS_SERIAL = fp.PASS_SERIAL;
            ViewBag.PASS_NUMBER = fp.PASS_NUMBER;
            ViewBag.CUSTOMER_NAME = fp.CUSTOMER_NAME;
            if (fp.DEAL_ID.HasValue)
            {
                ViewBag.DEAL_ID = fp.DEAL_ID;
            }
            // IF DEAL_ID EXIST - List with fill data as model 
            var model = _repository.Get_W4_DKBO_QUESTION(fp);

            if (Session["htResult"] != null)
                ViewBag.htResult = Session["htResult"];

            return View(model);
        }

        [HttpGet]
        public ActionResult QuestItemsDisplay(decimal dealId, string customerRnk)
        {
            W4_DKBO_WEB_FilterParams fp = new W4_DKBO_WEB_FilterParams() { DEAL_ID = dealId, CUSTOMER_ID = customerRnk};
            return RedirectToAction("QuestItemsShow", fp);
        }


        [HttpPost]
        [ActionName("QuestItemsShow")]
        public ActionResult QuestItemsShowPost(W4_DKBO_WEB_FilterParams fp)
        {
            ViewBag.CUSTOMER_NAME = fp.CUSTOMER_NAME_HIDDEN;
            ViewBag.CUSTOMER_BDAY = fp.CUSTOMER_BDAY;
            ViewBag.CUSTOMER_ID = fp.CUSTOMER_ID;
            ViewBag.CUSTOMER_ZKPO = fp.CUSTOMER_ZKPO;
            ViewBag.PASS_SERIAL = fp.PASS_SERIAL;
            ViewBag.PASS_NUMBER = fp.PASS_NUMBER;

            if (fp.DEAL_ID.HasValue)
            {
                ViewBag.DEAL_ID = fp.DEAL_ID.Value;
                var model = _repository.Get_W4_DKBO_QUESTION(fp);
                return View(model);
            }
            return RedirectToAction("Index", fp);
        }

        public ActionResult GetQuestionByType(W4_DKBO_QUESTION_Result foreachItemFromAnswers, string DEAL_ID)
        {
            W4_DKBO_WEB_FilterParams fp = new W4_DKBO_WEB_FilterParams();
            fp.list_code = foreachItemFromAnswers.LIST_CODE;
            var listInstanceByListCodeModel = _repository.Get_V_LIST_ITEMS(fp);
            switch (foreachItemFromAnswers.QUEST_TYPE)
            {
                case "STRING":
                    return PartialView("StringTypeItemPartial", new QuestItemViewModel(foreachItemFromAnswers));
                case "LIST":
                    return PartialView("ListTypeItemPartial", new QuestItemViewModel
                        (listInstanceByListCodeModel, foreachItemFromAnswers, DEAL_ID));
                case "NUMBER":
                    return PartialView("NumberTypeItemPartial", new QuestItemViewModel(foreachItemFromAnswers));
                case "DATE":
                    return PartialView("DateTypeItemPartial", new QuestItemViewModel(foreachItemFromAnswers));
            }
            return null;
        }

        [HttpPost]
        public ActionResult SaveAnswers(W4_DKBO_WEB_FilterParams fp)
        {
            if (fp.submitButton == "Close")
                return RedirectToAction("Index");

            Hashtable hashtable = new Hashtable();
            var keys = Request.Form.AllKeys;

            foreach (string key in keys)
                hashtable.Add(key, Request.Form.Get(key));

            if (fp.DEAL_ID.HasValue)
            {
                Hashtable htResult = (Hashtable)_repository.SetAnswers(hashtable, fp.DEAL_ID.ToString());
                Session["htResult"] = htResult;
                return RedirectToAction("Index", fp);
            }
            return null;
        }

        public ActionResult Get_W4_DKBO_WEB_Grid([DataSourceRequest]DataSourceRequest request)
        {
            ModifyFilters(request.Filters);
            var dkboList = _repository.Get_W4_DKBO_WEB(request);
            return Json(new { Data = dkboList, Total = (request.Page * request.PageSize) + 1, JsonRequestBehavior.AllowGet });

        }

        public ActionResult Print(List<string> selectedACC, List<string> selectedDocID)
        {
            List<object> printList = new List<object>();
            List<object> accList = new List<object>() { selectedACC[0] };
            Session["multiprint_id"] = accList;
            List<object> accfilterList = new List<object>() { selectedDocID[0] };
            Session["multiprint_filter"] = accfilterList;
            return Json(JsonResponseStatus.Ok, JsonRequestBehavior.AllowGet);
        }

        private void ModifyFilters(IEnumerable<IFilterDescriptor> filters)
        {
            if (filters.Any())
            {
                foreach (var filter in filters)
                {
                    var descriptor = filter as FilterDescriptor;
                    if (descriptor != null)
                    {
                        if (descriptor.Member == "CUSTOMER_NAME" || descriptor.Member == "PASS_SERIAL" || descriptor.Member == "NAME_SAL_PR")
                        {
                           descriptor.Value = descriptor.Value.ToString().ToUpper();
                        }
                    }
                    else if (filter is CompositeFilterDescriptor)
                    {
                        ModifyFilters(((CompositeFilterDescriptor)filter).FilterDescriptors);
                    }
                }
            }
        }
    }

    public class JsonFilter : ActionFilterAttribute
    {
        public string Param { get; set; }
        public Type JsonDataType { get; set; }
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext.HttpContext.Request.ContentType.Contains("application/json"))
            {
                string inputContent;
                using (var sr = new StreamReader(filterContext.HttpContext.Request.InputStream))
                {
                    inputContent = sr.ReadToEnd();
                }
                var result = JsonConvert.DeserializeObject(inputContent, JsonDataType);
                filterContext.ActionParameters[Param] = result;
            }
        }
    }
}