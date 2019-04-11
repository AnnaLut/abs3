using BarsWeb.Areas.GDA.Models;
using BarsWeb.Controllers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Newtonsoft.Json;
using BarsWeb.Areas.GDA.Infrastructure.DI.Abstract;
using BarsWeb.Areas.GDA.Infrastructure.DI.Implementation;
using Areas.GDA.Models;
using Bars.EAD;

namespace BarsWeb.Areas.GDA.Controllers
{
    [AuthorizeUser]
    public class GDABackController : ApplicationController
    {
        readonly IGDARepository _repo;

        /// <summary>
        /// Кода документов в ЕА
        /// </summary>
        private readonly Dictionary<String, String[]> structCodes;
        //private readonly String[] structCodes = new String[] { "0930001", "0940001", "0930002", "0930003", "0940002" };

        public GDABackController(IGDARepository repo)
        {
            structCodes = new Dictionary<string, string[]>();
            structCodes.Add("transh", new string[] { "0930001", "0930002", "0930003" });
            structCodes.Add("contribution", new string[] { "0940001", "0940002" });
            _repo = repo;
        }

        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// метод для Kendo (получение списка ...)
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Get_Data([DataSourceRequest] DataSourceRequest request)
        {
            try
            {
                var data = _repo.GetBackProcessTrancheList(request);
                var dataCount = _repo.GetBackProcessTrancheCount(request);
                return Json(new { Data = data, Total = dataCount }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return new HttpStatusCodeResult(500, ex.Message);
            }
        }

        public ActionResult PlacementTranche(int processId, string stateCode, string stateName, string okpo, string nmk)
        {
            string process = processId.ToString(); 

            Kernel.Models.BarsSql sql = SqlCreator.GetTrancheFromDB(process);
            var xmlString = _repo.ExecuteStoreQuery<string>(sql).FirstOrDefault();
            var tranche = _repo.Deserialize<SMBDepositTranche>(xmlString);
            tranche.ProcessId = process;

            ViewBag.ShowAutorizeBtn = true;
            ViewBag.ShowBlockBtn = false;
            ViewBag.ShowUnblockBtn = false;
            ViewBag.StateCode = stateCode;
            ViewBag.StateName = stateName;
            ViewBag.Okpo = okpo;
            ViewBag.Nmk = nmk;

            return View(tranche);
        }

        public ActionResult ReplenishTranche(string processId, string trancheId, string stateCode, string stateName)
        {
            Kernel.Models.BarsSql sql = SqlCreator.GetReplenishTrancheXml(processId, trancheId);
            var xmlString = _repo.ExecuteStoreQuery<string>(sql).FirstOrDefault();
            var tranche = _repo.Deserialize<SMBDepositTranche>(xmlString);

            ViewBag.StateCode = stateCode;
            ViewBag.StateName = stateName;
            return View(tranche);
        }

        public ActionResult EarlyRepaymentTranche(string trancheId, string processId, string stateCode, string stateName)
        {
            Kernel.Models.BarsSql sql = SqlCreator.GetEarlyRepaymentTrancheXml(processId, trancheId);
            var xmlString = _repo.ExecuteStoreQuery<string>(sql).FirstOrDefault();
            var tranche = _repo.Deserialize<SMBDepositTranche>(xmlString);

            ViewBag.StateCode = stateCode;
            ViewBag.StateName = stateName;
            return View(tranche);
        }

        public ActionResult OnDemandTranche(string depositInfo)
        {
            BackDepositDemand model = JsonConvert.DeserializeObject<BackDepositDemand>(depositInfo);

            model.Name = model.Name.Replace("\\_//", "'");
            model.StateName = model.StateName.Replace("\\_//", "'");
            Kernel.Models.BarsSql sql = SqlCreator.GetOnDemandTrancheXml(model.ProcessId);
            var xmlString = _repo.ExecuteStoreQuery<string>(sql).FirstOrDefault();
            var tranche = _repo.Deserialize<SMBDepositOnDemand>(xmlString);

            ViewBag.Dbo = model.Dbo;
            ViewBag.DboDate = model.DboDate;
            ViewBag.Rnk = model.Rnk;
            ViewBag.Okpo = model.Okpo;
            ViewBag.Name = model.Name;
            ViewBag.StateCode = model.StateCode;
            ViewBag.Type = model.Type;
            ViewBag.StateName = model.StateName;
            return View(tranche);
        }

        public ActionResult ConfirmReject(string processId)
        {
            ViewBag.ProcessId = processId;
            ViewBag.IsTranche = true;
            ViewBag.IsOnDemand = false;
            ViewBag.Type = "";
            return View();
        }

        public ActionResult ConfirmRejectOnDemand(string processId, string type)
        {
            ViewBag.ProcessId = processId;
            ViewBag.IsTranche = false;
            ViewBag.IsOnDemand = true;
            ViewBag.Type = type;
            return View("ConfirmReject");
        }

        public ActionResult BlockPlacementTranche(int processId, string stateCode, string stateName, string okpo, string nmk)
        {
            string process = processId.ToString();

            Kernel.Models.BarsSql sql = SqlCreator.GetTrancheFromDB(process);
            var xmlString = _repo.ExecuteStoreQuery<string>(sql).FirstOrDefault();
            var tranche = _repo.Deserialize<SMBDepositTranche>(xmlString);
            ViewBag.ShowAutorizeBtn = false;
            ViewBag.ShowBlockBtn = true;
            ViewBag.ShowUnblockBtn = false;
            ViewBag.StateCode = stateCode;
            ViewBag.StateName = stateName;
            ViewBag.Okpo = okpo;
            ViewBag.Nmk = nmk;
            return View("PlacementTranche", tranche);
        }

        public ActionResult ConfirmBlock(string processId)
        {
            ViewBag.ProcessId = processId;
            return View();
        }

        public ActionResult UnblockPlacementTranche(int processId, string stateCode, string stateName, string okpo, string nmk)
        {
            string process = processId.ToString();

            Kernel.Models.BarsSql sql = SqlCreator.GetTrancheFromDB(process);
            var xmlString = _repo.ExecuteStoreQuery<string>(sql).FirstOrDefault();
            var tranche = _repo.Deserialize<SMBDepositTranche>(xmlString);
            tranche.ProcessId = process;

            ViewBag.ShowAutorizeBtn = false;
            ViewBag.ShowBlockBtn = false;
            ViewBag.ShowUnblockBtn = true;
            ViewBag.StateCode = stateCode;
            ViewBag.StateName = stateName;
            ViewBag.Okpo = okpo;
            ViewBag.Nmk = nmk;
            return View("PlacementTranche", tranche);
        }

        public ActionResult ConfirmUnBlock(string processId)
        {
            ViewBag.ProcessId = processId;
            return View();
        }

        public ActionResult History()
        {
            return View();
        }

        public ActionResult TrancheHistory(string trancheId)
        {
            ViewBag.TranchId = trancheId;
            return View();
        }

        /// <summary>
        /// метод для Kendo (получение списка ...)
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Get_HisoryData([DataSourceRequest]DataSourceRequest request)
        {
            List<BackHistoryTrancheInfo> history = _repo.GetBackHistory();
            DataSourceResult result = history.ToDataSourceResult(request);
            return Json(result);
        }

        [HttpPost]
        public ActionResult Get_HisoryTrancheData([DataSourceRequest]DataSourceRequest request, string trancheId)
        {
            List<BackHistoryTrancheInfo> history = _repo.GetBackTrancheHistory(trancheId);
            DataSourceResult result = history.ToDataSourceResult(request);
            return Json(result);
        }

        public ActionResult GetEAFiles(String rnk, String nls)
        {
            String Kf = _repo.GetKf();
            nls = nls.Substring(0, 4);
            //List<Bars.EAD.Structs.Result.DocumentData> eaDocs = new List<Bars.EAD.Structs.Result.DocumentData> {
            //    new Bars.EAD.Structs.Result.DocumentData{ DocLink = "https://www.google.com", Struct_Code = "0930001", Struct_Name = "test.pdf" },
            //    new Bars.EAD.Structs.Result.DocumentData{ DocLink = "https://translate.google.com", Struct_Code = "0940001", Struct_Name = "test.pdf" },
            //    new Bars.EAD.Structs.Result.DocumentData{ DocLink = "https://microsoft.com", Struct_Code = "0930003", Struct_Name = "test.pdf" },
            //    new Bars.EAD.Structs.Result.DocumentData{ DocLink = "https://www.google.com", Struct_Code = "0930001", Struct_Name = "test.pdf" },
            //    new Bars.EAD.Structs.Result.DocumentData{ DocLink = "https://translate.google.com", Struct_Code = "0940001", Struct_Name = "test.pdf" },
            //    new Bars.EAD.Structs.Result.DocumentData{ DocLink = "https://microsoft.com", Struct_Code = "0930003", Struct_Name = "test.pdf" },
            //    new Bars.EAD.Structs.Result.DocumentData{ DocLink = "https://www.google.com", Struct_Code = "0930001", Struct_Name = "test.pdf" },
            //    new Bars.EAD.Structs.Result.DocumentData{ DocLink = "https://translate.google.com", Struct_Code = "0940001", Struct_Name = "test.pdf" },
            //    new Bars.EAD.Structs.Result.DocumentData{ DocLink = "https://microsoft.com", Struct_Code = "0930003", Struct_Name = "test.pdf" },
            //    new Bars.EAD.Structs.Result.DocumentData{ DocLink = "https://www.google.com", Struct_Code = "0930001", Struct_Name = "test.pdf" },
            //    new Bars.EAD.Structs.Result.DocumentData{ DocLink = "https://translate.google.com", Struct_Code = "0940001", Struct_Name = "test.pdf" },
            //    new Bars.EAD.Structs.Result.DocumentData{ DocLink = "https://microsoft.com", Struct_Code = "0930003", Struct_Name = "test.pdf" }
            //};

            List<Bars.EAD.Structs.Result.DocumentData> eaDocs = EADService.GetDocumentData("", Convert.ToDecimal(rnk), null, null, null, null, null, null, null, Kf);
            eaDocs = eaDocs.Where(x => !String.IsNullOrEmpty(x.DocLink) && !String.IsNullOrEmpty(x.Struct_Name)).ToList();

            if (nls == "2610" || nls == "2651")
                eaDocs = eaDocs.Where(x => structCodes["transh"].Contains(x.Struct_Code)).ToList();
            else if(nls == "2600" || nls == "2650")
                eaDocs = eaDocs.Where(x => structCodes["contribution"].Contains(x.Struct_Code)).ToList();

            return View(eaDocs);
        }
    }
}