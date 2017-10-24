using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using BarsWeb.Controllers;
using System.Web.Mvc;
using Areas.Cdm.Models;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Cdm.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Models;
using Kendo.Mvc.UI;
using Newtonsoft.Json;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract.Individual;
using BarsWeb.Areas.Cdm.Infrastructure.DI.Abstract.PrivateEn;
using BarsWeb.Areas.Cdm.Infrastructure.DI.Abstract.Legal;

namespace BarsWeb.Areas.Cdm.Controllers
{
    [CheckAccessPage]
    [Authorize]
    public class QualityController : ApplicationController
    {
        private readonly IQualityRepository _repo;
        private readonly ICdmRepository _cdmRepo;
        private readonly ICdmLegalRepository _cdmRepoLegal;
        private readonly ICdmPrivateEnRepository _cdmRepoPrivateEn;
        private readonly IBranchesRepository _branchRepo;
        public QualityController(IQualityRepository repo, ICdmRepository cdmRepo, ICdmLegalRepository cdmRepoLegal, ICdmPrivateEnRepository cdmRepoPrivateEn, IBranchesRepository branchRepo)
        {
            _repo = repo;
            _cdmRepoLegal = cdmRepoLegal;
            _cdmRepoPrivateEn = cdmRepoPrivateEn;
            _cdmRepo = cdmRepo;
            _branchRepo = branchRepo;
        }

        public ActionResult Index(string mode)
        {
            ViewBag.Mode = mode;
            return View();
        }

        public ActionResult AdvisoryList(AdvisoryListParams listParams)
        {

            string type = Request.Params.Get("type");

            if (type != "individualPerson")
            {
                listParams.Type = type;
                listParams.GroupId = 1;
                listParams.SubGroupId = null;
                listParams.SubGroupOrd = null;

                return View(listParams);
            }
            return View(listParams);
        }

        public ActionResult GetAdvisoryList([DataSourceRequest] DataSourceRequest request, AdvisoryListParams listParams)
        {
            var total = _repo.GetAdvisoryListCount(listParams, request);
            if (listParams.Type == "individualPerson")
            {
                var data = _repo.GetAdvisoryList(listParams, request);
                return Json(new { Data = data, Total = total }, JsonRequestBehavior.AllowGet);
            }
            else if (listParams.Type == "legalPerson")
            {
                var data = _repo.GetAdvisoryListLegal(listParams, request);
                return Json(new { Data = data, Total = total }, JsonRequestBehavior.AllowGet);
            }
            else if (listParams.Type == "entrepreneurPerson")
            {
                var data = _repo.GetAdvisoryListPrivate(listParams, request);
                return Json(new { Data = data, Total = total }, JsonRequestBehavior.AllowGet);
            }
            return null;

        }

        public ActionResult GetAdvisoryListByRnk(int rnk, int groupId, string type)
        {
            if (type == "individualPerson")
            {
                var data = _repo.GetAdvisoryList(new AdvisoryListParams() { GroupId = groupId, CustRnk = rnk, Type = type });
                return Json(new { data }, JsonRequestBehavior.AllowGet);
            }
            else if (type == "legalPerson")
            {
                var data = _repo.GetAdvisoryListLegal(new AdvisoryListParams() { GroupId = groupId, CustRnk = rnk, Type = type });
                return Json(new { data }, JsonRequestBehavior.AllowGet);
            }
            else if (type == "entrepreneurPerson")
            {
                var data = _repo.GetAdvisoryListPrivate(new AdvisoryListParams() { GroupId = groupId, CustRnk = rnk, Type = type });
                return Json(new { data }, JsonRequestBehavior.AllowGet);
            }
            return null;
        }

        public ActionResult GetGroups(bool isAdminMode, string type)
        {
            return Json(_repo.GetQualityGroups(isAdminMode, type), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetSubGroups(string type)
        {
            return Json(_repo.GetQualitySubGroups(type), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetCustAdvisoryList(decimal rnk, string type)
        {
            if(type == "individualPerson")
            {
                return Json(_repo.GetCustAdvisory(rnk), JsonRequestBehavior.AllowGet);
            }
            else if (type == "legalPerson")
            {
                return Json(_repo.GetCustAdvisoryLegal(rnk), JsonRequestBehavior.AllowGet);
            }
            else if (type == "entrepreneurPerson")
            {
                return Json(_repo.GetCustAdvisoryPrivate(rnk), JsonRequestBehavior.AllowGet);
            }
            return null;
        }

        public ActionResult GetAllAttrGroups()
        {
            return Json(_repo.GetAllAttrGroups(), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetCustAttributesList(decimal rnk, string type)
        {
            if(type == "individualPerson")
            {
                List<EBK_CUST_ATTR_LIST_V> result = _repo.GetCustAttributesList(rnk).ToList();
                var defCulture = CultureInfo.CreateSpecificCulture("en-US");
                return Json(result, JsonRequestBehavior.AllowGet);
            }
            else if(type == "legalPerson")
            {
                List<V_EBKC_LEGAL_ATTR_LIST>result = _repo.GetCustAttributesListLegal(rnk).ToList();
                var defCulture = CultureInfo.CreateSpecificCulture("en-US");
                return Json(result, JsonRequestBehavior.AllowGet);
            }
            else if (type == "entrepreneurPerson")
            {
                List<V_EBKC_PRIV_ATTR_LIST> result = _repo.GetCustAttributesListPrivate(rnk).ToList();
                var defCulture = CultureInfo.CreateSpecificCulture("en-US");
                return Json(result, JsonRequestBehavior.AllowGet);
            }
            return null;
        }
        public ActionResult SaveCustomerAttributes(string newData, string type)
        {
            var result = new JsonResponseEbk(JsonResponseStatus.Ok);
            try
            {
                var attrList = JsonConvert.DeserializeObject<List<CustomerAttribute>>(newData);
                var rnk = attrList.First().Rnk;
                _repo.SaveCustomerAttributes(attrList, type);
                if (type == "individualPerson")
                {
                    result.data = _cdmRepo.PackAndSendSingleCard(rnk);
                    result.message = "Зміни до картки успішно внесено.";
                }
                else if (type == "legalPerson")
                {
                    result.data = _cdmRepoLegal.PackAndSendSingleCard(rnk);
                    result.message = "Зміни до картки успішно внесено.";
                }
                else if (type == "entrepreneurPerson")
                {
                    result.data = _cdmRepoPrivateEn.PackAndSendSingleCard(rnk);
                    result.message = "Зміни до картки успішно внесено.";
                }

            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetDropDownData(string type)
        {
            var result = _repo.GetAllDropDownData(type);
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        protected override JsonResult Json(object data, string contentType, System.Text.Encoding contentEncoding, JsonRequestBehavior behavior)
        {
            return new JsonResult()
            {
                Data = data,
                ContentType = contentType,
                ContentEncoding = contentEncoding,
                JsonRequestBehavior = behavior,
                MaxJsonLength = Int32.MaxValue
            };
        }

        public ActionResult GetDialogData([DataSourceRequest] DataSourceRequest request, string dialogName)
        {
            var result = _repo.GetDialogData(dialogName, request);
            return Json(new { Data = result, Total = _repo.LastDialogDataLendth(), Title = _repo.LastDialogDescription() }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetQualityGroupList([DataSourceRequest] DataSourceRequest request, decimal groupId) //Change??
        {
            var result = _repo.GetCustomGroupsList(groupId);
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DeleteSubgroup(decimal group, decimal subGroup)
        {
            var result = new JsonResponseEbk(JsonResponseStatus.Ok);
            try
            {
                _repo.DeleteQualitySubgroup(group, subGroup);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult AddSubgroup(decimal group, string sign, decimal percent)
        {
            var result = new JsonResponseEbk(JsonResponseStatus.Ok);
            try
            {
                _repo.AddSubgroup(group, sign, percent);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult BranchList()//Change ??
        {
            return Json(_branchRepo.GetAllBranches().Select(b => b.Branch), JsonRequestBehavior.AllowGet);
        }
    }

}